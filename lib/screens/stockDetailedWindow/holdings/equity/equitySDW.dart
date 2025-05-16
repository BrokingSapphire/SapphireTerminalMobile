// File: equitySDW.dart
// Description: Equity details screen for the Sapphire Trading application.
// This screen displays comprehensive information about an equity position including
// overall performance, price details, stock metrics, and action options.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/flutter_svg.dart'; // For SVG image rendering
import 'package:sapphire/main.dart'; // For navigation utilities
import 'package:sapphire/screens/stockDetailedWindow/holdings/viewAllTransactions/shortTermTxn.dart'; // For viewing all transactions

/// EquityDetails - Widget that displays detailed information about an equity position
/// Shows comprehensive equity information with performance metrics and action options
class EquityDetails extends StatefulWidget {
  const EquityDetails({super.key});

  @override
  State<EquityDetails> createState() => _EquityDetailsState();
}

/// State class for the EquityDetails widget
/// Manages the display of equity details and related actions
class _EquityDetailsState extends State<EquityDetails> {
  // Add a focus node to track when search field is focused
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  // Mock data for selected stocks
  bool isStockSelected = true; // Whether the stock is selected
  int selectedStocksCount = 2; // Number of selected stocks
  String totalAmount = '₹12,445.60'; // Total investment amount

  @override
  void initState() {
    super.initState();
    // Listen for focus changes to show/hide bottom bar
    _searchFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    // Clean up resources when widget is disposed
    _searchFocusNode.removeListener(_onFocusChange);
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  /// Handles focus changes for search field
  /// Rebuilds UI when search focus changes
  void _onFocusChange() {
    // Trigger rebuild when focus changes
    setState(() {});
  }

  /// Creates an information card with label and value
  /// @param title - Label for the information
  /// @param value - Value to display
  /// @param isRed - Whether to show the value in red (for negative values)
  /// @return Widget - Formatted information card
  Widget _buildInfoCard(String title, String value, {bool isRed = false}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Information label
        Text(
          title,
          style: TextStyle(
            fontSize: 11.sp,
            color: isDark ? Color(0xffc9cacc) : Colors.grey[600],
          ),
        ),
        SizedBox(height: 4.h),
        // Information value
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            color: isRed
                ? Colors.red // Red for negative/loss values
                : (isDark ? Color(0xffEBEEF5) : Colors.black),
          ),
        ),
      ],
    );
  }

  /// Creates an average information card with larger text
  /// @param title - Label for the information
  /// @param value - Value to display
  /// @param isRed - Whether to show the value in red (for negative values)
  /// @return Widget - Formatted information card with larger text
  Widget _buildAvgInfoCard(String title, String value, {bool isRed = false}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Information label
        Text(
          title,
          style: TextStyle(
            fontSize: 13.sp, // Larger font size for average card
            color: isDark ? Color(0xffc9cacc) : Colors.grey[600],
          ),
        ),
        SizedBox(height: 4.h),
        // Information value
        Text(
          value,
          style: TextStyle(
            fontSize: 15.sp, // Larger font size for average card
            color: isRed
                ? Colors.red // Red for negative/loss values
                : (isDark ? Color(0xffEBEEF5) : Colors.black),
          ),
        ),
      ],
    );
  }

  /// Creates an action button with icon and label
  /// @param iconPath - Path to the SVG icon
  /// @param label - Text label for the action
  /// @return Widget - Formatted action button
  Widget _buildActionButton(String iconPath, String label) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        // Action icon
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
        // Action label
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

  /// Creates a position row with title, quantity and value
  /// @param title - Position type title
  /// @param qty - Position quantity
  /// @param value - Position value
  /// @param isShort - Whether this is a short-term position (red) or long-term (green)
  /// @return Widget - Formatted position row
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
          // Position title column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title, // Position type (Short term/Long term)
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: isDark ? Colors.grey : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          // Quantity and value column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  qty, // Position quantity
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  value, // Position value
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: isShort ? Colors.red : Colors.green, // Red for short-term (typically losses), green for long-term (typically gains)
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
        // Back button
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        // Title section with stock info
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Stock symbol
                Text(
                  "ALKYLAMINE",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : Colors.black),
                ),
                SizedBox(width: 10.w),
                // Exchange indicator (NSE)
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
            // Price with change percentage
            RichText(
              text: TextSpan(
                text: "₹1,256.89 ", // Current price
                style: TextStyle(
                    fontSize: 13.sp,
                    color: isDark ? Colors.white : Color(0xff6B7280)),
                children: [
                  TextSpan(
                    text: "(+1.67%)", // Change percentage (green for positive)
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
          // Divider below app bar
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
                    SizedBox(height: 12.h),
                    // Overall Loss Section - Shows performance metrics
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
                          // Section header
                          Row(
                            children: [
                              Text(
                                "Overall Loss", // Performance header
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: isDark
                                      ? Color(0xffc9cacc)
                                      : Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          // Loss amount and percentage
                          Row(
                            children: [
                              Text(
                                "-₹22,678.80", // Loss amount (negative)
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.red, // Red for loss
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                "(-2.78%)", // Loss percentage
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.red, // Red for loss
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          // Position details in two columns
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Left column of position metrics
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInfoCard("Total Qty.", "1500/1500"), // Total quantity
                                    SizedBox(height: 12.h),
                                    _buildInfoCard("Invested", "₹12,445.78"), // Total invested amount
                                    SizedBox(height: 12.h),
                                    _buildInfoCard("Total gain", "₹12,445.60"), // Total unrealized gain/loss
                                  ],
                                ),
                              ),
                              // Right column of position metrics
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInfoCard(
                                        "Avg. Trade Price", "₹327.00"), // Average trade price
                                    SizedBox(height: 12.h),
                                    _buildInfoCard(
                                        "Market Value", "₹12,445.60"), // Current market value
                                    SizedBox(height: 12.h),
                                    _buildInfoCard(
                                        "Total realized gain", "₹12,445.60"), // Total realized gain/loss
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Action Buttons - Set Alert, Option Chain, Create GTT
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
                              "assets/svgs/notification.svg", "Set Alert"), // Create price alerts
                          _buildActionButton(
                              "assets/svgs/chain.svg", "Option Chain"), // View option chain
                          _buildActionButton(
                              "assets/svgs/createGtt.svg", "Create GTT"), // Create Good Till Triggered order
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Price Details Section - Shows price metrics
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
                          // Average traded price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildAvgInfoCard("Avg. Traded Price", "₹678.80"), // Average trade price
                            ],
                          ),
                          SizedBox(height: 16.h),
                          // Price details row
                          Row(
                            children: [
                              Expanded(
                                child: _buildInfoCard(
                                    "Avg. Price without charges", "₹445.60"), // Actual price before charges
                              ),
                              Expanded(
                                  child: _buildInfoCard(
                                      "Charges Per Share", "₹7.00")), // Trading charges per share
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Stock Details Section - Shows transaction history
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
                              // View all transactions link
                              GestureDetector(
                                onTap: () {
                                  navi(ViewAllTransactions(), context);
                                },
                                child: Text(
                                  "View all Transactions",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: const Color(0xff1DB954),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          // Position Rows - Short term and Long term details
                          Row(
                            children: [
                              // Short term container
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 8.h),
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
                                      // Short term header
                                      Text(
                                        "Short term", // Holdings < 1 year
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      // Short term details container
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
                                            // Quantity column
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Qty.", // Quantity
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: isDark
                                                        ? Color(0xffC9CACC)
                                                        : Colors.grey[600],
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  "1000", // Number of shares
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: isDark
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Value column
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "Value", // Current value
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: isDark
                                                        ? Color(0xffC9CACC)
                                                        : Colors.grey[600],
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  "-₹12,347.00", // Loss amount (negative)
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: Colors.red, // Red for loss
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 8.h),
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
                                      // Long term header
                                      Text(
                                        "Long term", // Holdings > 1 year
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      // Long term details container
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
                                            // Quantity column
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Qty.", // Quantity
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: isDark
                                                        ? Color(0xffC9CACC)
                                                        : Colors.grey[600],
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  "0", // Zero shares (no long term holdings)
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: isDark
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Value column
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "Value", // Current value
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: isDark
                                                        ? Color(0xffC9CACC)
                                                        : Colors.grey[600],
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  "+₹12,347.00", // Profit amount (positive)
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: Colors.green, // Green for profit
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
                    SizedBox(height: 12.h),
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
                                      // View Chart button (left)
                                      Expanded(
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/svgs/viewChart.svg",
                                                  color: Color(0xff1db954),
                                                  height: 20.h,
                                                  width: 20.w,
                                                ),
                                                SizedBox(width: 4.w),
                                                Text(
                                                  "View Chart", // View price chart
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: isDark
                                                          ? Color(0xffEBEEF5)
                                                          : Color(0xffEBEEF5)),
                                                ),
                                              ],
                                            ),
                                          )),
                                      // Vertical divider
                                      Container(
                                        width: 2.w,
                                        height: 25.h,
                                        color: Color(0xff2f2f2f),
                                      ),
                                      // Stock Details button (right)
                                      Expanded(
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/svgs/stockDetails.svg",
                                                  color: Color(0xff1db954),
                                                  height: 20.h,
                                                  width: 20.w,
                                                ),
                                                SizedBox(width: 4.w),
                                                Text(
                                                  "Stock Details", // View detailed stock information
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
                  // Selection count and total amount
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
                  // Continue button for selection action
                  ElevatedButton(
                    onPressed: () {
                      // Handle continue action with selected stocks
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
          // Standard bottom navigation buttons - EXIT and ADD
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
            child: Row(
              children: [
                // EXIT button (red) - Sell position
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle EXIT action - Sell shares
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
                      "EXIT", // Sell shares
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // ADD button (green) - Buy more shares
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle ADD action - Buy more shares
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
                      "ADD", // Buy more shares
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