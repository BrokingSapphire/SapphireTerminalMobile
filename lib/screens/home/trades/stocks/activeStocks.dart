import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            SizedBox(height: 12.h,),
            buildTradeCard(),
            SizedBox(height: 12.h,),
            // buildTradeCard()
            
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

  TextStyle _labelStyle() =>
      TextStyle(color: const Color(0xffC9CACC), fontSize: 12.sp);
  TextStyle _valueStyle() =>
      TextStyle(color: const Color(0xffEBEEF5), fontSize: 12.sp);
}
