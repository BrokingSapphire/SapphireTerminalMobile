import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef VoidCallback = void Function();

Widget ipoTile({
  required String img,
  required String title,
  required String closeDate,
  required String minInvestment,
  required String badge1,
  required String badge2,
  required String description,
  required String statusDay,
  required String subscriptionStatus,
  required String price,
  required String lotSize,
  VoidCallback? onApply,
}) {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFF181A1B),
      borderRadius: BorderRadius.circular(16.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22.r,
              backgroundColor: Color(0xFF242525),
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Image.asset(img,
                    fit: BoxFit.contain, width: 32.w, height: 32.w),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "Closes on : ",
                              style: TextStyle(
                                  color: Color(0xffc9cacc), fontSize: 12.sp),
                              children: [
                            TextSpan(
                                text: closeDate,
                                style: TextStyle(
                                    color: Color(0xFFEBEEF5), fontSize: 12.sp))
                          ])),
                      Spacer(),
                      RichText(
                          text: TextSpan(
                              text: "Min Investment : ",
                              style: TextStyle(
                                  color: Color(0xffc9cacc), fontSize: 12.sp),
                              children: [
                            TextSpan(
                                text: minInvestment,
                                style: TextStyle(
                                    color: Color(0xFFEBEEF5), fontSize: 12.sp))
                          ])),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Color(0xFF6C3EB6).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(badge1,
                            style: TextStyle(
                                color: Color(0xffCBA0FF), fontSize: 12)),
                      ),
                      SizedBox(width: 8),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Color(0xFF444444),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(badge2,
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text.rich(
          TextSpan(
            text: description.split("... ")[0] + "... ",
            style: TextStyle(color: Colors.white, fontSize: 13.5.sp),
            children: [
              TextSpan(
                text: "View more",
                style: TextStyle(
                  color: Color(0xFFB7B7B7),
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 14.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Color(0xFF232323),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9C544).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(statusDay,
                    style: TextStyle(color: Color(0xffD9C544), fontSize: 12)),
              ),
              SizedBox(width: 8),
              Text("Subscription status",
                  style: TextStyle(color: Colors.white, fontSize: 13)),
              Spacer(),
              Text(subscriptionStatus,
                  style: TextStyle(
                      color: Color(0xFF22A06B),
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        SizedBox(height: 14.h),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Price",
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
                SizedBox(height: 2),
                Text(price,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Lot Size",
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
                SizedBox(height: 2),
                Text(lotSize,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
        SizedBox(height: 14.h),
        SizedBox(
          width: 150.w,
          height: 35.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1DB954),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: onApply ?? () {},
            child: Text(
              "Apply now",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  ),
            ),
          ),
        ),
      ],
    ),
  );
}
