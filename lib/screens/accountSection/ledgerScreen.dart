import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LedgerScreen extends StatefulWidget {
  const LedgerScreen({super.key});

  @override
  State<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends State<LedgerScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.black, // or your desired color
        elevation: 0,
        scrolledUnderElevation: 0, // prevent shadow when scrolling
        surfaceTintColor: Colors.transparent,
        leadingWidth: 32.w,

        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Two Factor Authentication",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
      ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Divider(color: Color(0xff2F2F2F)), // Full-width divider
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 11.h),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                        color: Color(0xff121413),
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
                                          color: Color(0xffc9cacc),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      "₹0",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                      ),
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
                                          color: Color(0xffc9cacc),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      "₹1,00,000",
                                      style: TextStyle(
                                        fontSize: 13.sp,
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
                                          color: Color(0xffc9cacc),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      "₹192,32,234",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                      ),
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
                                          color: Color(0xffc9cacc),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      "₹1,00,000",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                      ),
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
                              style: TextStyle(fontSize: 13.sp),
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
              Divider(color: Color(0xff2F2F2F)), // Full-width divider
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Transactions",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 17.sp),
                    ),
                    Container(
                      height: 48.h,
                      width: 48.w,
                      decoration: BoxDecoration(
                        color: Color(0xFF121413),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Image.asset(
                        'assets/icons/filter.png',
                        scale: 2,
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 6.h),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20.r,
                              backgroundColor: Color(0xFF26382F),
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
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    "Journal Entry • 15 Feb 2025 ",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xffC9CACC)),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "-₹23.58",
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Color(0xff2F2F2F)), // Full-width divider
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
