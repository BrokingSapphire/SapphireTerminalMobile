// File: funds.dart
// Description: Funds management screen in the Sapphire Trading application.
// This screen displays the user's fund balances, allows deposits/withdrawals, and shows breakdowns of fund allocations.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/svg.dart'; // For SVG image rendering
import 'package:sapphire/main.dart'; // App-wide navigation utilities
import 'package:sapphire/screens/funds/deposit/deposit.dart'; // Screen for adding funds (deposits)
import 'package:sapphire/screens/funds/withdrawal/withdrawal.dart'; // Screen for withdrawing funds

/// FundsScreen - Main screen for managing and viewing trading account balances
/// Displays total balance, allows deposits/withdrawals, and shows detailed breakdowns of fund allocations
class FundsScreen extends StatefulWidget {
  const FundsScreen({super.key});

  @override
  State<FundsScreen> createState() => _FundsScreenState();
}

/// State class for the FundsScreen widget
/// Manages the UI display and interactions for funds management
class _FundsScreenState extends State<FundsScreen> {
  /// Handles the pull-to-refresh functionality
  /// Refreshes the fund data from the server (currently just a placeholder)
  Future<void> _onRefresh() async {
    // TODO: Implement actual data refresh logic here (e.g., API call)
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  /// Creates a legend item with a colored circle and label
  /// Used for the balance breakdown chart legend
  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: Color(0xffEBEEF5),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar with back button and title
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0, // prevent shadow when scrolling
        surfaceTintColor: Colors.transparent,
        leadingWidth: 32.w,

        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Funds",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 21.sp),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to previous screen
              },
              icon: Icon(Icons.arrow_back)),
        ),
      ),
      body: Column(
        children: [
          Divider(
            color: Color(0xff2F2F2F),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              color: const Color(0xff1DB954),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      // Total Balance Card
                      // Displays the user's total balance and breakdowns of cash and pledge balances
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            color: Color(0xff121413)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 4.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 8.h,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Total Balance",
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '₹ 1,12,532.00',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Divider(
                                color: Color(0xff2F2F2F),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              // Cash and Pledge Balance breakdown row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Cash Balance section
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Cash Balance",
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Color(0xffc9cacc)),
                                      ),
                                      Text("₹ 12,532.00",
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Color(0xffEBEEF5),
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.w),
                                    child: Text("+"),
                                  ),
                                  // Pledge Balance section
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Pledge Balance",
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Color(0xffc9cacc)),
                                      ),
                                      Text("₹ 13,834.00",
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Color(0xffEBEEF5),
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      // Action buttons row - Withdraw and Deposit
                      Row(
                        children: [
                          // Withdraw button
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                navi(fundsWithdrawScreen(),
                                    context); // Navigate to withdraw funds screen
                              },
                              child: Container(
                                child: Center(
                                  child: Text('Withdraw'),
                                ),
                                height: 42.h,
                                decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(4.r),
                                    border:
                                        Border.all(color: Color(0xff1DB954))),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          // Deposit button
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                navi(fundsAddScreen(),
                                    context); // Navigate to add funds screen
                              },
                              child: Container(
                                child: Center(
                                  child: Text('Deposit'),
                                ),
                                height: 42.h,
                                decoration: BoxDecoration(
                                    color: Color(0xff1DB954),
                                    borderRadius: BorderRadius.circular(4.r),
                                    border:
                                        Border.all(color: Color(0xff1DB954))),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      // Transaction History Button
                      // Navigates to transaction history screen (implementation pending)
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            color: Color(0xff121413)),
                        child: ListTile(
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 17,
                          ),
                          title: Text(
                            "Transaction History",
                            style: TextStyle(fontSize: 15.sp),
                          ),
                          leading: SvgPicture.asset(
                            "assets/svgs/transaction-svgrepo-com.svg",
                            color: Color(0xFFc9cacc),
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      // Balance Breakup visualization Card
                      // Shows a gauge chart representing total balance and margin utilized
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          color: Color(0xff121413),
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16.h, horizontal: 16.w),
                                child: Text(
                                  "Total Balance Breakup",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Color(0xffEBEEF5)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Divider(
                                height: 1.h,
                                color: Color(0xff2F2F2F),
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            // Gauge chart and legend display
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: CustomGaugeChart(
                                    totalBalance: 112532,
                                    marginUtilized: 45614,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    _buildLegendItem(
                                        Color(0xff38D055), "Total Balance"),
                                    SizedBox(height: 15.w),
                                    _buildLegendItem(
                                        Color(0xffFFC42E), "Margin Utilised"),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // Detailed Balance Information Card
                      // Shows expandable sections for Total Balance, Margin Utilized, and Withdrawable Balance
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          color: Color(0xff121413),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              // Total Balance expandable section
                              // Opens bottom sheet with detailed breakdown when tapped
                              GestureDetector(
                                onTap: () {
                                  // Show bottom sheet with balance details
                                  showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(26.r)),
                                    ),
                                    backgroundColor: Color(0xff121413),
                                    builder: (context) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w, vertical: 20.h),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Balance details header
                                            Row(
                                              children: [
                                                Text(
                                                  "Total Balance",
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xffEBEEF5)),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "₹1,00,000",
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xffEBEEF5)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 16.h),
                                            // Balance breakdown details
                                            Row(
                                              children: [
                                                Text(
                                                  "Cash Balance",
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: Color(0xffc9cacc)),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "₹40,000",
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: Color(0xffc9cacc)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 12.h),
                                            Row(
                                              children: [
                                                Text(
                                                  "Collateral Balance",
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: Color(0xffc9cacc)),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "₹60,000",
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: Color(0xffc9cacc)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 12.h),
                                            Row(
                                              children: [
                                                Text(
                                                  "Collateral Balance (Liquid Funds)",
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: Color(0xffc9cacc)),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "₹60,000",
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: Color(0xffc9cacc)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 16.h),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Total Balance",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Color(0xffEBEEF5)),
                                    ),
                                    Spacer(),
                                    Text(
                                      "₹112,532.00",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Color(0xffEBEEF5)),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: Color(0xffEBEEF5),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              // Margin Utilized expandable section
                              // Opens bottom sheet with detailed breakdown of different margin types
                              GestureDetector(
                                onTap: () {
                                  // Show bottom sheet with margin details
                                  showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(26.r)),
                                    ),
                                    backgroundColor: Color(0xff121413),
                                    builder: (context) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w, vertical: 20.h),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Margin details header
                                            Row(
                                              children: [
                                                Text(
                                                  "Margin Utilised",
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xffEBEEF5)),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "₹5,00,000",
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xffEBEEF5)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 16.h),
                                            // Margin breakdown details
                                            Text("Margin",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xffEBEEF5),
                                                    fontSize: 13.sp)),
                                            SizedBox(height: 6.h),
                                            // Different margin type rows
                                            _marginRow(
                                                "Span Margin", "₹4,567.67"),
                                            _marginRow(
                                                "Exposure Margin", "₹4,567.67"),
                                            _marginRow(
                                                "Delivery Amount", "₹4,567.67"),
                                            _marginRow(
                                                "Commodity Additional Margin",
                                                "₹4,567.67"),
                                            _marginRow(
                                                "Cash Intraday / MTF Margin",
                                                "₹4,567.67"),
                                            SizedBox(height: 16.h),
                                            // Premium breakdown details
                                            Text("Premiums",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xffEBEEF5),
                                                    fontSize: 13.sp)),
                                            SizedBox(height: 6.h),
                                            // Different premium type rows
                                            _marginRow(
                                                "FNO Premiums", "₹4,567.67"),
                                            _marginRow("Currency Premium",
                                                "₹4,567.67"),
                                            _marginRow("Commodity Premium",
                                                "₹4,567.67"),
                                            SizedBox(height: 16.h),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Margin Utilised",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Color(0xffEBEEF5)),
                                    ),
                                    Spacer(),
                                    Text(
                                      "₹112,532.00",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Color(0xffEBEEF5),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: Color(0xffEBEEF5),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              // Withdrawable Balance expandable section
                              // Opens bottom sheet with withdrawable balance details
                              GestureDetector(
                                onTap: () {
                                  // Show bottom sheet with withdrawable balance details
                                  showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(26.r)),
                                    ),
                                    backgroundColor: Color(0xff121413),
                                    builder: (context) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w, vertical: 20.h),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Withdrawable balance details header
                                            Row(
                                              children: [
                                                Text(
                                                  "Withdrawable Balance",
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xffEBEEF5)),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "₹1,00,000",
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xffEBEEF5)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 16.h),
                                            // Withdrawal in progress details
                                            Row(
                                              children: [
                                                Text(
                                                  "Withdrawal in Progress",
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: Color(0xffc9cacc)),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "₹40,000",
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: Color(0xffc9cacc)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8.h),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Withdrawable Balance",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Color(0xffEBEEF5)),
                                    ),
                                    Spacer(),
                                    Text(
                                      "₹112,532.00",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Color(0xffEBEEF5)),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: Color(0xffEBEEF5),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Helper widget to create consistent margin item rows
  /// Used in the margin breakdown bottom sheet
  Widget _marginRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 13.sp, color: Color(0xffc9cacc)),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            value,
            style: TextStyle(fontSize: 13.sp, color: Color(0xffc9cacc)),
          ),
        ],
      ),
    );
  }
}

/// CustomGaugeChart - Widget that displays the balance breakdown as a gauge chart
/// Visualizes the relationship between total balance and margin utilized
class CustomGaugeChart extends StatelessWidget {
  final double totalBalance; // Total available balance amount
  final double marginUtilized; // Amount of margin currently being used

  const CustomGaugeChart({
    Key? key,
    required this.totalBalance,
    required this.marginUtilized,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Gauge Chart visualization
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: CustomPaint(
            size: Size(148.w, 80.h), // Reduced width and height
            painter: GaugeChartPainter(
              totalBalance: totalBalance,
              marginUtilized: marginUtilized,
            ),
          ),
        ),
        SizedBox(height: 8.h), // Space between chart and text
        // Margin Utilised Text
        Column(
          children: [
            Text(
              "Margin Utilised",
              style: TextStyle(
                color: Color(0xffc9cacc),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 4.h), // Space between text and amount
            // Amount display
            Text(
              "₹${marginUtilized.toStringAsFixed(2)}",
              style: TextStyle(
                color: Color(0xffEBEEF5),
                fontSize: 15.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// GaugeChartPainter - Custom painter for the semi-circular gauge chart
/// Draws a semi-circular chart showing the proportion of margin utilized to total balance
class GaugeChartPainter extends CustomPainter {
  final double totalBalance; // Total available balance amount
  final double marginUtilized; // Amount of margin currently being used

  GaugeChartPainter({
    required this.totalBalance,
    required this.marginUtilized,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 4, size.height);
    final radius = size.width * 0.4;

    // Calculate the angle for margin utilized
    final double ratio = marginUtilized / totalBalance;
    final startAngle = -180 * (3.14159 / 180); // -180 degrees in radians
    final totalAngle = 180 * (3.14159 / 180); // 180 degrees in radians

    // Draw background arc (total balance)
    final backgroundPaint = Paint()
      ..color = Color(0xff38D055) // Green for total balance
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30.0 // Thick stroke for visibility
      ..strokeCap = StrokeCap.butt; // Flat ends on the arc

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      totalAngle,
      false,
      backgroundPaint,
    );

    // Draw foreground arc (margin utilized)
    final foregroundPaint = Paint()
      ..color = Color(0xffFFC42E) // Yellow/orange for margin utilized
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30.0 // Match background stroke width
      ..strokeCap = StrokeCap.butt; // Flat ends on the arc

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      totalAngle * ratio, // Only draw arc proportional to usage ratio
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always redraw when notified
  }
}
