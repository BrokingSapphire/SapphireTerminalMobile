import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class upcomingIpo extends StatefulWidget {
  const upcomingIpo({Key? key}) : super(key: key);

  @override
  State<upcomingIpo> createState() => _upcomingIpoState();
}

class _upcomingIpoState extends State<upcomingIpo>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Sample upcoming IPO data
    List<Map<String, dynamic>> upcomingIpos = [
      {
        'name': 'ATC Engineers Limited',
        'openDate': '21 June 2025',
        'priceRange': '₹64.67 - ₹87.40',
        'category': 'MAINBOARD',
        'logo': 'assets/images/reliance logo.png'
      },
      {
        'name': 'Wagons Learning Ltd',
        'openDate': '25 June 2025',
        'priceRange': '₹78.89 - ₹82.89',
        'category': 'SME',
        'logo': 'assets/images/reliance logo.png'
      },
      {
        'name': 'Nexus Technologies',
        'openDate': '30 June 2025',
        'priceRange': '₹110.50 - ₹125.75',
        'category': 'MAINBOARD',
        'logo': 'assets/images/reliance logo.png'
      },
    ];

    return Container(
      color: isDark ? Colors.black : Colors.white,
      child: upcomingIpos.isEmpty
          ? Center(
              child: Text(
                'No upcoming IPOs',
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: upcomingIpos.length,
              itemBuilder: (context, index) {
                final ipo = upcomingIpos[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: _buildIpoCard(context, ipo, isDark),
                );
              },
            ),
    );
  }

  Widget _buildIpoCard(
      BuildContext context, Map<String, dynamic> ipo, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.transparent : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? Color(0xFF2F2F2F) : Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Logo
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: isDark ? Colors.white : Colors.transparent,
                  backgroundImage: AssetImage(ipo['logo']),
                ),
                SizedBox(width: 8.w),
                // Company name and opening date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ipo['name'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Opens from',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: isDark
                              ? Colors.white.withOpacity(0.6)
                              : Colors.black.withOpacity(0.6),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        ipo['openDate'],
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                // Category badge

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: isDark ? Color(0xFF2F2F2F) : Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        ipo['category'],
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Price Range',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: isDark
                            ? Colors.white.withOpacity(0.6)
                            : Colors.black.withOpacity(0.6),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      ipo['priceRange'],
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.h),
            // Price range
          ],
        ),
      ),
    );
  }
}
