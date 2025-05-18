// File: longTermTxn.dart
// Description: Long-term transactions history screen for the Sapphire Trading application.
// This screen displays a list of long-term stock transactions organized by month,
// with transaction details and summary information.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:sapphire/utils/constWidgets.dart'; // For common UI components

/// Longtermtxn - Widget that displays long-term stock transaction history
/// Shows transaction details organized by months with summary information
class Longtermtxn extends StatefulWidget {
  const Longtermtxn({Key? key}) : super(key: key);

  @override
  State<Longtermtxn> createState() => _LongtermtxnState();
}

/// State class for the Longtermtxn widget
/// Manages the display of long-term transaction history
class _LongtermtxnState extends State<Longtermtxn> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
  /// @param month - Month and year header (e.g., "April 2024")
  /// @param transactions - List of transaction data for the month
  /// @return Widget - Section with month header and transaction list
  Widget _buildMonthSection(
      String month, List<Map<String, String>> transactions) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

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
              color: isDark ? Color(0xff2f2f2f) : Colors.grey[300], // Theme-aware divider color
            );
          },
        ),
      ],
    );
  }

  /// Builds the Long Term tab content
  /// @return Widget - Long term transactions view with fixed summary and scrollable list
  Widget _buildLongTermTab() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Mock data for long term transactions
    final aprilTransactions = [
      {
        'date': '15 April 2024',
        'quantity': '100 Shares',
        'investedPrice': '₹2,50,000.00',
        'atp': '₹250',
      },
      {
        'date': '10 April 2024',
        'quantity': '80 Shares',
        'investedPrice': '₹2,00,000.00',
        'atp': '₹250',
      },
      {
        'date': '5 April 2024',
        'quantity': '120 Shares',
        'investedPrice': '₹3,00,000.00',
        'atp': '₹250',
      },
      {
        'date': '2 April 2024',
        'quantity': '90 Shares',
        'investedPrice': '₹2,25,000.00',
        'atp': '₹250',
      },
    ];

    final marchTransactions = [
      {
        'date': '25 March 2024',
        'quantity': '70 Shares',
        'investedPrice': '₹1,75,000.00',
        'atp': '₹250',
      },
      {
        'date': '18 March 2024',
        'quantity': '110 Shares',
        'investedPrice': '₹2,75,000.00',
        'atp': '₹250',
      },
      {
        'date': '10 March 2024',
        'quantity': '95 Shares',
        'investedPrice': '₹2,37,500.00',
        'atp': '₹250',
      },
    ];

    final februaryTransactions = [
      {
        'date': '28 February 2024',
        'quantity': '60 Shares',
        'investedPrice': '₹1,50,000.00',
        'atp': '₹250',
      },
      {
        'date': '15 February 2024',
        'quantity': '85 Shares',
        'investedPrice': '₹2,12,500.00',
        'atp': '₹250',
      },
      {
        'date': '5 February 2024',
        'quantity': '100 Shares',
        'investedPrice': '₹2,50,000.00',
        'atp': '₹250',
      },
    ];

    final januaryTransactions = [
      {
        'date': '20 January 2024',
        'quantity': '50 Shares',
        'investedPrice': '₹1,25,000.00',
        'atp': '₹250',
      },
      {
        'date': '12 January 2024',
        'quantity': '75 Shares',
        'investedPrice': '₹1,87,500.00',
        'atp': '₹250',
      },
      {
        'date': '3 January 2024',
        'quantity': '65 Shares',
        'investedPrice': '₹1,62,500.00',
        'atp': '₹250',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Summary section - fixed, non-scrollable
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Container(
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
                            "200", // Number of shares
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
                            "₹1,200.50", // Profit amount (positive value)
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.green, // Green for profit
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
                            "₹5,00,000.00", // Current value in rupees
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
                            "8.5%", // XIRR percentage
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
        ),
        // Scrollable transaction list
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // April 2024 transactions section
                  _buildMonthSection("April 2024", aprilTransactions),
                  SizedBox(height: 16.h),
                  // March 2024 transactions section
                  _buildMonthSection("March 2024", marchTransactions),
                  SizedBox(height: 16.h),
                  // February 2024 transactions section
                  _buildMonthSection("February 2024", februaryTransactions),
                  SizedBox(height: 16.h),
                  // January 2024 transactions section
                  _buildMonthSection("January 2024", januaryTransactions),
                ],
              ),
            ),
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
      body: _buildLongTermTab(),
    );
  }
}