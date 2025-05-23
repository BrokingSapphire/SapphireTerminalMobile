import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/utils/filters.dart';

class LedgerScreen extends StatefulWidget {
  const LedgerScreen({super.key});

  @override
  State<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends State<LedgerScreen> {
  String amountStr = "-23.58";

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
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Ledger",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17.sp,
                color: isDark ? Colors.white : Colors.black),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back,
                  color: isDark ? Colors.white : Colors.black)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 11.h),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: isDark ? Color(0xff121413) : Color(0xffF4F4F9),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Opening Balance",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: isDark
                                            ? Color(0xffc9cacc)
                                            : Color(0xff6B7280),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "₹0",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Closing Balance",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: isDark
                                            ? Color(0xffc9cacc)
                                            : Color(0xff6B7280),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "₹1,00,000",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color:
                                          isDark ? Colors.white : Colors.black,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Credit",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: isDark
                                            ? Color(0xffc9cacc)
                                            : Color(0xff6B7280),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "₹192,32,234",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Closing Debit",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: isDark
                                            ? Color(0xffc9cacc)
                                            : Color(0xff6B7280),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "₹1,00,000",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Statement for",
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: isDark
                                  ? Color(0xffc9cacc)
                                  : Color(0xff6B7280),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "10 Feb 2025 - 17 Feb 2025",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        size: 24.sp,
                        Icons.calendar_today_outlined,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
            Divider(
                color: isDark
                    ? Color(0xff2F2F2F)
                    : Color(0xffD1D5DB)), // Full-width divider
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Transactions",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17.sp,
                        color: isDark ? Colors.white : Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      showFilterBottomSheet(
                          context: context,
                          pageKey: 'ledger',
                          onApply: (filters) {},
                          isDark: isDark);
                    },
                    child: Container(
                      height: 48.h,
                      width: 48.w,
                      decoration: BoxDecoration(
                        color: isDark ? Color(0xFF121413) : Color(0xFFF4F4F9),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Image.asset(
                        'assets/icons/filter.png',
                        color: isDark ? Color(0xffC9CACC) : Color(0xff6B7280),
                        scale: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Column(
              children: List.generate(6, (int index) {
                return Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20.r,
                            backgroundColor: isDark
                                ? Color(0xFF26382F)
                                : Colors.green.withOpacity(0.5),
                            child: Icon(Icons.cached_outlined,
                                color: Color(0xFF1DB954)),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pledge/Unpledge charges",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: isDark
                                          ? Color(0xffEBEEF5)
                                          : Color(0xff1A1A1A)),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  "Journal Entry • 15 Feb 2025 ",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: isDark
                                          ? Color(0xffC9CACC)
                                          : Color(0xff6B7280)),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            amountStr,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: amountStr.contains('+')
                                  ? Colors.green
                                  : isDark
                                      ? Color(0xffFFFFFF)
                                      : Color(0xff1A1A1A), // fallback color
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                        color: isDark
                            ? Color(0xff2F2F2F)
                            : Color(0xffD1D5DB)), // Full-width divider
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
