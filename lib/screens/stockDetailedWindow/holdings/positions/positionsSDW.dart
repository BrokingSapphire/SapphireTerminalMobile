// File: positionsSDW.dart
// Description: Position details screen for the Sapphire Trading application.
// This screen displays comprehensive information about a stock position including 
// gains, quantities, buy/sell prices, and provides actions like exit or add to position.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/flutter_svg.dart'; // For SVG image rendering

/// PositionsDetails - Widget that displays detailed information about a stock position
/// Shows complete position details with gains, transaction metrics, and action options
class PositionsDetails extends StatefulWidget {
  const PositionsDetails({Key? key}) : super(key: key);

  @override
  State<PositionsDetails> createState() => _PositionsDetailsState();
}

/// State class for the PositionsDetails widget
/// Manages the display of position details and related actions
class _PositionsDetailsState extends State<PositionsDetails> {
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
  /// @param isGreen - Whether to show the value in green (for positive values)
  /// @return Widget - Formatted information card
  Widget _buildInfoCard(String title, String value, {bool isGreen = false}) {
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
        SizedBox(height: 6.h),
        // Information value
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            color: isGreen
                ? Colors.green // Green for positive/profit values
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

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

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
                SizedBox(width: 8.w),
                // NSE exchange badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
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
                SizedBox(width: 6.w),
                // Position type badge (CARRY FORWARD)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
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
            // Current price with change percentage
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
                    SizedBox(height: 16.h),
                    // Total Gains Card - Shows overall position performance
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
                          // Total Gains header
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
                          SizedBox(height: 6.h),
                          // Gains amount and percentage
                          Row(
                            children: [
                              Text(
                                "+₹22,678.80", // Profit amount
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.green, // Green for profit
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                "(2.78%)", // Percentage gain
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.green, // Green for profit
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          // Position details in two columns
                          Row(
                            children: [
                              // Left column of position metrics
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInfoCard(
                                        "Today's realized G&L", "1500/1500"), // Today's realized Gain & Loss
                                    SizedBox(height: 12.h),
                                    _buildInfoCard(
                                        "Net Quantity", "1 Lot (1 Lot = 76)"), // Net position quantity
                                    SizedBox(height: 12.h),
                                    _buildInfoCard(
                                        "Invested Value", "₹12,445.60"), // Total invested amount
                                  ],
                                ),
                              ),
                              // Right column of position metrics
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInfoCard(
                                        "Avg. Sell Price", "₹327.00"), // Average sell price
                                    SizedBox(height: 12.h),
                                    _buildInfoCard(
                                        "Avg. Buy Price", "₹12,445.60"), // Average buy price
                                    SizedBox(height: 12.h),
                                    _buildInfoCard(
                                        "Market Value", "₹12,445.60"), // Current market value
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          // Action Buttons row - Convert and Stop Loss/Target
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Convert button (for converting position types)
                              Expanded(
                                child: Container(
                                  height: 38.h,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6.h, horizontal: 16.w),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xff2F2F2F)
                                        .withOpacity(0.4)
                                        : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                        color: isDark
                                            ? const Color(0xff2F2F2F)
                                            : Colors.grey[200]!),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Convert", // Convert position type
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              // Stop Loss/Target button
                              Expanded(
                                child: Container(
                                  height: 38.h,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6.h, horizontal: 16.w),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xff2F2F2F)
                                        .withOpacity(0.4)
                                        : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                        color: isDark
                                            ? const Color(0xff2F2F2F)
                                            : Colors.grey[200]!),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Stop Loss/Target", // Set stop loss or target price
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
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

                    SizedBox(height: 12.h),

                    // Secondary Actions Card - Alert, Option Chain, GTT
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
                    SizedBox(height: 16.h),

                    // Buys Section - Details about buy transactions
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: isDark ? Color(0xff121413) : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Section header
                          Text(
                            "Buys",
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          // Buy transaction details
                          Row(
                            children: [
                              // Buy quantity column
                              Expanded(
                                child: Column(
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
                                      "3,000", // Number of shares bought
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Buy price column
                              Expanded(
                                child: Column(
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
                                      "345.55", // Average buy price
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Buy value column
                              Expanded(
                                child: Column(
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
                                      "9,55,456.89", // Total buy value
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Chart and Details Actions - View Chart, Stock Details
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
                                            SizedBox(width: 8.w),
                                            Text(
                                              "View Chart", // View price chart
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
                                    // Vertical divider
                                    Container(
                                      width: 1.w,
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
                                            SizedBox(width: 8.w),
                                            Text(
                                              "Stock Details", // View detailed stock information
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
      // Bottom action buttons - EXIT and ADD
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
        child: Row(
          children: [
            // EXIT button (red) - Close the position
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Handle EXIT action - Close the position
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
                  "EXIT", // Close position/sell
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // ADD button (green) - Increase position size
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Handle ADD action - Increase position size
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
                  "ADD", // Add to position/buy more
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