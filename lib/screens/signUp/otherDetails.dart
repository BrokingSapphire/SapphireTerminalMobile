import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sapphire/screens/signUp/linkBankScreen.dart';
import '../../utils/constWidgets.dart';
import '../../main.dart';

class Otherdetails extends StatefulWidget {
  const Otherdetails({super.key});

  @override
  State<Otherdetails> createState() => _OtherdetailsScreenState();
}

class _OtherdetailsScreenState extends State<Otherdetails> {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  String? selectedExperience;
  String? selectedIncome;
  String? selectedSettlement;

  String? selectedPEP;
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

  String? selectedOccupation;

  void _selectOccupation(String value) {
    setState(() => selectedOccupation = value);
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
              "Other Details",
              style: TextStyle(fontSize: 21.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16.h),

            /// Trading Experience

            Text("Occupation",
                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500)),
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
                            chipWidth,
                            isDark),
                      ))
                  .toList(),
            ),
            SizedBox(height: 24.h),

            /// Settlement Preference
            Text(
              "Are you a Politically Exposed Person (PEP)?",
              style: TextStyle(fontSize: 17.sp, color: Color(0xffEBEEF5)),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildSelectableChip("PEP", "Yes", 106.w),
                SizedBox(width: 20.w),
                _buildSelectableChip("PEP", "No", 106.w),
              ],
            ),
            const Spacer(),

            /// Continue Button
            // constWidgets.greenButton(
            //   "Continue",
            //   onTap: isFormComplete ? submitDetails : null,
            // ),
            constWidgets.greenButton('Continue'),
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

  Widget _buildSelectableChip(String category, String value, double width) {
    bool isSelected =
        (category == "Settlement" && selectedSettlement == value) ||
            (category == "PEP" && selectedPEP == value);

    return InkWell(
      onTap: () => _selectOption(category, value),
      child: constWidgets.choiceChip(value, isSelected, context, width, true),
    );
  }
}
