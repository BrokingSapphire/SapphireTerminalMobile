import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/screens/home/discover/ipo/applied/ipoApplicationStatus.dart';

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
                color: isDark ? Color(0xFF1E1E1E) : Color(0xFFF4F4F9),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        // backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage("assets/images/reliance logo.png"),
                      ),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Wagons Learning Ltd.',
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Color(0xff491787).withOpacity(0.6)
                                      : Color(0xE6D1FF).withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'SME',
                                  style: TextStyle(
                                      color: isDark
                                          ? Color(0xffCBA0FF)
                                          : Color(0xff8B42E3),
                                      fontSize: 12),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Color(0xff303030)
                                      : Color(0xffB8DBD9).withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'RETAIL',
                                  style: TextStyle(
                                      color: isDark
                                          ? Colors.white
                                          : Color(0xff1A1A1A),
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDetailColumn(
                          'Invested (₹)', '₹3,21,380.00', isDark),
                      _buildDetailColumn('Bid Price (₹)', '₹80.00', isDark),
                      _buildDetailColumn('Quantity', '1', isDark),
                      _buildDetailColumn('Status', 'Applied', isDark,
                          isGreen: true),
                    ],
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
      {bool isGreen = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: isDark ? Colors.grey : Colors.black, fontSize: 12),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
              color: isGreen
                  ? Colors.green
                  : (isDark ? Colors.white : Colors.black),
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
