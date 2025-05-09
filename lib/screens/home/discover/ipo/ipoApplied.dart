import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/screens/home/discover/ipo/ipoApplicationStatus.dart';

class appliedIpo extends StatefulWidget {
  const appliedIpo({Key? key}) : super(key: key);

  @override
  State<appliedIpo> createState() => _appliedIpoState();
}

class _appliedIpoState extends State<appliedIpo>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDark ? Colors.black : Colors.white,
      child: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          // Example of an applied IPO item that navigates to the application status
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ipoApplication()),
              );
            },
            child: Container(
              padding: EdgeInsets.all(16.w),
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: isDark ? Color(0xFF121413) : Color(0xFFF4F4F9),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company info row with logo and tags
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        // backgroundColor: Colors.amber[100],
                        backgroundImage:
                            AssetImage("assets/images/reliance logo.png"),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Wagons Learning Ltd.',
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? Color(0xff491787).withOpacity(0.6)
                                        : Color(0xFFE6D1FF),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'SME',
                                    style: TextStyle(
                                        color: isDark
                                            ? Color(0xffCBA0FF)
                                            : Color(0xff8B42E3),
                                        fontSize: 12.sp),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? Color(0xff303030)
                                        : Color(0xFFEEEEEE),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'RETAIL',
                                    style: TextStyle(
                                        color: isDark
                                            ? Colors.white
                                            : Color(0xff1A1A1A),
                                        fontSize: 12.sp),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Price information row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDetailColumn('Price', '₹3,21,380.00', isDark,
                          CrossAxisAlignment.start),
                      _buildDetailColumn('Bid Price', '₹80.00', isDark,
                          CrossAxisAlignment.center),
                      _buildDetailColumn('Listing On', '12 May 2025', isDark,
                          CrossAxisAlignment.end),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // IPO application status message
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Color(0xFFCBB267).withOpacity(0.2)
                          : Color(0xFFF8F3D6),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      'IPO application submitted. You will receive the payment mandate on your UPI app soon.',
                      style: TextStyle(
                        color: isDark ? Color(0xFFC9CACC) : Color(0xFF6B5E11),
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailColumn(String title, String value, bool isDark,
      CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: TextStyle(
            color: isDark ? Colors.grey[400] : Colors.grey[600],
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
