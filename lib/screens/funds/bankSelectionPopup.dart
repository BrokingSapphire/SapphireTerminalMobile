// File: bankSelectionPopup.dart
// Description: Modal bottom sheet for bank account selection in the Sapphire Trading application.
// This component allows users to select from their linked bank accounts when making transactions.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/utils/constWidgets.dart';

/// Shows a modal bottom sheet for bank account selection
/// Allows the user to choose from available bank accounts
/// 
/// Parameters:
/// - context: The BuildContext for displaying the bottom sheet
/// - banks: List of bank accounts with details like name and account number
/// - selectedBank: Currently selected bank (if any)
/// - onBankSelected: Callback function triggered when a bank is selected
void showBankSelectionBottomSheet({
  required BuildContext context,
  required List<Map<String, String>> banks,
  required String? selectedBank,
  required Function(String) onBankSelected,
}) {
  // Determine theme colors based on current brightness mode
  final bool isDark = Theme.of(context).brightness == Brightness.dark;
  final backgroundColor = Color(0xff121413);
  final borderColor = isDark ? Color(0xff2F2F2F) : Colors.grey.shade300;
  final textColor = isDark ? Colors.white : Colors.black;

  showModalBottomSheet(
    context: context,
    backgroundColor: backgroundColor,
    isScrollControlled: true, // Allows the sheet to expand beyond default height
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
      ),
    ),
    builder: (context) {
      // StatefulBuilder allows updating the selected bank state within the bottom sheet
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7, // Limit to 70% of screen height
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with title and close button
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Choose a Bank Account',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      // Close button to dismiss the bottom sheet
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.close,
                          color: textColor,
                          size: 24.w,
                        ),
                      ),
                    ],
                  ),
                ),

                // List of bank accounts
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true, // Makes the list take only the space it needs
                    itemCount: banks.length,
                    itemBuilder: (context, index) {
                      // Extract bank data for current item
                      final bank = banks[index];
                      final isSelected = selectedBank == 'bank_$index';

                      // Special case for index 1 (hardcoded for Kotak Mahindra Bank)
                      // TODO: Replace hardcoded values with dynamic data from API
                      final bankName = index == 1
                          ? 'Kotak Mahindra Bank'
                          : bank['name'] ?? '';
                      final accountNumber =
                      index == 1 ? 'XXXX XXXX 2662' : bank['details'] ?? '';

                      return Column(
                        children: [
                          // Bank item - includes logo, bank name, account number, and selection radio
                          GestureDetector(
                            onTap: () {
                              // Update selected bank in the bottom sheet state
                              setState(() {
                                selectedBank = 'bank_$index';
                              });
                              // Add slight delay before closing the sheet for better UX
                              Future.delayed(Duration(milliseconds: 200), () {
                                onBankSelected('bank_$index'); // Call the callback with selected bank ID
                                Navigator.pop(context); // Close the bottom sheet
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.w, vertical: 12.h),
                              child: Row(
                                children: [
                                  // Bank logo
                                  Image.asset(
                                    "assets/images/icici.png", // Bank logo image
                                    width: 24.w,
                                    height: 24.h,
                                  ),
                                  SizedBox(width: 16.w),
                                  // Bank name and account number details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          bankName, // Bank name display
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: textColor,
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          accountNumber, // Masked account number 
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: isDark
                                                ? Colors.grey
                                                : Colors.grey.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Custom radio button for selection
                                  CustomRadioButton(
                                    isSelected: isSelected,
                                    onTap: () {
                                      // Update selected bank and handle selection
                                      setState(() {
                                        selectedBank = 'bank_$index';
                                      });
                                      Future.delayed(
                                          Duration(milliseconds: 200), () {
                                        onBankSelected('bank_$index');
                                        Navigator.pop(context);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Divider between bank items (except after the last item)
                          if (index < banks.length - 1)
                            Divider(
                                height: 1,
                                color: borderColor,
                                indent: 24.w,
                                endIndent: 24.w),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}