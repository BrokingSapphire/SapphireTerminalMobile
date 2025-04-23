import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/accountSection/FundsAddScreen.dart';
import 'package:sapphire/screens/accountSection/FundsWithdrawScreen.dart';
import 'package:sapphire/utils/constWidgets.dart';

class FundsScreen extends StatefulWidget {
  const FundsScreen({super.key});

  @override
  State<FundsScreen> createState() => _FundsScreenState();
}

class _FundsScreenState extends State<FundsScreen> {
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
      appBar: AppBar(
        backgroundColor: Colors.black, // or your desired color
        elevation: 0,
        scrolledUnderElevation: 0, // prevent shadow when scrolling
        surfaceTintColor: Colors.transparent,
        leadingWidth: 32.w,

        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Funds",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
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
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Total Balance",
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.refresh,
                                    color: Colors.green,
                                    size: 17,
                                  ),
                                  padding: EdgeInsets
                                      .zero, // ✅ Removes extra padding from the button
                                  constraints:
                                      BoxConstraints(), // ✅ Shrinks button to icon size
                                  visualDensity: VisualDensity
                                      .compact, // ✅ Reduces button spacing
                                ),
                              ],
                            ),
                            Center(
                              child: Transform.translate(
                                offset: Offset(-8, -2),
                                child: Text(
                                  '₹ 1,12,532.00',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500),
                                ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
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
                                            color: Color(0xffEBEEF5))),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Text("+"),
                                ),
                                Column(
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
                                            color: Color(0xffEBEEF5))),
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
                      height: 12.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Center(
                              child: Text('Withdraw'),
                            ),
                            height: 42.h,
                            decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4.r),
                                border: Border.all(color: Color(0xff1DB954))),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Container(
                            child: Center(
                              child: Text('Deposit'),
                            ),
                            height: 42.h,
                            decoration: BoxDecoration(
                                color: Color(0xff1DB954),
                                borderRadius: BorderRadius.circular(4.r),
                                border: Border.all(color: Color(0xff1DB954))),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
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
                                  vertical: 20.h, horizontal: 16.w),
                              child: Text(
                                "Total Balance Breakup",
                                style: TextStyle(
                                    fontSize: 15.sp, color: Color(0xffEBEEF5)),
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
                            height: 25.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: CustomGaugeChart(
                                  totalBalance: 112532,
                                  marginUtilized: 12614,
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
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
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
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16.r)),
                                  ),
                                  backgroundColor: Colors.black,
                                  builder: (context) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 20.h),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Total Balance",
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xffEBEEF5)),
                                              ),
                                              Spacer(),
                                              Text(
                                                "₹1,00,000",
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xffEBEEF5)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 16.h),
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
                                          SizedBox(height: 8.h),
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
                                          SizedBox(height: 8.h),
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
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16.r)),
                                  ),
                                  backgroundColor: Colors.black,
                                  builder: (context) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 20.h),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Margin Utilised",
                                                style: TextStyle(
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xffEBEEF5)),
                                              ),
                                              Spacer(),
                                              Text(
                                                "₹5,00,000",
                                                style: TextStyle(
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xffEBEEF5)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 18.h),
                                          Text("Margin",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xffEBEEF5),
                                                  fontSize: 15.sp)),
                                          SizedBox(height: 12.h),
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
                                          SizedBox(height: 18.h),
                                          Text("Premiums",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xffEBEEF5),
                                                  fontSize: 15.sp)),
                                          SizedBox(height: 12.h),
                                          _marginRow(
                                              "FNO Premiums", "₹4,567.67"),
                                          _marginRow(
                                              "Currency Premium", "₹4,567.67"),
                                          _marginRow(
                                              "Commodity Premium", "₹4,567.67"),
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
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16.r)),
                                  ),
                                  backgroundColor: Colors.black,
                                  builder: (context) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 20.h),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Withdrawable Balance",
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xffEBEEF5)),
                                              ),
                                              Spacer(),
                                              Text(
                                                "₹1,00,000",
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xffEBEEF5)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 16.h),
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
        ],
      ),
    );
  }

  Widget _marginRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
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

class CustomGaugeChart extends StatelessWidget {
  final double totalBalance;
  final double marginUtilized;

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
        // Gauge Chart
        CustomPaint(
          size: Size(148.w, 80.h), // Reduced width and height
          painter: GaugeChartPainter(
            totalBalance: totalBalance,
            marginUtilized: marginUtilized,
          ),
        ),
        SizedBox(height: 20.h), // Space between chart and text
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
            // Amount
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

class GaugeChartPainter extends CustomPainter {
  final double totalBalance;
  final double marginUtilized;

  GaugeChartPainter({
    required this.totalBalance,
    required this.marginUtilized,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 4, size.height);
    final radius = size.width * 0.5; // Reduced radius

    // Calculate the angle for margin utilized
    final double ratio = marginUtilized / totalBalance;
    final startAngle = -180 * (3.14159 / 180); // -180 degrees in radians
    final totalAngle = 180 * (3.14159 / 180); // 180 degrees in radians

    // Draw background arc (total balance)
    final backgroundPaint = Paint()
      ..color = Color(0xff38D055)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30.0 // Slightly thinner stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      totalAngle,
      false,
      backgroundPaint,
    );

    // Draw foreground arc (margin utilized)
    final foregroundPaint = Paint()
      ..color = Color(0xffFFC42E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16.0 // Slightly thinner stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      totalAngle * ratio,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
