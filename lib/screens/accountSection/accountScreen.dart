import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sapphire/utils/constWidgets.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  double width = 150.w;
  bool _segments = false;
  Widget titleWithSub(String title, String subtitle, bool isDark) {
    return SizedBox(
      height: 35.h,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              fontSize: 12.sp, color: isDark ? Colors.white : Colors.black),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Text(
            subtitle,
            style: TextStyle(
                fontSize: 15.sp, color: isDark ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }

  Widget bankCard({
    required String bankName,
    required String bankLogoUrl,
    required String accountNumber,
    required String ifscCode,
    required String branch,
    bool isPrimary = false,
    required bool isDark,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        border:
            Border.all(color: isDark ? Color(0xff2F2F2F) : Color(0xFFD1D5DB)),
        color: isDark ? Color(0xff121413) : Color(0xFFF4F4F9),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bank Name & Logo Row
          Row(
            children: [
              // Bank Logo
              SizedBox(
                height: 24.h,
                width: 24.h,
                child: CircleAvatar(
                  backgroundColor: isDark ? Colors.white : Colors.grey,
                  backgroundImage: NetworkImage(bankLogoUrl),
                ),
              ),

              SizedBox(width: 10.w),
              // Bank Name
              Text(
                bankName,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              Spacer(),
              // Primary Badge
              if (isPrimary)
                Text(
                  "PRIMARY",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          // Account & IFSC
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              columnText("Account Number", accountNumber, isDark),
              columnText("IFSC Code", ifscCode, isDark),
            ],
          ),
          SizedBox(height: 12.h),
          // Branch Details
          columnText("Branch", branch, isDark),
        ],
      ),
    );
  }

// Helper Widget for Title & Value
  Widget columnText(String title, String value, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[500],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
              fontSize: 13.sp,
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget rightLeftCards(
      String lname, String rname, double _width, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        constWidgets.choiceChip(lname, _segments, context, _width, isDark),
        constWidgets.choiceChip(rname, _segments, context, _width, isDark),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24.sp,
              color: isDark ? Colors.white : Colors.black),
        ),
        backgroundColor: isDark ? Colors.black : Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              color: isDark ? Color(0xFF2f2f2f) : const Color(0xffD1D5DB),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 90.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xff121413)
                            : const Color(0xFFF4F4F9),
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: isDark
                                ? Color(0xff021814)
                                : Colors.green.withOpacity(0.2),
                            radius: 35.r,
                            child: Text(
                              "NK",
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? Color(0xff22A06B)
                                    : Color(0xff22A06B),
                              ),
                            ),
                          ),
                          SizedBox(
                              width: 12.w), // Spacing between avatar and text
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Nakul Pratap Thakur",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "J098WE",
                                style: TextStyle(
                                  color: isDark
                                      ? Color(0xffC9CACC)
                                      : Color(0xff6B7280),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Spacer(), // Pushes the icon to the right
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: isDark ? Color(0xffC9CACC) : Colors.black,
                            size: 20.sp,
                          ),
                          SizedBox(width: 12.w), // Padding on the right side
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 285.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark ? Color(0xff121413) : Color(0xFFF4F4F9),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.w,
                                top: 16.h,
                                bottom: 16.h,
                                right: 16.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Personal Information",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      color:
                                          isDark ? Colors.white : Colors.black),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    padding: WidgetStateProperty.all(EdgeInsets
                                        .zero), // ✅ Removes internal padding
                                    minimumSize: MaterialStateProperty.all(
                                        Size(0, 0)), // ✅ No unnecessary height
                                    tapTargetSize: MaterialTapTargetSize
                                        .shrinkWrap, // ✅ Shrinks the button touch area
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize
                                        .min, // ✅ Prevents extra spacing
                                    children: [
                                      Icon(
                                        Icons.edit_outlined,
                                        size: 14,
                                        color: Color(0xff1db954),
                                      ),
                                      SizedBox(
                                          width:
                                              6), // ✅ Adds EXACTLY 6px spacing
                                      Text(
                                        "Modify",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Color(0xff1db954)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Color(0xff2F2F2F),
                            indent: 16.w,
                            height: 1.h,
                            endIndent: 15.w,
                            thickness: 1, // Ensure visibility
                          ),
                          titleWithSub("PAN", "CRNP00991H", isDark),
                          SizedBox(
                            height: 16.h,
                          ),
                          titleWithSub("Phone", "+91 1234567890", isDark),
                          SizedBox(
                            height: 16.h,
                          ),
                          titleWithSub(
                              "Location", "Nagpur, Maharastra", isDark),
                          SizedBox(
                            height: 16.h,
                          ),
                          titleWithSub("Email",
                              "nakul.thakur@sapphirebroking.com", isDark),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 285.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark ? Color(0xff121413) : Color(0xFFF4F4F9),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.w, top: 16.h, bottom: 16.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Demat Account Details",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      color:
                                          isDark ? Colors.white : Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 0, // Ensures no extra spacing
                            child: Divider(
                              color: Color(0xff2F2F2F),
                              indent: 16.w,
                              endIndent: 15.w,
                              thickness: 1, // Ensure visibility
                            ),
                          ),
                          titleWithSub("Demat Account (BO) ID",
                              "1294892792132487633", isDark),
                          SizedBox(
                            height: 16.h,
                          ),
                          titleWithSub("DP ID", "1294392", isDark),
                          SizedBox(
                            height: 16.h,
                          ),
                          titleWithSub("Depository Participant (DP)",
                              "Sapphire Broking", isDark),
                          SizedBox(
                            height: 16.h,
                          ),
                          titleWithSub("Depository", "CDSL", isDark),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark ? Color(0xff121413) : Color(0xFFF4F4F9),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.w,
                                top: 16.h,
                                bottom: 16.h,
                                right: 16.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Segments",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      color:
                                          isDark ? Colors.white : Colors.black),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    padding: WidgetStateProperty.all(EdgeInsets
                                        .zero), // ✅ Removes internal padding
                                    minimumSize: MaterialStateProperty.all(
                                        Size(0, 0)), // ✅ No unnecessary height
                                    tapTargetSize: MaterialTapTargetSize
                                        .shrinkWrap, // ✅ Shrinks the button touch area
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize
                                        .min, // ✅ Prevents extra spacing
                                    children: [
                                      Icon(
                                        Icons.edit_outlined,
                                        size: 14,
                                        color: Colors.green,
                                      ),
                                      SizedBox(
                                          width:
                                              6), // ✅ Adds EXACTLY 6px spacing
                                      Text(
                                        "Modify",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 0, // Ensures no extra spacing
                            child: Divider(
                              color: Color(0xff2F2F2F),
                              indent: 16.w,
                              endIndent: 15.w,
                              thickness: 1, // Ensure visibility
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 18.h),
                              child: Column(
                                children: [
                                  rightLeftCards("NSE-EQUITY", "BSE-EQUITY",
                                      width, isDark),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  rightLeftCards("NSE-EQUITY", "BSE-EQUITY",
                                      width, isDark),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  rightLeftCards("NSE-EQUITY", "BSE-EQUITY",
                                      width, isDark),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  rightLeftCards("NSE-EQUITY", "BSE-EQUITY",
                                      width, isDark),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  rightLeftCards("NSE-EQUITY", "BSE-EQUITY",
                                      width, isDark),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark ? Color(0xff121413) : Color(0xFFF4F4F9),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.w, top: 16.h, bottom: 16.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Brokerage Plan",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      color:
                                          isDark ? Colors.white : Colors.black),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 17,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark ? Color(0xff121413) : Color(0xFFF4F4F9),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 15.w, right: 15.w, top: 16.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Bank Details",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color:
                                        isDark ? Colors.white : Colors.black),
                              ),
                              TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  padding: WidgetStateProperty.all(EdgeInsets
                                      .zero), // ✅ Removes internal padding
                                  minimumSize: MaterialStateProperty.all(
                                      Size(0, 0)), // ✅ No unnecessary height
                                  tapTargetSize: MaterialTapTargetSize
                                      .shrinkWrap, // ✅ Shrinks the button touch area
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize
                                      .min, // ✅ Prevents extra spacing
                                  children: [
                                    Icon(
                                      Icons.edit_outlined,
                                      size: 14,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                        width: 6), // ✅ Adds EXACTLY 6px spacing
                                    Text(
                                      "Modify",
                                      style: TextStyle(
                                          fontSize: 12.sp, color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          SizedBox(
                            height: 1, // ✅ Ensures no extra vertical spacing
                            child: Divider(
                              color: Color(0xff2F2F2F),
                              thickness: 1, // Ensures visibility
                            ),
                          ),
                          SizedBox(
                            height: 23.h,
                          ),
                          bankCard(
                            bankName: "Kotak Mahindra Bank Ltd",
                            bankLogoUrl: "https://yourlogo.com/kotak.png",
                            accountNumber: "51236478954",
                            ifscCode: "KKBK5478124",
                            branch:
                                "GR FLOOR 1ST FLOOR GALAXY TOWERS PLOT 478 CHANDAN UNTHKANA RD MEDICAL SQU OPP HALDIRAM NAGPUR 440009",
                            isPrimary: true,
                            isDark: isDark,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          bankCard(
                            bankName: "Kotak Mahindra Bank Ltd",
                            bankLogoUrl: "https://yourlogo.com/kotak.png",
                            accountNumber: "51236478954",
                            ifscCode: "KKBK5478124",
                            branch:
                                "GR FLOOR 1ST FLOOR GALAXY TOWERS PLOT 478 CHANDAN UNTHKANA RD MEDICAL SQU OPP HALDIRAM NAGPUR 440009",
                            isPrimary: true,
                            isDark: isDark,
                          ),
                          SizedBox(
                            height: 23.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xff121413)
                          : const Color(0xFFF4F4F9),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 15.w, right: 15.w, top: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Nominee Details",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color:
                                        isDark ? Colors.white : Colors.black),
                              ),
                              TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  padding: WidgetStateProperty.all(EdgeInsets
                                      .zero), // ✅ Removes internal padding
                                  minimumSize: MaterialStateProperty.all(
                                      Size(0, 0)), // ✅ No unnecessary height
                                  tapTargetSize: MaterialTapTargetSize
                                      .shrinkWrap, // ✅ Shrinks the button touch area
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize
                                      .min, // ✅ Prevents extra spacing
                                  children: [
                                    Icon(
                                      Icons.edit_outlined,
                                      size: 14,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                        width: 6), // ✅ Adds EXACTLY 6px spacing
                                    Text(
                                      "Modify",
                                      style: TextStyle(
                                          fontSize: 12.sp, color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Divider(
                            color: isDark
                                ? const Color(0xff2F2F2F)
                                : const Color(0xffD1D5DB),
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Nominee 1",
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: isDark ? Colors.white : Colors.black),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          columnText("Nominee Name",
                              "Pratap Chandrakant Thakur", isDark),
                          SizedBox(
                            height: 16.h,
                          ),
                          columnText("Document ID", "ACKT8301N", isDark),
                          SizedBox(
                            height: 16.h,
                          ),
                          columnText("Relationship", "Father  ", isDark),
                          SizedBox(
                            height: 16.h,
                          ),
                          columnText("(%) Share", "50%", isDark),
                          SizedBox(
                            height: 10.h,
                          ),
                          Divider(
                            color: isDark
                                ? const Color(0xff2F2F2F)
                                : const Color(0xffD1D5DB),
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Nominee 2",
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: isDark ? Colors.white : Colors.black),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          columnText(
                              "Nominee Name", "Disha Pratap Thakur", isDark),
                          SizedBox(
                            height: 16.h,
                          ),
                          columnText("Document ID", "ASAPT6398D", isDark),
                          SizedBox(
                            height: 16.h,
                          ),
                          columnText("Relationship", "Mother  ", isDark),
                          SizedBox(
                            height: 16.h,
                          ),
                          columnText("(%) Share", "50%", isDark),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    "© 2025 Sapphire Broking. All rights reserved. SEBI Registered Stock Broker | Member: NSE, BSE, MCX, NCDEX Registered Office: [Address], Nagpur, Maharashtra, India Email: support@sapphirebroking.com | Phone: +91 XXXXXXXXXX. Investments in securities markets are subject to market risks. Read all scheme-related documents carefully before investing. All disputes subject to Nagpur jurisdiction.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.sp, color: Color(0xff9B9B9B)),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        size: 18.sp,
                        FontAwesomeIcons.twitter,
                        color: Color(0xff9B9B9B),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      FaIcon(
                        size: 18.sp,
                        FontAwesomeIcons.linkedin,
                        color: Color(0xff9B9B9B),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      FaIcon(
                        size: 18.sp,
                        FontAwesomeIcons.instagram,
                        color: Color(0xff9B9B9B),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      FaIcon(
                        size: 18.sp,
                        FontAwesomeIcons.youtube,
                        color: Color(0xff9B9B9B),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      FaIcon(
                        size: 18.sp,
                        FontAwesomeIcons.whatsapp,
                        color: Color(0xff9B9B9B),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      FaIcon(
                        size: 18.sp,
                        FontAwesomeIcons.telegram,
                        color: Color(0xff9B9B9B),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      FaIcon(
                        size: 18.sp,
                        FontAwesomeIcons.facebook,
                        color: Color(0xff9B9B9B),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
