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

  double width = 0;
  double width3 = 0;
  double width2 = 0;

  /// Mapping for API income values
  final Map<String, String> incomeMap = {
    "<1 lakh": "le_1_Lakh",
    "1 Lakh - 5 Lakh": "1_5_Lakh",
    "5 Lakh - 10 Lakh": "5_10_Lakh",
    "10 Lakh - 25 Lakh": "10_25_Lakh",
    "25 Lakh - 1 Crore": "25_1_Cr",
    "More than 1 CR": "Ge_1_Cr",
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
        selectedIncome = incomeMap[value] ?? value;
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
      "annual_income": selectedIncome,
      // "trading_exp": selectedExperience,
      "settlement": selectedSettlement,
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

      Navigator.of(context).pop(); // Close loading

      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

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
    width = MediaQuery.of(context).size.width / 2 - 20;
    width2 = MediaQuery.of(context).size.width / 2 - 32;
    width3 = MediaQuery.of(context).size.width / 3 - 15;
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

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

            /// ✅ TRADING EXPERIENCE SELECTION
            Text(
              "Trading Experience",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSelectableChip(
                    "experience", "No experience", width2, isDark),
                _buildSelectableChip("experience", "<1 year", width2, isDark),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSelectableChip("experience", "1-5 years", width2, isDark),
                _buildSelectableChip(
                    "experience", "5-10 years", width2, isDark),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildSelectableChip("experience", "10+ years", width2, isDark),
              ],
            ),
            SizedBox(height: 18.h),

            /// ✅ INCOME SELECTION
            Text(
              "Income",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSelectableChip("income", "<1 lakh", width3, isDark),
                _buildSelectableChip(
                    "income", "1 Lakh - 5 Lakh", width3, isDark),
                _buildSelectableChip(
                    "income", "5 Lakh - 10 Lakh", width3, isDark),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSelectableChip(
                    "income", "10 Lakh - 25 Lakh", width3, isDark),
                _buildSelectableChip(
                    "income", "25 Lakh - 1 Crore", width3, isDark),
                _buildSelectableChip(
                    "income", "More than 1 CR", width3, isDark),
              ],
            ),
            SizedBox(height: 10.h),
            Text("Settlement Preference",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
            SizedBox(height: 12.h),
            Row(
              children: [
                _buildChip("settlement", "Monthly",
                    width: 106.w, isDark: isDark),
                SizedBox(width: 16.w),
                _buildChip("settlement", "Quarterly",
                    width: 106.w, isDark: isDark),
              ],
            ),
            const Spacer(),
            constWidgets.greenButton(
              "Continue",
              onTap: isFormComplete ? submitDetails : null,
            ),
            SizedBox(height: 10.h),
            Center(child: constWidgets.needHelpButton(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String category, String value,
      {double? width, required bool isDark}) {
    final isSelected =
        (category == "experience" && selectedExperience == value) ||
            (category == "income" && selectedIncome == incomeMap[value]) ||
            (category == "settlement" && selectedSettlement == value);

    return InkWell(
      onTap: () => _selectOption(category, value),
      child: constWidgets.choiceChip(
        value,
        isSelected,
        context,
        width ?? 140.w,
        isDark,
      ),
    );
  }

  Widget _buildSelectableChip(
      String category, String value, double width, bool isDark) {
    final isSelected =
        (category == "experience" && selectedExperience == value) ||
            (category == "income" && selectedIncome == incomeMap[value]);

    return InkWell(
      onTap: () => _selectOption(category, value),
      child: constWidgets.choiceChip(value, isSelected, context, width, isDark),
    );
  }
}
