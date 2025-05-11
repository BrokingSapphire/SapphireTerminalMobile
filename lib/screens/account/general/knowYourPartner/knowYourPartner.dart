import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KnowYourPartner extends StatefulWidget {
  const KnowYourPartner({super.key});

  @override
  State<KnowYourPartner> createState() => _KnowYourPartnerState();
}

class _KnowYourPartnerState extends State<KnowYourPartner> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 32.w,
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Know Your Partner",
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
            icon: Icon(Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(15.h),
          child: Divider(
            color: isDark ? const Color(0xff2F2F2F) : const Color(0xffD1D5DB),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContactCard(isDark),
              SizedBox(height: 20.h),
              // Add more content as needed
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xff121413) : const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile header with initials and name
            Row(
              children: [
                // Circular avatar with initials
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xff021814)
                        : const Color(0xff004D40),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "NK",
                      style: TextStyle(
                        color: isDark ? const Color(0xff22A06B) : Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Name
                Expanded(
                  child: Text(
                    "Nakul Pratap Thakur",
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // Phone icon
                Icon(
                  Icons.phone_outlined,
                  color: isDark ? Colors.white : Colors.black,
                  size: 18.sp,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            // Email section
            Text(
              "Email Address",
              style: TextStyle(
                color: isDark ? const Color(0xffC9CACC) : Colors.grey,
                fontSize: 11.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              "nakulthakur35@gmail.com",
              style: TextStyle(
                color: isDark ? const Color(0xffEBEEF5) : Colors.black,
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: 16.h),
            // Address section
            Text(
              "Address",
              style: TextStyle(
                color: isDark ? const Color(0xffC9CACC) : Colors.grey,
                fontSize: 11.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              "K-115-122, FIRST FLOOR MANGAL BAZAR LAXMINAGAR, DELHI LAXMI NAGAR MANGAL BAZAR",
              style: TextStyle(
                color: isDark ? const Color(0xffEBEEF5) : Colors.black,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
