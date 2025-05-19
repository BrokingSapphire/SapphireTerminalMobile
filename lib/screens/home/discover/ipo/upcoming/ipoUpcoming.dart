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

    return RefreshIndicator(
      onRefresh: () async {
        // TODO: Add your refresh logic here
      },
      color: Color(0xff1db954),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          color: isDark ? Colors.black : Colors.white,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            upcomingIpoCard(
              companyName: 'ATC Engineers Limited',
              openingDate: '21 June 2025',
              minPrice: 64.67,
              maxPrice: 87.40,
              boardType: 'MAINBOARD',
            ),
          ]),
        ),
      ),
    );
  }

  Widget upcomingIpoCard({
    required String companyName,
    required String openingDate,
    required double minPrice,
    required double maxPrice,
    String boardType = "MAINBOARD",
    String logoUrl = "",
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Color(0xff121413),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22.r,
              backgroundColor: Color(0xFF242525),
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Image.asset("assets/images/reliance logo.png",
                    fit: BoxFit.contain, width: 32.w, height: 32.w),
              ),
            ),
            const SizedBox(width: 12),

            // Company Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    companyName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Text(
                        "Opens from",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    openingDate,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),

            // Price Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: Color(0xff303030),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    boardType,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Price Range",
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 10.sp,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  "₹${minPrice.toStringAsFixed(2)} - ₹${maxPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
