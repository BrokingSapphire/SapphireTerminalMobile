// File: mutualFundsSDW.dart
// Description: Mutual funds details screen for the Sapphire Trading application.
// This screen displays comprehensive information about a mutual fund investment including
// fund details, profit and loss, NAV details, and transaction history with options to exit or add to the position.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:sapphire/main.dart'; // For navigation utilities
import 'package:sapphire/screens/stockDetailedWindow/holdings/viewAllTransactions.dart'; // For viewing all transactions

/// MutualFundsDetails - Widget that displays detailed information about a mutual fund investment
/// Shows complete fund information with P&L, NAV details, and transaction history
class MutualFundsDetails extends StatefulWidget {
  const MutualFundsDetails({Key? key}) : super(key: key);

  @override
  State<MutualFundsDetails> createState() => _MutualFundsDetailsState();
}

/// State class for the MutualFundsDetails widget
/// Manages the display of mutual fund details and related actions
class _MutualFundsDetailsState extends State<MutualFundsDetails> {
  // Add a focus node to track when search field is focused
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

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

  /// Creates an information row with label and value
  /// @param label - Label for the information (left side)
  /// @param value - Value to display (right side)
  /// @param isGreen - Whether to show the value in green (for positive values)
  /// @param alignRight - Whether to align the value to the right
  /// @return Widget - Row with formatted label and value
  Widget _buildInfoRow(String label, String value,
      {bool isGreen = false, bool alignRight = false}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Information label (left)
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: isDark ? Color(0xffc9cacc) : Color(0xff6B7280),
          ),
        ),
        // Information value (right)
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color:
            isGreen ? Colors.green : (isDark ? Colors.white : Colors.black),
          ),
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
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
        // Screen title
        title: Text(
          "My Investment",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black,
          ),
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
                    // Fund Name Section - Shows fund name and category
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: isDark ? Color(0xff121413) : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          // Fund logo/icon
                          Container(
                            width: 32.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                              color: Colors.amber, // Fund brand color
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          // Fund name and category
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Mutual fund name
                                    Expanded(
                                      child: Text(
                                        "Motilal Oswal Midcap Fund Direct Growth",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    // Right chevron icon
                                    Icon(
                                      Icons.chevron_right,
                                      color:
                                      isDark ? Colors.white : Colors.black,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                // Fund type and category
                                Text(
                                  "Regular · Equity-Midcap",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: isDark
                                        ? Color(0xffc9cacc)
                                        : Color(0xff6B7280),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h), // Gap between sections

                    // P&L Section - Shows profit and loss metrics
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: isDark ? Color(0xff121413) : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // P&L header
                          Text(
                            "P&L", // Profit & Loss
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: isDark
                                  ? Color(0xffc9cacc)
                                  : Color(0xff6B7280),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          // Profit amount and percentage
                          Row(
                            children: [
                              Text(
                                "+₹22,678.80", // Profit amount (positive)
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green, // Green for profit
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                "(2.78%)", // Profit percentage
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green, // Green for profit
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          // First row of metrics: Total Quantity and XIRR
                          Row(
                            children: [
                              // Total Quantity column
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Qty.", // Total units held
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: isDark
                                            ? Color(0xffc9cacc)
                                            : Color(0xff6B7280),
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      "100", // Number of units
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // XIRR column (Extended Internal Rate of Return)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "XIRR", // Extended Internal Rate of Return
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: isDark
                                            ? Color(0xffc9cacc)
                                            : Color(0xff6B7280),
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      "0.00%", // XIRR percentage
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
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
                          SizedBox(height: 12.h),
                          // Second row of metrics: Present value and Current value
                          Row(
                            children: [
                              // Present value column
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Present value", // Investment value at purchase
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: isDark
                                            ? Color(0xffc9cacc)
                                            : Color(0xff6B7280),
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      "₹1,34,789.00", // Investment amount
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Current value column
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Current value", // Current market value
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: isDark
                                            ? Color(0xffc9cacc)
                                            : Color(0xff6B7280),
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      "₹1,34,789.00", // Current value
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
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
                    SizedBox(height: 16.h), // Gap between sections

                    // NAV Details Section - Shows Net Asset Value information
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: isDark ? Color(0xff121413) : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        children: [
                          // NAV headers row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Avg Nav", // Average Net Asset Value
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: isDark
                                      ? Color(0xffc9cacc)
                                      : Color(0xff6B7280),
                                ),
                              ),
                              Text(
                                "Units", // Number of units held
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: isDark
                                      ? Color(0xffc9cacc)
                                      : Color(0xff6B7280),
                                ),
                              ),
                              Text(
                                "Current Nav", // Current Net Asset Value
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: isDark
                                      ? Color(0xffc9cacc)
                                      : Color(0xff6B7280),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          // NAV values row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "1500/1500", // Average NAV value
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              Text(
                                "327.00", // Number of units
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              Text(
                                "₹1,34,789.00", // Current NAV value
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h), // Gap between sections

                    // Mutual Fund Details Section - Shows transaction history
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
                                "Mutual Funds Details",
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
                          // Position Rows - Short term and Long term holdings
                          Row(
                            children: [
                              // Short term holdings container
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
                                          fontSize: 14.sp,
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
                                                  "1000", // Number of units
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
                              // Long term holdings container
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
                                          fontSize: 14.sp,
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
                                                  "0", // Zero units (no long term holdings)
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
                    SizedBox(height: 16.h),
                    // Folio number display
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Folio No.: 856846", // Mutual fund folio number
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
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
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          bottom: 16.h + MediaQuery.of(context).viewInsets.bottom * 0,
        ),
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
            // EXIT button (red) - Redeem investment
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Handle EXIT action - Redeem fund units
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
                  "EXIT", // Redeem/Withdraw investment
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // ADD button (green) - Add to investment
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Handle ADD action - Add more investment
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
                  "ADD", // Add more investment units
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