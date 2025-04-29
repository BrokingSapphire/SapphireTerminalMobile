import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DematAccountDetails extends StatefulWidget {
  const DematAccountDetails({super.key});

  @override
  State<DematAccountDetails> createState() => _DematAccountDetailsState();
}

class _DematAccountDetailsState extends State<DematAccountDetails> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDark ? Colors.white : Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Demat Account Details",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Divider(
            color: isDark ? const Color(0xFF2F2F2F) : const Color(0xFFD1D5DB),
            height: 1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
            child: Container(
              // height: 250.h,
              decoration: BoxDecoration(
                color:
                    isDark ? const Color(0xff121413) : const Color(0xFFEBEEF5),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Demat Account Number / BO ID",
                      style: TextStyle(
                        color: isDark ? Color(0xffc9cacc) : Colors.black,
                        fontSize: 11.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Text(
                          "12883772888983882",
                          style: TextStyle(
                            color:
                                isDark ? const Color(0xffEBEEF5) : Colors.black,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: '12883772888983882'));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Demat Account Number copied!')),
                            );
                          },
                          child: SvgPicture.asset(
                            "assets/svgs/copy.svg",
                            width: 14.w,
                            height: 14.h,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "DP ID",
                      style: TextStyle(
                        color: isDark ? const Color(0xffc9cacc) : Colors.black,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Text(
                          "8377176737782",
                          style: TextStyle(
                            color:
                                isDark ? const Color(0xffEBEEF5) : Colors.black,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: '8377176737782'));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('DP ID copied!')),
                            );
                          },
                          child: SvgPicture.asset(
                            "assets/svgs/copy.svg",
                            width: 14.w,
                            height: 14.h,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Depository Participant (DP)",
                      style: TextStyle(
                        color: isDark ? const Color(0xffEBEEF5) : Colors.black,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Text(
                          "Sapphire Broking",
                          style: TextStyle(
                            color:
                                isDark ? const Color(0xffEBEEF5) : Colors.black,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: 'Sapphire Broking'));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Depository Participant copied!')),
                            );
                          },
                          child: SvgPicture.asset(
                            "assets/svgs/copy.svg",
                            width: 14.w,
                            height: 14.h,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Depository",
                      style: TextStyle(
                        color: isDark ? const Color(0xffEBEEF5) : Colors.black,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Text(
                          "CDSL",
                          style: TextStyle(
                            color:
                                isDark ? const Color(0xffEBEEF5) : Colors.black,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: 'CDSL'));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Depository copied!')),
                            );
                          },
                          child: SvgPicture.asset(
                            "assets/svgs/copy.svg",
                            width: 14.w,
                            height: 14.h,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
