import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/utils/constWidgets.dart';

class FreezeAccount extends StatefulWidget {
  const FreezeAccount({super.key});

  @override
  State<FreezeAccount> createState() => _FreezeAccountState();
}

class _FreezeAccountState extends State<FreezeAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 32.w,
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Gift Securities",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: Column(
        children: [
          const Divider(color: Color(0xff2F2F2F)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 80.h),
                SvgPicture.asset("assets/svgs/freeze.svg"),
                SizedBox(height: 38.h),
                Text(
                  "You can freeze your account if you detect any suspicious activities",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 18.h),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(
                      color: const Color(0xff2f2f2f),
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.check, color: Colors.white, size: 14.sp),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                "Anyone using your account will be logged out immediately",
                                style: TextStyle(
                                  color: const Color(0xffC9CACC),
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            Icon(Icons.check, color: Colors.white, size: 14.sp),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                "You will not be able to place any trades while your account is frozen",
                                style: TextStyle(
                                  color: const Color(0xffC9CACC),
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            Icon(Icons.check, color: Colors.white, size: 14.sp),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                "This is a temporary block. You can unfreeze your account at any time",
                                style: TextStyle(
                                  color: const Color(0xffC9CACC),
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 135.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/Info.svg",
                          height: 24.h,
                          width: 24.w,
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: Text(
                            "Once trading account is frozen, your tradimg and other services will be suspended untill unfreeze",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                constWidgets.greenButton("Yes, freeze", onTap: () {
                  // Add freeze account functionality here
                  print("Freeze account tapped");
                }),
                SizedBox(height: 10.h),
                Center(
                    child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Don't freeze",
                    style: TextStyle(
                        color: Color(0xff1DB954), fontWeight: FontWeight.bold),
                  ),
                )),
                SizedBox(height: 20.h), // Bottom padding for scroll
              ],
            ),
          ),
        ],
      ),
    );
  }
}
