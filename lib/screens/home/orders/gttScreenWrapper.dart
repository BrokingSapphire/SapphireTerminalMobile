import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:holdable_button/utils/utils.dart';
import 'package:sapphire/utils/constWidgets.dart';
import 'package:holdable_button/holdable_button.dart';

class GttScreenWrapper extends StatefulWidget {
  @override
  _GttScreenWrapper createState() => _GttScreenWrapper();
}

class _GttScreenWrapper extends State<GttScreenWrapper>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "RELIANCE",
                  style:
                      TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                ),
                Text(
                  "₹1,256.89 (+1.67%)",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            actions: [
              Container(
                // width: 50.w,
                decoration: BoxDecoration(
                    color: Color(0xff2F2F2F),
                    borderRadius: BorderRadius.circular(6.r)),
                child: Padding(
                  padding: const EdgeInsets.all(2.5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 25.h,
                        width: 40.w,
                        child: Center(
                          child: Text(
                            'NSE',
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.w400),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(6.r)),
                      ),
                      Container(
                        height: 25.h,
                        width: 40.w,
                        child: Center(
                          child: Text(
                            'BSE',
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.w400),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(6.r)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Divider(),
              // Tab Bar
              // Margin Section + Buy Button (Persistent)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Margin Required",
                        style: TextStyle(
                            fontSize: 12.sp, color: Color(0xffC9CACC)),
                      ),
                      Text(
                        "₹75.68",
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Charges",
                        style: TextStyle(
                            fontSize: 12.sp, color: Color(0xffC9CACC)),
                      ),
                      Text(
                        "₹75.68",
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Available Margin",
                        style: TextStyle(
                            fontSize: 12.sp, color: Color(0xffC9CACC)),
                      ),
                      Text(
                        "₹75.68",
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.refresh,
                    color: Colors.green,
                    size: 22,
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              HoldableButton(
                reverseAfterLongPressUp: false,
                loadingType: LoadingType.fillingLoading,
                width: double.infinity,
                height: 52.h,
                buttonColor: Color(0xFF1DB954),
                loadingColor: Colors.white,
                radius: 25.r,
                child: Text(
                  'HOLD TO BUY',
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                duration: 1,
                hasVibrate: true,

                // 👇 Ensures left-to-right wave effect
                beginFillingPoint: Alignment.centerLeft,
                endFillingPoint: Alignment.centerRight,
                edgeLoadingStartPoint: 0.0,

                onConfirm: () {
                  print("Buy action confirmed!");
                },
                strokeWidth: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
