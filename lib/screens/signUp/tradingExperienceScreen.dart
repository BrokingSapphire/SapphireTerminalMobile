import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sapphire/screens/signUp/linkBankScreen.dart';
import '../../utils/constWidgets.dart';
import '../../main.dart';

class tradingExperinceScreen extends StatefulWidget {
  const tradingExperinceScreen({super.key});

  @override
  State<tradingExperinceScreen> createState() => _tradingExperinceScreenState();
}

class _tradingExperinceScreenState extends State<tradingExperinceScreen> {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  String? selectedExperience;
  String? selectedIncome;
  String? selectedSettlement;

  final Map<String, String> incomeMap = {
    "<1 Lakh": "le_1_Lakh",
    "1 Lakh - 5 Lakh": "1_5_Lakh",
    "5 Lakh - 10 Lakh": "5_10_Lakh",
    "10 Lakh - 25 Lakh": "10_25_Lakh",
    "25 Lakh - 1 Crore": "25_1_Cr",
    "> 1 Crore": "Ge_1_Cr",
  };

  bool get isFormComplete =>
      selectedExperience != null &&
      selectedIncome != null &&
      selectedSettlement != null;

  void _selectOption(String category, String value) {
    setState(() {
      if (category == "experience") {
        selectedExperience = value;
      } else if (category == "income") {
        selectedIncome = value;
      } else if (category == "settlement") {
        selectedSettlement = value;
      }
    });
  }

  Future<void> submitDetails() async {
    final token = await secureStorage.read(key: 'auth_token');

    final url = Uri.parse(
        "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint");

    final body = {
      "step": "account_detail",
      "annual_income": incomeMap[selectedIncome] ?? selectedIncome,
      "settlement": selectedSettlement,
    };

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

      Navigator.of(context).pop(); // Close loading

      if (response.statusCode == 200 || response.statusCode == 201) {
        constWidgets.snackbar("Account details saved!", Colors.green, context);
        navi(linkBankScreen(), context);
      } else {
        final msg = jsonDecode(response.body)['error']?['message'] ??
            'Failed to save details';
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
    double chipWidth = MediaQuery.of(context).size.width / 3 - 20;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            constWidgets.topProgressBar(1, 4, context),
            SizedBox(height: 24.h),
            Text(
              "Your Investment Profile",
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16.h),

            /// Trading Experience
            Text(
              "Trading Experience",
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: [
                _buildChip("experience", "No experience", chipWidth, isDark),
                _buildChip("experience", "< 1 year", chipWidth, isDark),
                _buildChip("experience", "1-5 years", chipWidth, isDark),
                _buildChip("experience", "5-10 years", chipWidth, isDark),
                _buildChip("experience", "10+ years", chipWidth, isDark),
              ],
            ),
            SizedBox(height: 24.h),

            /// Income
            Text(
              "Annual Income",
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: [
                _buildChip("income", "<1 Lakh", chipWidth, isDark),
                _buildChip("income", "1 Lakh - 5 Lakh", chipWidth, isDark),
                _buildChip("income", "5 Lakh - 10 Lakh", chipWidth, isDark),
                _buildChip("income", "10 Lakh - 25 Lakh", chipWidth, isDark),
                _buildChip("income", "25 Lakh - 1 Crore", chipWidth, isDark),
                _buildChip("income", "> 1 Crore", chipWidth, isDark),
              ],
            ),
            SizedBox(height: 24.h),

            /// Settlement Preference
            Text(
              "Running Settlement Preference",
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 12.w,
              children: [
                _buildChip("settlement", "Monthly", chipWidth, isDark),
                _buildChip("settlement", "Quarterly", chipWidth, isDark),
              ],
            ),
            const Spacer(),

            /// Continue Button
            // constWidgets.greenButton(
            //   "Continue",
            //   onTap: isFormComplete ? submitDetails : null,
            // ),
            Container(
              height: 52.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Continue",
                  style:
                      TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor:
                      isFormComplete ? Color(0xFF1DB954) : Color(0xff2f2f2f),
                ),
              ),
            ),
            SizedBox(height: 10.h),

            /// Need Help Button
            Center(child: constWidgets.needHelpButton(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String category, String value, double width, bool isDark) {
    final bool isSelected =
        (category == "experience" && selectedExperience == value) ||
            (category == "income" && selectedIncome == value) ||
            (category == "settlement" && selectedSettlement == value);

    return InkWell(
      onTap: () => _selectOption(category, value),
      child: constWidgets.choiceChip(
        value,
        isSelected,
        context,
        width,
        isDark,
      ),
    );
  }
}
