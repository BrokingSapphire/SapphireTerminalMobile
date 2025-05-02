import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/utils/constWidgets.dart';

/// Shows a modal bottom sheet for bank account selection
/// Allows the user to choose from available bank accounts
void showBankSelectionBottomSheet({
  required BuildContext context,
  required List<Map<String, String>> banks,
  required String? selectedBank,
  required Function(String) onBankSelected,
}) {
  final bool isDark = Theme.of(context).brightness == Brightness.dark;
  final backgroundColor = Color(0xff121413);
  final borderColor = isDark ? Color(0xff2F2F2F) : Colors.grey.shade300;
  final textColor = isDark ? Colors.white : Colors.black;

  showModalBottomSheet(
    context: context,
    backgroundColor: backgroundColor,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
      ),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
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
                    shrinkWrap: true,
                    itemCount: banks.length,
                    itemBuilder: (context, index) {
                      final bank = banks[index];
                      final isSelected = selectedBank == 'bank_$index';
                      final bankName = index == 1
                          ? 'Kotak Mahindra Bank'
                          : bank['name'] ?? '';
                      final accountNumber =
                          index == 1 ? 'XXXX XXXX 2662' : bank['details'] ?? '';

                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedBank = 'bank_$index';
                              });
                              Future.delayed(Duration(milliseconds: 200), () {
                                onBankSelected('bank_$index');
                                Navigator.pop(context);
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.w, vertical: 12.h),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/icici.png",
                                    width: 24.w,
                                    height: 24.h,
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          bankName,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: textColor,
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          accountNumber,
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
                                  CustomRadioButton(
                                    isSelected: isSelected,
                                    onTap: () {
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
