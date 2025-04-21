import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClosedFutureListScreen extends StatefulWidget {
  const ClosedFutureListScreen({super.key});

  @override
  State<ClosedFutureListScreen> createState() => _ClosedFutureListScreenState();
}

class _ClosedFutureListScreenState extends State<ClosedFutureListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTradeCard(),
            SizedBox(height: 12.h,),
            buildTradeCard()
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
          /// Top section with logo and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Left: Logo, name, BUY
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
                            'RELIANCE',
                            style: TextStyle(
                              color: const Color(0xffEBEEF5),
                              fontSize: 13.sp,
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
                              'BUY',
                              style: TextStyle(
                                  color: const Color(0xff22a06b),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Reliance Industries Ltd.',
                        style: TextStyle(
                            color: const Color(0xffC9CACC), fontSize: 11.sp),
                      ),
                    ],
                  ),
                ],
              ),

              /// Right: Price + change
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "₹580.60",
                    style: TextStyle(
                        color: const Color(0xffEBEEF5),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "+0.55 (1.33%)",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 14.h),

          /// Entry Price row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Entry Price", style: _labelStyle()),
              Text("₹1,200.00", style: _valueStyle()),
            ],
          ),
          SizedBox(height: 8.h),

          /// Entry Range row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Entry Range", style: _labelStyle()),
              Text("₹1,198.00 - ₹1,273.00", style: _valueStyle()),
            ],
          ),

          Divider(color: const Color(0xff2F2F2F), height: 24.h),

          /// Posted | Target | Hold Duration
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              statsText("Posted", "15 Feb 2025 | 03:17 pm"),
              statsText("Target", "1,380.00"),
              statsText("Hold Duration", "1 - 3 months"),
            ],
          ),
          SizedBox(height: 12.h),

          /// Net gain
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xff2A2A2A),
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
                        fontWeight: FontWeight.w600),
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
                      color: Color(0xffEBEEF5),
                      fontWeight: FontWeight.w600,
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

  Widget statsText(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(color: const Color(0xffC9CACC), fontSize: 10.sp)),
        Text(value,
            style: TextStyle(
                color: const Color(0xffEBEEF5),
                fontSize: 11.sp,
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}
