import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EquityDetails extends StatefulWidget {
  const EquityDetails({super.key});

  @override
  State<EquityDetails> createState() => _EquityDetailsState();
}

class _EquityDetailsState extends State<EquityDetails> {
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

  Widget _buildInfoCard(String title, String value, {bool isRed = false}) {
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
            color: isRed
                ? Colors.red
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

  Widget _buildPositionRow(String title, String qty, String value,
      {bool isShort = true}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xff121212) : Colors.grey[100],
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: isDark ? Colors.grey : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  qty,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: isShort ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

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
                    // Overall Loss Section
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
                                "Overall Loss",
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
                            "₹-22,678.80 (-2.78%)",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoCard("Total Qty.", "1500/1500"),
                                  SizedBox(height: 12.h),
                                  _buildInfoCard("Invested", "₹12,445.78"),
                                  SizedBox(height: 12.h),
                                  _buildInfoCard("Total gain", "₹12,445.60"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoCard("Avg. Trade Price", "₹327.00"),
                                  SizedBox(height: 12.h),
                                  _buildInfoCard("Market Value", "₹12,445.60"),
                                  SizedBox(height: 12.h),
                                  _buildInfoCard(
                                      "Total realized gain", "₹12,445.60"),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Action Buttons
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

                    // Price Details
                    Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildInfoCard("Avg. Traded Price", "₹678.80"),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildInfoCard(
                                  "Avg. Price without charges", "₹445.60"),
                              _buildInfoCard("Charges Per Share", "₹7.00"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Stock Details Section
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: isDark ? Color(0xff121413) : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        children: [
                          // Header with title and view all link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Stock Details",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              Text(
                                "View all Transactions",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xff1DB954),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          // Position Rows - Redesigned to match the image
                          Row(
                            children: [
                              // Short term container
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? Color(0xff121212)
                                        : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: isDark
                                          ? Color(0xff2F2F2F)
                                          : Colors.grey[300]!,
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Short term",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      Container(
                                        padding: EdgeInsets.all(12.w),
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? Color(0xff252525)
                                              : Colors.grey[100],
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          border: Border.all(
                                            color: isDark
                                                ? Color(0xff2F2F2F)
                                                : Colors.grey[300]!,
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Qty.",
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: isDark
                                                        ? Color(0xffC9CACC)
                                                        : Colors.grey[600],
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  "1000",
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: isDark
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "Value",
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: isDark
                                                        ? Color(0xffC9CACC)
                                                        : Colors.grey[600],
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  "-₹12,347.00",
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              // Long term container
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? Color(0xff121212)
                                        : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: isDark
                                          ? Color(0xff2F2F2F)
                                          : Colors.grey[300]!,
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Long term",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      Container(
                                        padding: EdgeInsets.all(12.w),
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? Color(0xff252525)
                                              : Colors.grey[100],
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          border: Border.all(
                                            color: isDark
                                                ? Color(0xff2F2F2F)
                                                : Colors.grey[300]!,
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Qty.",
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: isDark
                                                        ? Color(0xffC9CACC)
                                                        : Colors.grey[600],
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  "0",
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: isDark
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "Value",
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: isDark
                                                        ? Color(0xffC9CACC)
                                                        : Colors.grey[600],
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  "+₹12,347.00",
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
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
                                            Text(
                                              "View Chart",
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: isDark
                                                      ? Color(0xffEBEEF5)
                                                      : Color(0xffEBEEF5)),
                                            ),
                                          ],
                                        ),
                                      )),
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
                                            Text(
                                              "Stock Details",
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: isDark
                                                      ? Color(0xffEBEEF5)
                                                      : Color(0xffEBEEF5)),
                                            ),
                                          ],
                                        ),
                                      )),
                                    ],
                                  )),
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
      // Bottom navigation with action buttons
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Show selection bar when keyboard is visible or search is focused
          if (_searchFocusNode.hasFocus || isKeyboardVisible)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xff1A1A1A) : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, -1),
                  ),
                ],
                border: Border(
                  top: BorderSide(
                    color: isDark ? Colors.grey[900]! : Colors.grey[300]!,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "$totalAmount ($selectedStocksCount selected)",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle continue action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1DB954),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 10.h),
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          // Standard bottom navigation buttons

          Padding(
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
        ],
      ),
    );
  }
}
