// File: viewAllTransactions.dart
// Description: Transactions history screen for the Sapphire Trading application.
// This screen displays a list of stock transactions organized by time period (short/long term)
// and month, with transaction details and summary information.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:sapphire/utils/constWidgets.dart'; // For common UI components

/// ViewAllTransactions - Widget that displays stock transaction history
/// Shows transaction details organized by time periods and months with summary information
class ViewAllTransactions extends StatefulWidget {
  const ViewAllTransactions({Key? key}) : super(key: key);

  @override
  State<ViewAllTransactions> createState() => _ViewAllTransactionsState();
}

/// State class for the ViewAllTransactions widget
/// Manages the display of transaction history and tab navigation
class _ViewAllTransactionsState extends State<ViewAllTransactions>
    with SingleTickerProviderStateMixin {
  late TabController _tabController; // Controller for tab navigation
  List<String> tabOptions = ['Short Term', 'Long Term']; // Tab options for time periods

  @override
  void initState() {
    super.initState();
    // Initialize tab controller with 2 tabs
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // Clean up resources when widget is disposed
    _tabController.dispose();
    super.dispose();
  }

  /// Builds an individual transaction item widget
  /// @param date - Transaction date
  /// @param quantity - Number of shares in the transaction
  /// @param investedPrice - Total amount invested
  /// @param atp - Average trade price
  /// @return Widget - Formatted transaction information 
  Widget _buildTransactionItem(
      String date, String quantity, String investedPrice, String atp) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First row: Date and Invested Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Transaction date (left)
              Text(
                date,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              // Invested price (right)
              Row(
                children: [
                  Text(
                    "Invested Price: ", // Label
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: isDark ? Colors.white70 : Color(0xff6B7280),
                    ),
                  ),
                  Text(
                    "$investedPrice", // Value
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: isDark ? Colors.white : Color(0xff6B7280),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 4.h),
          // Second row: Quantity and ATP (Average Trade Price)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Quantity (left)
              Row(
                children: [
                  Text(
                    "Quantity: ", // Label
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: isDark ? Colors.white70 : Color(0xff6B7280),
                    ),
                  ),
                  Text(
                    "$quantity", // Value
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: isDark ? Colors.white : Color(0xff6B7280),
                    ),
                  ),
                ],
              ),
              // ATP (right)
              Row(
                children: [
                  Text(
                    "ATP: ", // Label - Average Trade Price
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isDark ? Colors.white70 : Color(0xff6B7280),
                    ),
                  ),
                  Text(
                    "$atp", // Value
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isDark ? Colors.white : Color(0xff6B7280),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds a month section with transactions
  /// @param month - Month and year header (e.g., "April 2025")
  /// @param transactions - List of transaction data for the month
  /// @return Widget - Section with month header and transaction list
  Widget _buildMonthSection(
      String month, List<Map<String, String>> transactions) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Month header
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Text(
            month,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ),
        // List of transactions for the month with dividers
        ListView.separated(
          shrinkWrap: true, // Ensure it doesn't scroll independently
          physics:
          const NeverScrollableScrollPhysics(), // Disable scrolling within ListView
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return _buildTransactionItem(
              transaction['date']!,
              transaction['quantity']!,
              transaction['investedPrice']!,
              transaction['atp']!,
            );
          },
          separatorBuilder: (context, index) {
            // Divider between transactions
            return Divider(
              height: 12.h, // Space above and below the divider
              thickness: 1.h,
              color: isDark
                  ? Color(0xff2f2f2f)
                  : Colors.grey[300], // Theme-aware divider color
            );
          },
        ),
      ],
    );
  }

  /// Builds the Short Term tab content 
  /// @return Widget - Short term transactions view with summary
  Widget _buildShortTermTab() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Mock data for short term transactions
    final aprilTransactions = [
      {
        'date': '12 April 2025',
        'quantity': '60 Shares',
        'investedPrice': '₹1,34,789.00',
        'atp': '₹134',
      },
      {
        'date': '12 April 2025',
        'quantity': '60 Shares',
        'investedPrice': '₹1,34,789.00',
        'atp': '₹134',
      },
      {
        'date': '12 April 2025',
        'quantity': '60 Shares',
        'investedPrice': '₹1,34,789.00',
        'atp': '₹134',
      },
      {
        'date': '12 April 2025',
        'quantity': '60 Shares',
        'investedPrice': '₹1,34,789.00',
        'atp': '₹134',
      },
    ];

    final marchTransactions = [
      {
        'date': '26 March 2025',
        'quantity': '60 Shares',
        'investedPrice': '₹1,34,789.00',
        'atp': '₹134',
      },
      {
        'date': '16 March 2025',
        'quantity': '60 Shares',
        'investedPrice': '₹1,34,789.00',
        'atp': '₹134',
      },
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary section - provides overview of transaction metrics
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: isDark ? Color(0xff121413) : Colors.grey[100],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary header
                  Text(
                    "Summary",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: isDark ? Colors.white : Color(0xff6B7280),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      // Left column - Total Quantity and P&L
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Total Quantity section
                            Text(
                              "Total Qty.", // Total shares held
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: isDark
                                    ? Color(0xffc9cacc)
                                    : Color(0xff6B7280),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              "100", // Number of shares
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            // P&L section (Profit & Loss)
                            Text(
                              "P&L", // Profit & Loss
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: isDark
                                    ? Color(0xffc9cacc)
                                    : Color(0xff6B7280),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              "-₹445.60", // Loss amount (negative value)
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.red, // Red for loss
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Right column - Present Value and XIRR
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Present Value section
                            Text(
                              "Present value", // Current market value
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: isDark
                                    ? Color(0xffc9cacc)
                                    : Color(0xff6B7280),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              "₹1,34,789.00", // Current value in rupees
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            // XIRR section (Extended Internal Rate of Return)
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
                              "₹245.60", // XIRR value
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: isDark ? Colors.white : Colors.black,
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
            SizedBox(height: 16.h),
            // April 2025 transactions section
            _buildMonthSection("April 2025", aprilTransactions),
            SizedBox(height: 16.h),
            // March 2025 transactions section
            _buildMonthSection("March 2025", marchTransactions),
          ],
        ),
      ),
    );
  }

  /// Builds the Long Term tab content
  /// @return Widget - Long term transactions view (empty state)
  Widget _buildLongTermTab() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Empty state display when no long term transactions exist
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Text(
          "No long term transactions available",
          style: TextStyle(
            fontSize: 14.sp,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
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
          "All Transaction",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        // Bottom part of app bar with divider and tab bar
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(41.h),
          child: Column(
            children: [
              // Divider between AppBar title and tab bar
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Divider(
                  height: 1.h,
                  thickness: 1.h,
                  color: isDark ? Color(0xff2f2f2f) : Colors.grey[300],
                ),
              ),
              // Tab bar for Short Term / Long Term selection
              CustomTabBar(
                tabController: _tabController,
                options: tabOptions,
              ),
            ],
          ),
        ),
      ),
      // Tab view content
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildShortTermTab(), // Short Term tab content
          _buildLongTermTab(),  // Long Term tab content
        ],
      ),
    );
  }
}