import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/screens/home/trades/trades.dart';

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
        padding:
            EdgeInsets.only(right: 16.w, left: 16.h, top: 16.w, bottom: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Active Trades (246)",
              style: TextStyle(color: const Color(0xffEBEEF5), fontSize: 12.sp),
            ),
            SizedBox(height: 8.h),
            buildTradeCard(),
            SizedBox(height: 12.h),
            buildTradeCard()
          ],
        ),
      ),
    );
  }

  Widget buildradeCard() {
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
          buildTripleColumnRow("Entry", "₹1,580.60", "₹1,580.60"),

          SizedBox(height: 8.h),

          /// Exit Row
          buildTripleColumnRow("Exit", "₹1,752.12", "₹1,752.12"),

          SizedBox(height: 8.h),
          Divider(color: const Color(0xff2F2F2F)),

          SizedBox(height: 7.h),

          /// Stoploss & Target
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
              SizedBox(width: 24.w),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Net gain: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                  ),
                ),
                Text(
                  " +6.08%",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),

          /// Buttons
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 34.h,
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
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Container(
                  height: 34.h,
                  child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            TradesUtils.placeOrderPopup(context),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xff1db954),
                      side: const BorderSide(color: Color(0xff1db954)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                    ),
                    child: const Text(
                      "Place Order",
                      style: TextStyle(
                          color: Color(0xffEBEEF5),
                          fontWeight: FontWeight.w500),
                    ),
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

  Widget buildDoubleColumnRow(String title, String val1, String val2) {
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

  Widget buildTradeCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xff1A1A1A),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with logo and date
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: const Color(0xff2A2A2A),
                child: Text(
                  "R",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "RELIANCE 1200 CE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "27 Apr 2025",
                    style: TextStyle(
                      color: const Color(0xffC9CACC),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Posted date
          Text(
            "Posted 08 May '25 | 09:45 Am",
            style: TextStyle(
              color: const Color(0xffC9CACC),
              fontSize: 12.sp,
            ),
          ),

          SizedBox(height: 16.h),

          // Strategy, Entry, Exit headers
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Stratergy",
                  style: TextStyle(
                    color: const Color(0xffC9CACC),
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "Entry",
                  style: TextStyle(
                    color: const Color(0xffC9CACC),
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "Exit",
                  style: TextStyle(
                    color: const Color(0xffC9CACC),
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // BUY row
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xff22a06b).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        "BUY",
                        style: TextStyle(
                          color: const Color(0xff22a06b),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "14 Feb 440 CE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  "₹1,580.60",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "₹1,580.60",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // SELL row
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        "SELL",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "14 Feb 440 CE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  "₹1,580.60",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "₹1,580.60",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),
          Divider(color: const Color(0xff2F2F2F)),
          SizedBox(height: 16.h),

          // Stoploss and Target
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Stoploss amount",
                      style: TextStyle(
                        color: const Color(0xffC9CACC),
                        fontSize: 12.sp,
                      ),
                    ),
                    Text(
                      "-₹1,580.60",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Target amount",
                      style: TextStyle(
                        color: const Color(0xffC9CACC),
                        fontSize: 12.sp,
                      ),
                    ),
                    Text(
                      "₹1,580.60",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Net gain
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xff2A2A2A),
              borderRadius: BorderRadius.circular(6.r),
            ),
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Net gain: ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                  TextSpan(
                    text: "+6.08%",
                    style: TextStyle(
                      color: const Color(0xff1db954),
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40.h,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xff2F2F2F)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      "About Trade",
                      style: TextStyle(
                        color: const Color(0xffEBEEF5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Container(
                  height: 40.h,
                  child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            TradesUtils.placeOrderPopup(context),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xff1db954),
                      side: const BorderSide(color: Color(0xff1db954)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: const Text(
                      "Place Order",
                      style: TextStyle(
                        color: Color(0xffEBEEF5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextStyle _labelStyle() =>
      TextStyle(color: const Color(0xffC9CACC), fontSize: 12.sp);

  TextStyle _valueStyle() =>
      TextStyle(color: const Color(0xffEBEEF5), fontSize: 12.sp);
}
