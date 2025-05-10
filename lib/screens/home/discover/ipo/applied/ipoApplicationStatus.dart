import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ipoApplication extends StatefulWidget {
  const ipoApplication({super.key});

  @override
  State<ipoApplication> createState() => _ipoApplicationState();
}

class _ipoApplicationState extends State<ipoApplication> {
  // Controller for the RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  // Function to refresh data
  Future<void> _refreshData() async {
    // Simulate a network request
    await Future.delayed(Duration(seconds: 2));

    // Here you would typically fetch new data from an API
    // For now, we'll just update the state to simulate a refresh
    setState(() {
      // Update your data here
    });
  }

  // Show cancel confirmation dialog
  void _showCancelConfirmationDialog(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? Color(0xff121413) : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 36.w,
              left: 24.w,
              right: 24.w,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/svgs/ipoCancel.svg',
                  // color: isDark ? Colors.white : Colors.black,
                ),
                SizedBox(height: 24.h),

                // Title
                Text(
                  'Cancel IPO Application?',
                  style: TextStyle(
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 16.h),

                // Description
                Text(
                  'Do you want to cancel your IPO application\nfor Reliance Industries Ltd.?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 32.h),

                // Yes, Cancel Button
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Add cancel logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1DB954),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Yes, Cancel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Don't Cancel Button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Don\'t Cancel',
                    style: TextStyle(
                      color: Color(0xFF1DB954),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // Bottom Indicator
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        // or your desired color
        elevation: 0,
        scrolledUnderElevation: 0,
        // prevent shadow when scrolling
        leadingWidth: 32.w,
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "IPO Application Status",
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
          preferredSize: Size.fromHeight(15.h), // Height of the divider
          child: Divider(
            color: isDark
                ? const Color(0xff2F2F2F)
                : const Color(0xffD1D5DB), // Color for the divider
            // thickness: 1, // Divider thickness
          ),
        ),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshData,
        color: Color(0xff9B51E0),
        backgroundColor: isDark ? Color(0xFF1E1E1E) : Colors.white,
        displacement: 20.0,
        strokeWidth: 3.0,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Company Information Card
                // Divider(
                //   height: 1,
                //   color: isDark ? const Color(0xFF2F2F2F) : Color(0xFFD1D5DB),
                // ),
                SizedBox(height: 16.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: isDark ? Color(0xFF1E1E1E) : Color(0xFFF4F4F9),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Company Logo and Name
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage(
                                    "assets/images/reliance logo.png",
                                  ),
                                ),
                                SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Wagons Learning Ltd.',
                                      style: TextStyle(
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 4.h),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: isDark
                                                ? Color(0xff491787)
                                                    .withOpacity(0.6)
                                                : Color(0xE6D1FF)
                                                    .withOpacity(0.6),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text('SME',
                                              style: TextStyle(
                                                  color: isDark
                                                      ? Color(0xffCBA0FF)
                                                      : Color(0xff8B42E3),
                                                  fontSize: 12)),
                                        ),
                                        SizedBox(width: 8.w),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: isDark
                                                ? Color(0xff303030)
                                                : Color(0xffB8DBD9)
                                                    .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text('RETAIL',
                                              style: TextStyle(
                                                  color: isDark
                                                      ? Colors.white
                                                      : Color(0xff1A1A1A),
                                                  fontSize: 12)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            // Investment Details
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _leftBuildDetailColumn(
                                    'Invested (₹)', '₹3,21,380.00', isDark),
                                _centerBuildDetailColumn(
                                    'Bid Price (₹)', '₹80.00', isDark),
                                _centerBuildDetailColumn(
                                    'Quantity', '1', isDark),
                                _rightBuildDetailColumn(
                                    'Listing On', '12 May 2025', isDark),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),

                // IPO Status Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: isDark ? Color(0xFF1E1E1E) : Color(0xFFF4F4F9),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'IPO Status',
                          style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 14.h,
                        ),
                        Divider(
                          height: 1,
                          color: isDark
                              ? const Color(0xFF2F2F2F)
                              : Color(0xFFD1D5DB),
                        ),
                        SizedBox(height: 14.h),
                        _buildStatusItem(Icons.check_circle, Color(0xff9B51E0),
                            'Applied on 5 May', true, isDark),
                        _buildStatusItem(
                            Icons.check_circle,
                            Color(0xff9B51E0),
                            'Approved Payment Before 5:00pm on 7 May 2025',
                            true,
                            isDark),
                        _buildStatusItem(Icons.check_circle, Color(0xff9B51E0),
                            'Allotment on 8 May 2025', true, isDark),
                        _buildStatusItem(
                            CupertinoIcons.circle,
                            Color(0xff9B51E0),
                            'Refund initiation on 9 May 2025',
                            true,
                            isDark,
                            isCurrentState: true),
                        _buildStatusItem(
                            Icons.check_circle,
                            Color(0xff2f2f2f),
                            'Credit of shares to demat on 9 May 2025',
                            false,
                            isDark),
                        _buildStatusItem(Icons.check_circle, Color(0xff2f2f2f),
                            'IPO Listing on 12 May', false, isDark,
                            isLast: true),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),

                // Application Details Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: isDark ? Color(0xFF1E1E1E) : Color(0xFFF4F4F9),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Application Details',
                          style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 14.h,
                        ),
                        Divider(
                          height: 1,
                          color: isDark
                              ? const Color(0xFF2F2F2F)
                              : Color(0xFFD1D5DB),
                        ),
                        SizedBox(height: 14.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildDetailRow('Demat Account (BO) ID',
                                '1294892792132487633', isDark),
                            _buildDetailRow(
                                'Application ID', '2792132487633', isDark),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildDetailRow(
                                'Exchange Order No.', '2792132487633', isDark),
                            _buildDetailRow('Cut off', 'Yes', isDark),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildDetailRow('UPI ID', 'abcd@yesbank', isDark),
                            _buildDetailRow(
                                'Application Status', 'Submitted', isDark,
                                isGreen: true),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                // Bottom Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40.h,
                          child: ElevatedButton(
                            onPressed: () {
                              _showCancelConfirmationDialog(context, isDark);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDark
                                  ? Color(0xFF2F2F2F)
                                  : Color(0xFFD1D5DB),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
                          height: 40.h,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1DB954),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Modify',
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _centerBuildDetailColumn(String title, String value, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _leftBuildDetailColumn(String title, String value, bool isDark) {
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
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _rightBuildDetailColumn(String title, String value, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
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
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildStatusItem(
      IconData icon, Color color, String text, bool completed, bool isDark,
      {bool isLast = false, bool isCurrentState = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Icon and vertical line column
        Container(
          width: 20,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isCurrentState
                  ? Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: completed ? Colors.white : Color(0xffc9cacc),
                        size: 12,
                      ),
                    ),
              if (!isLast)
                Container(
                  height: 16,
                  width: 1,
                  color: isCurrentState
                      ? Color(0xff2f2f2f)
                      : (completed ? Colors.purple : Color(0xff2f2f2f)),
                ),
            ],
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding:
                isLast ? EdgeInsets.zero : const EdgeInsets.only(bottom: 16.0),
            child: Text(
              text,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontWeight: isCurrentState ? FontWeight.w500 : FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String title, String value, bool isDark,
      {bool isGreen = false}) {
    return Expanded(
      child: Column(
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
                  : isDark
                      ? Colors.white
                      : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
