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

    return RefreshIndicator(
      onRefresh: () async {
        // TODO: Add your refresh logic here
      },
      color: Color(0xff1db954),
      child: Container(
        color: isDark ? Colors.black : Colors.white,
        child: ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ipoApplication()),
                );
              },
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: isDark ? Color(0xff121413) : Color(0xFFF4F4F9),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 22.r,
                          backgroundColor: Color(0xFF242525),
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Image.asset(
                                "assets/images/reliance logo.png",
                                fit: BoxFit.contain,
                                width: 32.w,
                                height: 32.w),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          // Wrap Column in Expanded to prevent overflow
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Wagons Learning Ltd.',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                                overflow: TextOverflow
                                    .ellipsis, // Prevent text overflow
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4.w, vertical: 3.h),
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
                                          fontSize: 10.sp),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4.w, vertical: 3.h),
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
                                          fontSize: 10.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),

                    // Price information row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildDetailColumn('Price', '₹3,21,380.00', isDark),
                        _buildDetailColumn('Bid Price', '₹80.00', isDark),
                        _buildDetailColumn('Listing On', '12 May 2025', isDark),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    // IPO application status message
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
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
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ipoApplication()),
                );
              },
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: isDark ? Color(0xff121413) : Color(0xFFF4F4F9),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company info row with logo and tags
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 22.r,
                          backgroundColor: Color(0xFF242525),
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Image.asset(
                                "assets/images/reliance logo.png",
                                fit: BoxFit.contain,
                                width: 32.w,
                                height: 32.w),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          // Wrap Column in Expanded to prevent overflow
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Wagons Learning Ltd.',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                                overflow: TextOverflow
                                    .ellipsis, // Prevent text overflow
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4.w, vertical: 3.h),
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
                                          fontSize: 10.sp),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4.w, vertical: 3.h),
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
                                          fontSize: 10.sp),
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
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailColumn(String title, String value, bool isDark,
      {bool isGreen = false}) {
    bool isStatus = title.toLowerCase().contains('status');
    bool isCentered = title.toLowerCase().contains('bid price') ||
        title.toLowerCase().contains('quantity');
    bool isListing = title.toLowerCase().contains('listing on');

    CrossAxisAlignment crossAlignment;
    Alignment textAlignment;

    if (isStatus || isListing) {
      crossAlignment = CrossAxisAlignment.end;
      textAlignment = Alignment.centerRight;
    } else if (isCentered) {
      crossAlignment = CrossAxisAlignment.center;
      textAlignment = Alignment.center;
    } else {
      crossAlignment = CrossAxisAlignment.start;
      textAlignment = Alignment.centerLeft;
    }

    return Column(
      crossAxisAlignment: crossAlignment,
      children: [
        Align(
          alignment: textAlignment,
          child: Text(
            title,
            style: TextStyle(
                color: isDark ? Colors.grey : Colors.black, fontSize: 10.sp),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: TextStyle(
              fontSize: 11.sp,
              color: isGreen
                  ? Colors.green
                  : (isDark ? Colors.white : Colors.black),
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
