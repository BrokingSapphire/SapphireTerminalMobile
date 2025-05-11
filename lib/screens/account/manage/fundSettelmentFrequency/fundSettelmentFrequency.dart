import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/utils/constWidgets.dart';

class fundSettelmentFrequency extends StatefulWidget {
  const fundSettelmentFrequency({super.key});

  @override
  State<fundSettelmentFrequency> createState() =>
      _fundSettelmentFrequencyState();
}

class _fundSettelmentFrequencyState extends State<fundSettelmentFrequency> {
  int selectedIndex = 0;
  String selectedDocument = "PAN Card";
  final List<String> options = [
    "90 days",
    "30 days",
    "Bill to Bill settlement",
  ];
  final List<String> descriptions = [
    "Unused funds will be transfered to your bank account on the first Friday of every quarter",
    "Unused funds will be transfered to your bank account on the first Friday of every quarter",
    "Unused funds will be transfered to your bank account on the first Friday of every quarter",
  ];

  void _showIncomeProofBottomSheet(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                color: isDark ? Color(0xff121413) : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upload Income Proof",
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Divider(
                    color: Color(0xFF2F2F2F),
                    thickness: 1,
                  ),
                  SizedBox(height: 16.h),
                  // Document Selection
                  Text(
                    "Select Document",
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: isDark ? Color(0xff121413) : Color(0xFFF4F4F9),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: isDark ? Color(0xFF2F2F2F) : Color(0xFFE5E7EB),
                        width: 1,
                      ),
                    ),
                    child: DropdownButton<String>(
                      value: selectedDocument,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      isExpanded: true,
                      dropdownColor: isDark ? Color(0xff121413) : Colors.white,
                      underline: SizedBox(),
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 14.sp,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDocument = newValue!;
                        });
                      },
                      items: <String>[
                        'PAN Card',
                        'Aadhar Card',
                        'Passport',
                        'Driving License'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Upload document section
                  Text(
                    "Upload document",
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(8.r),
                    dashPattern: [8, 6],
                    color: isDark
                        ? const Color(0xFF2F2F2F)
                        : const Color(0xFFE5E7EB),
                    strokeWidth: 1,
                    child: Container(
                      height: 120.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.transparent, // optional background
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/svgs/update.svg",
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  "Upload a file or ",
                                  style: TextStyle(
                                    color: isDark ? Colors.white : Colors.black,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                Text(
                                  "Choose file",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Continue button
                  constWidgets.greenButton("Continue"),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        // or your desired color
        elevation: 0,
        scrolledUnderElevation: 0,
        // prevent shadow when scrolling
        surfaceTintColor: Colors.transparent,
        leadingWidth: 32.w,

        title: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            "Fund Settelment Frequency",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
                color: isDark ? Colors.white : Colors.black),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black,
              )),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Divider(
              color: Color(0xFF2F2F2F),
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    child: Text(
                      "Funds available in your Sapphire account will be trasferred to your registered bank account based on the selection made below",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Column(
                    children: List.generate(options.length, (index) {
                      bool selected = selectedIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 6.h),
                          padding: EdgeInsets.symmetric(
                              vertical: 6.h, horizontal: 12.w),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Custom radio
                              Container(
                                margin: EdgeInsets.only(top: 2.h, right: 14.w),
                                width: 16.w,
                                height: 16.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selected
                                      ? Color(0xFF1DB954)
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: selected
                                        ? Color(0xFF1DB954)
                                        : Color(0xff2f2f2f),
                                    width: 2,
                                  ),
                                ),
                                child: selected
                                    ? Center(
                                        child: Container(
                                          width: 8.w,
                                          height: 8.w,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF121413),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      options[index],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      descriptions[index],
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 345.h),
                  // Spacer(),
                  constWidgets.greenButton("Proceed", onTap: () {
                    _showIncomeProofBottomSheet(context);
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
