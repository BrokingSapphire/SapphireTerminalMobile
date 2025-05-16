import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PositionsDetails extends StatefulWidget {
  const PositionsDetails({Key? key}) : super(key: key);

  @override
  State<PositionsDetails> createState() => _PositionsDetailsState();
}

class _PositionsDetailsState extends State<PositionsDetails> {
  // Add a focus node to track when search field is focused
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  // Mock data for selected stocks
  bool isStockSelected = true;
  int selectedStocksCount = 2;
  String totalAmount = '₹12,445.60';

  @override
  void initState() {
    super.initState();
    // Listen for focus changes to show/hide bottom bar
    _searchFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _searchFocusNode.removeListener(_onFocusChange);
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    // Trigger rebuild when focus changes
    setState(() {});
  }

  Widget _buildInfoCard(String title, String value, {bool isGreen = false}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 11.sp,
            color: isDark ? Color(0xffc9cacc) : Colors.grey[600],
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            color: isGreen
                ? Colors.green
                : (isDark ? Color(0xffEBEEF5) : Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String iconPath, String label) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        SvgPicture.asset(
          iconPath,
          height: 24.h,
          width: 24.w,
          colorFilter: ColorFilter.mode(
            const Color(0xff1DB954),
            BlendMode.srcIn,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        leadingWidth: 28,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "ALKYLAMINE",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : Colors.black),
                ),
                SizedBox(width: 10.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xff303030),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    "NSE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xff303030),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    "CARRY FORWARD",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            RichText(
              text: TextSpan(
                text: "₹1,256.89 ",
                style: TextStyle(
                    fontSize: 13.sp,
                    color: isDark ? Colors.white : Color(0xff6B7280)),
                children: [
                  TextSpan(
                    text: "(+1.67%)",
                    style: TextStyle(fontSize: 13.sp, color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Divider(
            height: 1.h,
            color: Color(0xff2f2f2f),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    // Total Gains Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color:
                            isDark ? const Color(0xff121212) : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Total Gains",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: isDark
                                      ? Color(0xffc9cacc)
                                      : Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "₹+22,678.80 (2.78%)",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoCard(
                                      "Today's realized G&L", "1500/1500"),
                                  SizedBox(height: 12.h),
                                  _buildInfoCard(
                                      "Net Quantity", "1 Lot (1 Lot = 76)"),
                                  SizedBox(height: 12.h),
                                  _buildInfoCard(
                                      "Invested Value", "₹12,445.60"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoCard("Avg. Sell Price", "₹327.00"),
                                  SizedBox(height: 12.h),
                                  _buildInfoCard(
                                      "Avg. Buy Price", "₹12,445.60"),
                                  SizedBox(height: 12.h),
                                  _buildInfoCard("Market Value", "₹12,445.60"),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          // Action Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.h, horizontal: 16.w),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xff2F2F2F)
                                        : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                        color: isDark
                                            ? const Color(0xff2F2F2F)
                                            : Colors.grey[200]!),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Convert",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.h, horizontal: 16.w),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xff2F2F2F)
                                        : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                        color: isDark
                                            ? const Color(0xff2F2F2F)
                                            : Colors.grey[200]!),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Stop Loss/Target",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Action Icons
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        color:
                            isDark ? const Color(0xff121212) : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildActionButton(
                              "assets/svgs/notification.svg", "Set Alert"),
                          _buildActionButton(
                              "assets/svgs/chain.svg", "Option Chain"),
                          _buildActionButton(
                              "assets/svgs/save.svg", "Create GTT"),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Buys Section
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: isDark ? Color(0xff121413) : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Buys",
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Buy Qty.",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: isDark
                                          ? Color(0xffC9CACC)
                                          : Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "3,000",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color:
                                          isDark ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Buy Price",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: isDark
                                          ? Color(0xffC9CACC)
                                          : Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "345.55",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color:
                                          isDark ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Buy Value",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: isDark
                                          ? Color(0xffC9CACC)
                                          : Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "9,55,456.89",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color:
                                          isDark ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // View Chart and Stock Details buttons
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? Colors.black : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: Offset(0, -1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color:
                                    isDark ? Color(0xff121413) : Colors.white,
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 12.h),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/icons/arrow_up.svg",
                                              colorFilter: ColorFilter.mode(
                                                isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                                BlendMode.srcIn,
                                              ),
                                              height: 20.h,
                                              width: 20.w,
                                            ),
                                            SizedBox(width: 8.w),
                                            Text(
                                              "View Chart",
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: isDark
                                                    ? Color(0xffEBEEF5)
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 1.w,
                                      height: 25.h,
                                      color: Color(0xff2f2f2f),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/icons/arrow_up.svg",
                                              colorFilter: ColorFilter.mode(
                                                isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                                BlendMode.srcIn,
                                              ),
                                              height: 20.h,
                                              width: 20.w,
                                            ),
                                            SizedBox(width: 8.w),
                                            Text(
                                              "Stock Details",
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: isDark
                                                    ? Color(0xffEBEEF5)
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // Bottom action buttons
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Handle EXIT action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                child: Text(
                  "EXIT",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Handle ADD action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1DB954),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                child: Text(
                  "ADD",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
