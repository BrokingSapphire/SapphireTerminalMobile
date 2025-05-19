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
                fontSize: 17.sp,
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
                    // _showIncomeProofBottomSheet(context);
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
