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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Demat Account Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const Divider(
            color: Color(0xFF2F2F2F),
            height: 1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
            child: Container(
              // height: 250.h,
              decoration: BoxDecoration(
                color: Color(0xff121413),
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
                        color: Color(0xffc9cacc),
                        fontSize: 11.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Text(
                          "12883772888983882",
                          style: TextStyle(
                            color: const Color(0xffEBEEF5),
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
                          child: SvgPicture.asset("assets/svgs/copy.svg",
                              width: 14.w, height: 14.h),
                        )
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "DP ID",
                      style: TextStyle(
                        color: const Color(0xffc9cacc),
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
                            color: const Color(0xffEBEEF5),
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
                          child: SvgPicture.asset("assets/svgs/copy.svg",
                              width: 14.w, height: 14.h),
                        )
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Depository Participant (DP)",
                      style: TextStyle(
                        color: const Color(0xffEBEEF5),
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
                            color: const Color(0xffEBEEF5),
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
                          child: SvgPicture.asset("assets/svgs/copy.svg",
                              width: 14.w, height: 14.h),
                        )
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Depository",
                      style: TextStyle(
                        color: const Color(0xffEBEEF5),
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
                            color: const Color(0xffEBEEF5),
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
                          child: SvgPicture.asset("assets/svgs/copy.svg",
                              width: 14.w, height: 14.h),
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
