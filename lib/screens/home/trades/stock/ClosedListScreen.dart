import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class closedGridScreen extends StatefulWidget {
  const closedGridScreen({super.key});

  @override
  State<closedGridScreen> createState() => _closedGridScreenState();
}

class _closedGridScreenState extends State<closedGridScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 6.h,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: Color(0xff121413),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 14.r,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/reliance logo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'RELIANCE',
                                    style: TextStyle(
                                      color: Color(0xffEBEEF5),
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6.h, vertical: 2.w),
                                    decoration: BoxDecoration(
                                      color: Color(0xff143520),
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    child: Text(
                                      'BUY',
                                      style: TextStyle(
                                        color: Color(0xff22a06b),
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Reliance Industries Ltd.',
                                style: TextStyle(color: Color(0xffEBEEF5), fontSize: 11.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Status",
                            style: TextStyle(color: Color(0xffEBEEF5), fontSize: 13.sp),
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Color(0xff69686230),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              'Target Miss',
                              style: TextStyle(
                                color: Color(0xffFFD761),
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  tradeDetailRow('Entry', '₹1,580.60', '14 Feb 2025 |', ' 8:32 pm'),
                  SizedBox(height: 12.h),
                  tradeDetailRow('Exit  ', '₹1,752.12', '15 Feb 2025 |', ' 9:32 pm'),
                  SizedBox(height: 12.h),
                  Container(
                    height: 28.h,
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    decoration: BoxDecoration(
                      color: Color(0xff58585850),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Net gain:',
                          style: TextStyle(
                            color: Color(0xffEBEEF5),
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          '+6.08%',
                          style: TextStyle(
                            color: Color(0xff1DB954),
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 34.h,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Color(0xff2F2F2F)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              'About Trade',
                              style: TextStyle(
                                  color: Color(0xffEBEEF5), fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget tradeDetailRow(String title, String value, String date , String time) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(color: Color(0xffEBEEF5),fontSize: 13.sp),
      ),
      Text(
        value,
        style: TextStyle(
            color: Color(0xffEBEEF5),
            fontSize: 13.sp
        ),
      ),
      Text(
        date + time,
        style: TextStyle(color: Color(0xffEBEEF5), fontSize: 13.sp),
      ),
    ],
  );
}