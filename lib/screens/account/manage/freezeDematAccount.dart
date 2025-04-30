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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 32.w,
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Gift Securities",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
                color: isDark ? Colors.white : Colors.black),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Divider(
            color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 36.h),
                SvgPicture.asset(
                  "assets/svgs/freeze.svg",
                  color: isDark ? Colors.white : Colors.black,
                ),
                SizedBox(height: 24.h),
                Text(
                  "You can freeze your account if you detect any suspicious activities",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black),
                ),
                SizedBox(height: 18.h),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(
                      color: isDark
                          ? const Color(0xff2f2f2f)
                          : const Color(0xffD1D5DB),
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
                            SvgPicture.asset(
                              'assets/svgs/image57.svg',
                              color: isDark ? Colors.white : Colors.black,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                "Anyone using your account will be logged out immediately",
                                style: TextStyle(
                                  color: isDark
                                      ? const Color(0xffC9CACC)
                                      : Colors.black,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svgs/image58.svg',
                              color: isDark ? Colors.white : Colors.black,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                "You will not be able to place any trades while your account is frozen",
                                style: TextStyle(
                                  color: isDark
                                      ? const Color(0xffC9CACC)
                                      : Colors.black,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svgs/image59.svg',
                              color: isDark ? Colors.white : Colors.black,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                "This is a temporary block. You can unfreeze your account at any time",
                                style: TextStyle(
                                  color: isDark
                                      ? const Color(0xffC9CACC)
                                      : Colors.black,
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
                SizedBox(height: 180.h),
                Container(
                  decoration: BoxDecoration(
                    color:
                        isDark ? Colors.grey.shade900 : const Color(0xffF4F4F9),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.w),
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
                              color: isDark ? Colors.white : Colors.black,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 28.h),
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
