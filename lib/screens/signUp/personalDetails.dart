import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/signUp/tradingExperienceScreen.dart';
import 'package:sapphire/screens/signUp/yourInvestmentProfile.dart';
import '../../utils/constWidgets.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  double width = 0;
  String? selectedOccupation;
  bool isPoliticallyExposed = false;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  bool get isFormComplete => selectedOccupation != null;

  void _selectOccupation(String value) {
    setState(() => selectedOccupation = value);
  }

  Future<void> submitOccupationDetails() async {
    final token = await secureStorage.read(key: 'auth_token');
    if (token == null) {
      constWidgets.snackbar("Token not found", Colors.red, context);
      return;
    }

    final url = Uri.parse(
        "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint");

    final body = {
      "step": "occupation",
      "occupation": selectedOccupation,
      "politically_exposed": isPoliticallyExposed
    };

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
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

      Navigator.of(context).pop(); // Close loader

      print("🔁 Response Status: ${response.statusCode}");
      print("📨 Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        constWidgets.snackbar(
            "Occupation details saved", Colors.green, context);
        navi(tradingExperinceScreen(), context);
      } else {
        final msg = jsonDecode(response.body)?["error"]?["message"] ??
            "Something went wrong";
        constWidgets.snackbar(msg, Colors.red, context);
      }
    } catch (e) {
      Navigator.of(context).pop();
      constWidgets.snackbar("Error: $e", Colors.red, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    width = MediaQuery.of(context).size.width / 3 - 20;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              constWidgets.topProgressBar(1, 4, context),
              SizedBox(height: 24.h),
              Text("Occupation",
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 16.h),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  "Student",
                  "Govt. Servant",
                  "Retired",
                  "Private Sector",
                  "Agriculturist",
                  "Self Employed",
                  "Housewife",
                  "Other"
                ]
                    .map((item) => InkWell(
                          onTap: () => _selectOccupation(item),
                          child: constWidgets.choiceChip(
                              item,
                              selectedOccupation == item,
                              context,
                              width,
                              isDark),
                        ))
                    .toList(),
              ),
              SizedBox(height: 25.h),
              Text("Are you a Politically Exposed Person (PEP)?",
                  style: TextStyle(fontSize: 16.sp)),
              SizedBox(height: 12.h),
              Row(
                children: [
                  InkWell(
                    onTap: () => setState(() => isPoliticallyExposed = true),
                    child: constWidgets.choiceChip(
                        "Yes", isPoliticallyExposed, context, 82.w, isDark),
                  ),
                  SizedBox(width: 20.w),
                  InkWell(
                    onTap: () => setState(() => isPoliticallyExposed = false),
                    child: constWidgets.choiceChip(
                        "No", !isPoliticallyExposed, context, 82.w, isDark),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 52.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isFormComplete ? submitOccupationDetails : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isFormComplete ? Color(0xFF1DB954) : Color(0xff2f2f2f),
                  foregroundColor: Colors.white,
                ),
                child: Text("Continue",
                    style: TextStyle(
                        fontSize: 17.sp, fontWeight: FontWeight.w600)),
              ),
            ),
            SizedBox(height: 10.h),
            Center(child: constWidgets.needHelpButton(context)),
          ],
        ),
      ),
    );
  }
}
