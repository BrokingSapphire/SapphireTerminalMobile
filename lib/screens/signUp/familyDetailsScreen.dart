import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sapphire/screens/signUp/personalDetails.dart';
import '../../main.dart';
import '../../utils/constWidgets.dart';

class FamilyDetailsScreen extends StatefulWidget {
  const FamilyDetailsScreen({super.key});

  @override
  State<FamilyDetailsScreen> createState() => _FamilyDetailsScreenState();
}

class _FamilyDetailsScreenState extends State<FamilyDetailsScreen> {
  TextEditingController fathersName = TextEditingController();
  TextEditingController mothersName = TextEditingController();
  bool _isGray = true;
  double width = 0;
  String? selectedMaritalStatus = "Single"; // ✅ Default selected
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  bool get isFormComplete =>
      fathersName.text.trim().isNotEmpty &&
      mothersName.text.trim().isNotEmpty &&
      selectedMaritalStatus != null;

  @override
  void initState() {
    super.initState();
    fathersName.addListener(_checkFields);
    mothersName.addListener(_checkFields);
  }

  void _checkFields() {
    setState(() {
      _isGray =
          fathersName.text.trim().isEmpty || mothersName.text.trim().isEmpty;
    });
  }

  Future<void> submitFamilyDetails() async {
    final token = await secureStorage.read(key: 'auth_token');
    final uri = Uri.parse(
        "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint");

    final body = {
      "step": "user_detail",
      "marital_status": selectedMaritalStatus,
      "father_name": fathersName.text.trim(),
      "mother_name": mothersName.text.trim(),
    };

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          Center(child: CircularProgressIndicator(color: Color(0xFF1DB954))),
    );

    try {
      final response = await http.post(
        uri,
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(body),
      );

      Navigator.of(context).pop(); // Close loader

      if (response.statusCode == 200 || response.statusCode == 201) {
        constWidgets.snackbar("Family details saved", Colors.green, context);
        navi(PersonalDetails(), context);
      } else {
        final msg = jsonDecode(response.body)?["error"]?["message"] ??
            "Something went wrong!";
        constWidgets.snackbar(msg, Colors.red, context);
      }
    } catch (e) {
      Navigator.of(context).pop();
      constWidgets.snackbar("Error submitting data: $e", Colors.red, context);
    }
  }

  @override
  void dispose() {
    fathersName.removeListener(_checkFields);
    mothersName.removeListener(_checkFields);
    fathersName.dispose();
    mothersName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width / 3 - 20;
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              constWidgets.topProgressBar(1, 4, context),
              SizedBox(height: 24.h),
              Text("Enter your parent’s name",
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600)),
              SizedBox(height: 16.h),
              constWidgets.textField("Father's Name", fathersName),
              SizedBox(height: 16.h),
              constWidgets.textField("Mother's Name", mothersName),
              SizedBox(height: 20.h),
              Text("Marital Status",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSelectableChip("Single"),
                  _buildSelectableChip("Married"),
                  _buildSelectableChip("Divorced"),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 52.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isGray ? null : () => submitFamilyDetails(),
                child: Text("Continue",
                    style: TextStyle(
                        fontSize: 17.sp, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isGray ? Color(0xff2f2f2f) : Color(0xFF1DB954),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Color(0xff2f2f2f),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Center(child: constWidgets.needHelpButton(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectableChip(String value) {
    final isSelected = selectedMaritalStatus == value;
    return InkWell(
      onTap: () => setState(() => selectedMaritalStatus = value),
      child: constWidgets.choiceChip(value, isSelected, context, width),
    );
  }
}
