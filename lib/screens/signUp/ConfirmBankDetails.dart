import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/screens/signUp/ipvScreen.dart';

import '../../main.dart';
import '../../utils/constWidgets.dart';

class confirmBankDetails extends StatefulWidget {
  const confirmBankDetails({super.key});

  @override
  State<confirmBankDetails> createState() => _confirmBankDetailsState();
}

class _confirmBankDetailsState extends State<confirmBankDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 46,
        leading: Padding(
          padding: EdgeInsets.only(left: 0),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8.h,
            ),
            constWidgets.topProgressBar(1, 5, context),
            SizedBox(
              height: 24.h,
            ),

            // Heading
            Text(
              "Link your bank account",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),

            Text(
              "Please confirm your bank details",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 12.h),

            // Bank Details Card
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bank Name with Edit Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/kotakbanklogo.png",
                            height: 22.h,
                            width: 22.w,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "Kotak Mahindra Bank Ltd",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          // Implement edit functionality
                        },
                        child: Row(
                          children: [
                            Icon(Icons.edit, color: Colors.green, size: 16),
                            SizedBox(width: 4.w),
                            Text(
                              "Edit",
                              style: TextStyle(
                                  color: Colors.green, fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Account Number & IFSC Code
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Account Number",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 12.sp)),
                          SizedBox(height: 2.h),
                          Text("51236478954",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13.sp)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("IFSC Code",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 12.sp)),
                          SizedBox(height: 2.h),
                          Text("KKBK5478124",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13.sp)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Branch Details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Branch",
                          style:
                              TextStyle(color: Colors.grey, fontSize: 12.sp)),
                      SizedBox(height: 2.h),
                      Text(
                        "GR FLOOR 1ST FLOOR GALAXY TOWERS PLOT 478 CHANDAN UNTHKANA RD MEDICAL SQU OPP HALDIRAM NAGPUR 440009",
                        style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),

            constWidgets.greenButton("Confirm", onTap: () {
              navi(ipvScreen(), context);
            }),
            SizedBox(height: 10.h),
            Center(
              child: Center(child: constWidgets.needHelpButton(context)),
            ),
          ],
        ),
      ),
    );
  }
}
