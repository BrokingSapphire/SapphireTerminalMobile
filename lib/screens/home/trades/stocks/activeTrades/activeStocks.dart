import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapphire/screens/home/trades/trades.dart';

class TradesActiveScreen extends StatefulWidget {
  const TradesActiveScreen({super.key});

  @override
  State<TradesActiveScreen> createState() => _TradesActiveScreenState();
}

class _TradesActiveScreenState extends State<TradesActiveScreen>
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
            activeTradeCard(),
            SizedBox(
              height: 12.h,
            ),
            activeTradeCard(),
            SizedBox(
              height: 12.h,
            ),
            // buildTradeCard()
          ],
        ),
      ),
    );
  }

  Widget buildTradeCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                      Text(
                        "Reliance Industries Ltd.",
                        style: TextStyle(
                            fontSize: 11.sp, color: const Color(0xffC9CACC)),
                      ),
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
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
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

          /// Entry Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Entry", style: _labelStyle()),
              Text("₹1,580.60", style: _valueStyle()),
              Text("14 Feb 2025 | 8:32 pm", style: _valueStyle()),
            ],
          ),
          SizedBox(height: 8.h),

          /// Exit Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Exit", style: _labelStyle()),
              Text("₹1,752.12", style: _valueStyle()),
              Text("15 Feb 2025 | 9:32 pm", style: _valueStyle()),
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
                child: SizedBox(
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
                          fontSize: 13.sp,
                          color: const Color(0xffEBEEF5),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: SizedBox(
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      side: const BorderSide(color: Color(0xff1db954)),
                    ),
                    child: Text(
                      "Place Order",
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: Color(0xffEBEEF5),
                          fontWeight: FontWeight.w600),
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

  Widget activeTradeCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xff121413),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Row - Logo + Title + Price
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
                              color: const Color(0xff1db954).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              "BUY",
                              style: TextStyle(
                                color: const Color(0xff1db954),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Reliance Industries Ltd.",
                        style: TextStyle(
                            fontSize: 11.sp, color: const Color(0xffC9CACC)),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "₹580.60",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xffEBEEF5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset("assets/svgs/icon-park-solid_up-one.svg",
                          width: 12.sp, height: 12.sp),
                      SizedBox(width: 4.w),
                      Text(
                        "0.55 (1.33%)",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(0xff1db954),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),

          /// Entry Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Entry Price", style: _labelStyle()),
              Text("₹1,200.00", style: _valueStyle()),
            ],
          ),
          SizedBox(height: 8.h),

          /// Entry Range
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Entry Range", style: _labelStyle()),
              Text("₹1,198.00 - 1,273.00", style: _valueStyle()),
            ],
          ),
          SizedBox(height: 8.h),
          Divider(
            color: Color(0xff2F2F2f),
          ),

          /// Posted, Target, Hold Duration in a row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Posted", style: _labelStyle()),
                  Text("15 Feb 2025 | 03:17 pm", style: _valueStyle()),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Target", style: _labelStyle()),
                  Text("1,380.00", style: _valueStyle()),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hold Duration", style: _labelStyle()),
                  Text("1 - 3 months", style: _valueStyle()),
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
                    color: const Color(0xff1db954),
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
                child: SizedBox(
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
                          fontSize: 13.sp,
                          color: const Color(0xffEBEEF5),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: SizedBox(
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      side: const BorderSide(color: Color(0xff1db954)),
                    ),
                    child: Text(
                      "Place Order",
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: const Color(0xffEBEEF5),
                          fontWeight: FontWeight.w600),
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

  TextStyle _labelStyle() =>
      TextStyle(color: const Color(0xffC9CACC), fontSize: 12.sp);

  TextStyle _valueStyle() =>
      TextStyle(color: const Color(0xffEBEEF5), fontSize: 12.sp);
}
