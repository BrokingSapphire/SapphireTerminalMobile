// File: ordersSDW.dart
// Description: Order details screen for the Sapphire Trading application.
// This screen shows comprehensive information about an executed order including quantity,
// price, order type, and other transaction details.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/svg.dart'; // For SVG image rendering
import 'package:provider/provider.dart'; // For state management

/// OrdersDetails - Widget that displays detailed information about a stock order
/// Shows complete information about an executed order with options for related actions
class OrdersDetails extends StatefulWidget {
  const OrdersDetails({super.key});

  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

/// State class for the OrdersDetails widget
/// Manages the display of order details and related actions
class _OrdersDetailsState extends State<OrdersDetails> {
  /// Creates a row with label and value for stock details section
  /// @param leftText - Label for the detail (left side)
  /// @param rightText - Value of the detail (right side)
  /// @return Widget - Row with formatted label and value
  Widget stockDetailRow(String leftText, String rightText) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left side label (gray color)
        Text(
          leftText,
          style: TextStyle(fontSize: 11.sp, color: Color(0xffC9CACC)),
        ),
        // Right side value (white color)
        Text(
          rightText,
          style: TextStyle(
              fontSize: 11.sp,
              color: isDark ? Color(0xffEBEEF5) : Color(0xffEBEEF5)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
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
        // Title section with stock info and status
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Stock symbol
                Text(
                  "PETRONET",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black),
                ),
                SizedBox(width: 8.w),
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
                SizedBox(width: 6.w),
                // Order type indicator (BUY)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xff1db954).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    "BUY",
                    style: TextStyle(
                      color: const Color(0xff1db954),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                // Order status indicator (EXECUTED)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xff1db954).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    "EXECUTED",
                    style: TextStyle(
                      color: const Color(0xff1db954),
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
                text: "1256.89 ", // Current price
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
          SizedBox(height: 6.h),
          // Divider below app bar
          Divider(
            height: 1.h,
            color: Color(0xff2f2f2f),
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                // Order summary card - shows quantity, price, and order type
                Container(
                  decoration: BoxDecoration(
                    color: isDark ? Color(0xff121413) : Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Filled quantity column
                        Column(
                          children: [
                            Text(
                              "Filed Qty.",
                              style: TextStyle(
                                  fontSize: 11.sp, color: Color(0xffC9CACC)),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "1500/1500", // Executed/Total quantity
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: isDark
                                      ? Color(0xffEBEEF5)
                                      : Color(0xffEBEEF5)),
                            ),
                          ],
                        ),
                        // Average price column
                        Column(
                          children: [
                            Text(
                              "Avg. Price",
                              style: TextStyle(
                                  fontSize: 11.sp, color: Color(0xffC9CACC)),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "327.00", // Average execution price
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: isDark
                                      ? Color(0xffEBEEF5)
                                      : Color(0xffEBEEF5)),
                            ),
                          ],
                        ),
                        // Order type column
                        Column(
                          children: [
                            Text(
                              "Type",
                              style: TextStyle(
                                  fontSize: 11.sp, color: Color(0xffC9CACC)),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "MARKET", // Order type (MARKET/LIMIT)
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: isDark
                                      ? Color(0xffEBEEF5)
                                      : Color(0xffEBEEF5)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                // Action buttons card - Set Alert, Option Chain, Create GTT
                Container(
                  decoration: BoxDecoration(
                    color: isDark ? Color(0xff121413) : Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Set Alert action button
                        Column(
                          children: [
                            SvgPicture.asset(
                              "assets/svgs/createAlertOrderDetails.svg",
                              color: Color(0xff1db954),
                              height: 20.h,
                              width: 20.w,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              " Set Alert", // Create price alert
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: isDark
                                      ? Color(0xffEBEEF5)
                                      : Color(0xffEBEEF5)),
                            ),
                          ],
                        ),
                        // Option Chain action button
                        Column(
                          children: [
                            SvgPicture.asset(
                              "assets/svgs/optionChainOrderDetails.svg",
                              colorFilter: ColorFilter.mode(
                                Color(0xff1db954),
                                BlendMode.srcIn,
                              ),
                              height: 20.h,
                              width: 20.w,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "Option Chain", // View option chain
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: isDark
                                      ? Color(0xffEBEEF5)
                                      : Color(0xffEBEEF5)),
                            ),
                          ],
                        ),
                        // Create GTT action button
                        Column(
                          children: [
                            SvgPicture.asset(
                              "assets/svgs/createGtt.svg",
                              colorFilter: ColorFilter.mode(
                                Color(0xff1db954),
                                BlendMode.srcIn,
                              ),
                              height: 20.h,
                              width: 20.w,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "Create GTT", // Create Good Till Triggered order
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: isDark
                                      ? Color(0xffEBEEF5)
                                      : Color(0xffEBEEF5)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                // Stock details card - comprehensive order information
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDark ? Color(0xff121413) : Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            // Section header
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Stock Details",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: isDark
                                        ? Color(0xffEBEEF5)
                                        : Color(0xffEBEEF5)),
                              ),
                            ),
                            SizedBox(height: 13.h),
                            // Order details rows
                            stockDetailRow("Validity / Product", "Day / NRML"), // Order validity and product type
                            SizedBox(height: 12.h),
                            stockDetailRow("Status", "COMPLETED"), // Order status
                            SizedBox(height: 12.h),
                            stockDetailRow("Price", "0.00"), // Order price (0 for market order)
                            SizedBox(height: 12.h),
                            stockDetailRow("User", "JQN407"), // User ID
                            SizedBox(height: 12.h),
                            stockDetailRow("Trigger price", "0.00"), // Trigger price (if applicable)
                            SizedBox(height: 12.h),
                            stockDetailRow("Time", "2025-05-15 22:00:00"), // Order timestamp
                            SizedBox(height: 12.h),
                            stockDetailRow(
                                "Exchange Time", "2025-05-15 22:00:00"), // Exchange timestamp
                            SizedBox(height: 12.h),
                            stockDetailRow("Order ID", "195868461864684"), // Order ID
                            SizedBox(height: 12.h),
                            stockDetailRow("Exchange ID", "651648348468"), // Exchange order ID
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                // Action buttons card - View Chart, Stock Details
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDark ? Color(0xff121413) : Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      child: Row(
                        children: [
                          // View Chart button (left side)
                          Expanded(
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svgs/viewChart.svg",
                                      colorFilter: ColorFilter.mode(
                                        Color(0xff1db954),
                                        BlendMode.srcIn,
                                      ),
                                      height: 20.h,
                                      width: 20.w,
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
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
                          // Vertical divider between buttons
                          Container(
                            width: 1.w,
                            height: 25.h,
                            color: Color(0xff2f2f2f),
                          ),
                          // Stock Details button (right side)
                          Expanded(
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svgs/stockDetails.svg",
                                      colorFilter: ColorFilter.mode(
                                        Color(0xff1db954),
                                        BlendMode.srcIn,
                                      ),
                                      height: 20.h,
                                      width: 20.w,
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
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
              ],
            ),
          )
        ],
      ),
      // Bottom action buttons - View Position, Reorder
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // View Position button (gray)
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff2f2f2f)),
                  color: Color(0xff2f2f2f),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                height: 40.h,
                child: Center(
                  child: Text("View Position"), // View current position
                ),
              ),
            ),
            SizedBox(width: 10.w),
            // Reorder button (green)
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff1DB954),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                height: 40.h,
                child: Center(
                  child: Text("Reorder"), // Place identical order again
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}