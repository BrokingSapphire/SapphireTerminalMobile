import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TradesOptionActiveScreen extends StatefulWidget {
  const TradesOptionActiveScreen({super.key});

  @override
  State<TradesOptionActiveScreen> createState() => _TradesOptionActiveScreen();
}

class _TradesOptionActiveScreen extends State<TradesOptionActiveScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Active Trades (246)",
              style: TextStyle(color: const Color(0xffEBEEF5), fontSize: 12.sp),
            ),
            SizedBox(height: 12.h),
            buildTradeCard(),
          ],
        ),
      ),
    );
  }

  Widget buildTradeCard() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xff121413),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Row - Logo + Title + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 14.r,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.asset('assets/images/reliance logo.png'),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "RELIANCE",
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xffEBEEF5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: const Color(0xff143520),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              "BUY",
                              style: TextStyle(
                                color: const Color(0xff22a06b),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('assets/svgs/clock.svg'),
                          SizedBox(width: 4.w),
                          Text('14 Feb 2025 | 8:32 pm',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xffC9CACC))),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "Status",
                    style: TextStyle(
                        color: Color(0xffC9CACC),
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: const Color(0xff35332e),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      "Target Miss",
                      style: TextStyle(
                          color: const Color(0xffffd761), fontSize: 10.sp),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),

          /// Strategy Row
          buildTripleColumnRow("Strategy", "14 Feb 440 CE", "14 Feb 440 CE"),

          SizedBox(height: 8.h),

          /// Entry Row
          buildTripleColumnRow("Entry", "₹1,580.60", "14 Feb 2025 | 8:32 pm"),

          SizedBox(height: 8.h),

          /// Exit Row
          buildTripleColumnRow("Exit", "₹1,752.12", "15 Feb 2025 | 9:32 pm"),

          SizedBox(height: 8.h),
          Divider(color: const Color(0xff2F2F2F)),

          SizedBox(height: 8.h),

          /// Stoploss & Target
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Stoploss amount",
                    style: TextStyle(
                        color: const Color(0xffEBEEF5), fontSize: 13.sp),
                  ),
                  Text(
                    "-₹1,580.60",
                    style: TextStyle(
                        color: const Color(0xffEBEEF5), fontSize: 13.sp),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Target amount",
                    style: TextStyle(
                        color: const Color(0xffEBEEF5), fontSize: 13.sp),
                  ),
                  Text(
                    "₹1,580.60",
                    style: TextStyle(
                        color: const Color(0xffEBEEF5), fontSize: 13.sp),
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),

          /// Net Gain
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xff3a3a3a).withOpacity(0.5),
              borderRadius: BorderRadius.circular(6.r),
            ),
            alignment: Alignment.center,
            child: Text(
              "Net gain: +6.08%",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
            ),
          ),
          SizedBox(height: 12.h),

          /// Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xff2F2F2F)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                  ),
                  child: Text(
                    "About Trade",
                    style: TextStyle(
                        color: const Color(0xffEBEEF5),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xff1db954),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                  ),
                  child: const Text(
                    "Place Order",
                    style: TextStyle(
                        color: Color(0xffEBEEF5), fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// Helper for aligned 3-column rows
  Widget buildTripleColumnRow(String title, String val1, String val2) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(title, style: _labelStyle()),
        ),
        Expanded(
          flex: 3,
          child: Text(val1, style: _valueStyle(), textAlign: TextAlign.start),
        ),
        Expanded(
          flex: 3,
          child: Text(val2, style: _valueStyle(), textAlign: TextAlign.end),
        ),
      ],
    );
  }

  TextStyle _labelStyle() =>
      TextStyle(color: const Color(0xffC9CACC), fontSize: 12.sp);
  TextStyle _valueStyle() =>
      TextStyle(color: const Color(0xffEBEEF5), fontSize: 12.sp);
}
