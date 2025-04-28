import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';
import '../../utils/constWidgets.dart';
import 'eSignScreen.dart';

class NomineeDetailsScreen extends StatefulWidget {
  @override
  _NomineeDetailsScreenState createState() => _NomineeDetailsScreenState();
}

class _NomineeDetailsScreenState extends State<NomineeDetailsScreen> {
  List<Map<String, dynamic>> nominees = [
    {
      "nameController": TextEditingController(),
      "panController": TextEditingController(),
      "relation": null,
      "share": 100.0,
    }
  ];

  final List<String> relations = [
    "Father",
    "Mother",
    "Son",
    "Daughter",
    "Sister",
    "Brother",
    "Spouse",
    "Other"
  ];

  void _addNominee() {
    setState(() {
      int totalNominees = nominees.length + 1;
      double newShare = 100 / totalNominees;

      for (var nominee in nominees) {
        nominee["share"] = newShare;
      }

      nominees.add({
        "nameController": TextEditingController(),
        "panController": TextEditingController(),
        "relation": null,
        "share": newShare,
      });
    });
  }

  void _deleteNominee(int index) {
    if (nominees.length > 1) {
      setState(() {
        double removedShare = nominees[index]["share"];
        nominees.removeAt(index);

        if (nominees.isNotEmpty) {
          double additionalShare = removedShare / nominees.length;
          for (var nominee in nominees) {
            nominee["share"] += additionalShare;
          }
        }
      });
    }
  }

  void _adjustShare(int index, double newValue) {
    setState(() {
      double totalShare = 100.0;
      double remainingShare = totalShare - newValue;
      nominees[index]["share"] = newValue;

      double sumOtherShares = 0;
      for (int i = 0; i < nominees.length; i++) {
        if (i != index) sumOtherShares += nominees[i]["share"];
      }

      for (int i = 0; i < nominees.length; i++) {
        if (i != index) {
          double proportionalShare =
              (nominees[i]["share"] / sumOtherShares) * remainingShare;
          nominees[i]["share"] = proportionalShare;
        }
      }
    });
  }

  void _selectRelation(int index) {
    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          height: 450.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nominee is my",
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10.h),
              Expanded(
                child: ListView.separated(
                  itemCount: relations.length,
                  separatorBuilder: (context, i) => Divider(
                    height: 1.h,
                    color: Color(0xff2f2f2f),
                  ),
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          nominees[index]["relation"] = relations[i];
                        });
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 15.h),
                        child: Text(relations[i],
                            style: TextStyle(
                                fontSize: 18.sp, color: Colors.white)),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _submitNominees() async {
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final token = await secureStorage.read(key: 'auth_token');

    final List<Map<String, dynamic>> nomineePayload = nominees.map((nominee) {
      return {
        "name": nominee["nameController"].text.trim(),
        "gov_id": nominee["panController"].text.trim(),
        "relation": nominee["relation"] ?? "",
        "share": nominee["share"].toInt()
      };
    }).toList();

    final body = {"step": "add_nominees", "nominees": nomineePayload};

    final url = Uri.parse(
      "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint",
    );

    print("[DEBUG] Payload: ${jsonEncode(body)}");

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: Color(0xFF1DB954)),
      ),
    );

    try {
      final response = await http.post(
        url,
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      Navigator.of(context).pop();

      print("[DEBUG] Status: ${response.statusCode}");
      print("[DEBUG] Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        constWidgets.snackbar(
            "Nominees added successfully!", Colors.green, context);
        navi(eSignScreen(), context);
      } else {
        final msg = jsonDecode(response.body)['error']?['message'] ??
            'Something went wrong.';
        constWidgets.snackbar(msg, Colors.red, context);
      }
    } catch (e) {
      Navigator.of(context).pop();
      print("[EXCEPTION] $e");
      constWidgets.snackbar("Error: $e", Colors.red, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 46,
        leading: Padding(
          padding: EdgeInsets.only(left: 0),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                SizedBox(height: 8.h),
                constWidgets.topProgressBar(1, 8, context),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Nominee",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () => navi(eSignScreen(), context),
                      child: Text("Skip",
                          style:
                              TextStyle(color: Colors.green, fontSize: 16.sp)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: nominees.length,
              itemBuilder: (context, index) {
                return _buildNomineeCard(index, isDark);
              },
            ),
          ),
          _buildAddNomineeButton(),
          SizedBox(height: 20.h),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            constWidgets.greenButton("Continue", onTap: _submitNominees),
            SizedBox(height: 10.h),
            Center(child: constWidgets.needHelpButton(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildNomineeCard(int index, bool isDark) {
    return Container(
      // margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Nominee ${index + 1}",
                  style: TextStyle(color: Colors.white, fontSize: 17.sp)),
              if (nominees.length > 1)
                IconButton(
                  icon: Icon(Icons.close, color: Colors.green, size: 22.sp),
                  onPressed: () => _deleteNominee(index),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          constWidgets.textField("Name", nominees[index]["nameController"],
              isDark: isDark),
          SizedBox(height: 12.h),
          constWidgets.textField(
              "Nominee PAN", nominees[index]["panController"],
              isDark: isDark),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: () => _selectRelation(index),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(color: Colors.grey.shade700),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    nominees[index]["relation"] ?? "Relation",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                  Icon(Icons.arrow_drop_down, color: Colors.white),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("% Share",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold)),
              Container(
                width: 40.w,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text("${nominees[index]["share"].toInt()}%",
                      style: TextStyle(color: Colors.white, fontSize: 14.sp)),
                ),
              ),
            ],
          ),
          _buildShareSlider(index),
          SizedBox(height: 24.h),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildShareSlider(int index) {
    return Slider(
      value: nominees[index]["share"],
      min: 0,
      max: 100,
      activeColor: Colors.green,
      inactiveColor: Colors.white,
      onChanged: (value) => _adjustShare(index, value),
    );
  }

  Widget _buildAddNomineeButton() {
    return GestureDetector(
      onTap: _addNominee,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, color: Colors.white, size: 20.sp),
          SizedBox(width: 5.w),
          Text("Add Nominee",
              style: TextStyle(color: Colors.white, fontSize: 16.sp)),
        ],
      ),
    );
  }
}
