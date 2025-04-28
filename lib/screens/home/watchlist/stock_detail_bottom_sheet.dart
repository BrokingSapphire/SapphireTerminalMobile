import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fl_chart/fl_chart.dart';

/// A draggable bottom sheet that displays detailed stock information
/// Initially shows partial content and expands when dragged up
class StockDetailBottomSheet extends StatefulWidget {
  final String stockName;
  final String stockCode;
  final String price;
  final String change;
  final VoidCallback? onBuy;
  final VoidCallback? onSell;

  const StockDetailBottomSheet({
    Key? key,
    required this.stockName,
    required this.stockCode,
    required this.price,
    required this.change,
    this.onBuy,
    this.onSell,
  }) : super(key: key);

  @override
  State<StockDetailBottomSheet> createState() => _StockDetailBottomSheetState();
}

class _StockDetailBottomSheetState extends State<StockDetailBottomSheet> {
  // Tab selection states
  String selectedEarningsTab = 'Revenue';
  String earningsPeriod = 'Yearly';
  String shareholdingPeriod = 'Mar 2025';

  // DraggableScrollableController to manage the sheet's expanded state
  final DraggableScrollableController _controller =
      DraggableScrollableController();

  // Initial and expanded sheet sizes as fraction of screen height
  final double _initialChildSize =
      0.39; // Initial size when bottom sheet appears
  final double _minChildSize = 0.0; // Minimum size sheet can be collapsed to
  final double _maxChildSize = 1.0; // Maximum size sheet can be expanded to

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current theme brightness
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Show the DraggableScrollableSheet
    return DraggableScrollableSheet(
      initialChildSize: _initialChildSize,
      minChildSize: _minChildSize,
      maxChildSize: _maxChildSize,
      controller: _controller,
      builder: (context, scrollController) {
        return Container(
          // Style for the bottom sheet with rounded corners at the top
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF121212) : Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            children: [
              // Drag handle at the top of the sheet
              _buildDragHandle(isDark),
              Padding(
                padding: EdgeInsets.only(left: 16.h, right: 16.h, top: 12.w),
                child: _buildHeader(isDark),
              ),
              SizedBox(
                height: 3.h,
              ),
              // Main content section with ScrollView
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header showing stock information

                        Divider(
                            color: isDark
                                ? const Color(0xFF2F2F2F)
                                : const Color(0xFFD1D5DB)),
                        SizedBox(height: 8.h),

                        // Buy/Sell Buttons
                        _buildBuySellButtons(),
                        SizedBox(height: 25.h),

                        // Action Icons for quick actions
                        _buildActionIcons(isDark),
                        SizedBox(height: 16.h),
                        Divider(
                            color: isDark
                                ? const Color(0xFF2F2F2F)
                                : const Color(0xFFD1D5DB)),
                        // View Chart Link
                        SizedBox(height: 8.h),
                        _buildViewChartLink(),
                        SizedBox(height: 8.h),
                        Divider(
                            color: isDark
                                ? const Color(0xFF2F2F2F)
                                : const Color(0xFFD1D5DB)),

                        // Market Depth section
                        _buildSectionHeader(isDark, 'Market Depth'),
                        SizedBox(height: 10.h),
                        _buildMarketDepthTable(isDark),
                        Center(
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Show 20 depth',
                              style: TextStyle(
                                color: Color(0xff1DB954),
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                            color: isDark
                                ? const Color(0xFF2F2F2F)
                                : const Color(0xFFD1D5DB)),

                        // Performance section
                        _buildSectionHeader(isDark, 'Performance'),
                        SizedBox(height: 10.h),
                        _buildPerformanceSection(isDark),
                        Divider(
                            color: isDark
                                ? const Color(0xFF2F2F2F)
                                : const Color(0xFFD1D5DB)),

                        // Fundamental Ratios grid display
                        _buildSectionHeader(isDark, 'Fundamental Ratios'),
                        SizedBox(height: 10.h),
                        _buildRatiosGrid(isDark),
                        Divider(
                            color: isDark
                                ? const Color(0xFF2F2F2F)
                                : const Color(0xFFD1D5DB)),

                        // Shareholding Pattern with pie chart
                        _buildShareholdingHeader(isDark),
                        SizedBox(height: 16.h),
                        buildShareholdingChart(isDark),
                        Divider(
                            color: isDark
                                ? const Color(0xFF2F2F2F)
                                : const Color(0xFFD1D5DB)),

                        // Earnings section with chart
                        _buildEarningsHeader(isDark),
                        SizedBox(height: 16.h),
                        _buildEarningsTabs(isDark),
                        SizedBox(height: 16.h),
                        _buildEarningsChart(isDark),
                        SizedBox(height: 10.h),
                        Center(
                          child: Text(
                            '*All values are in crore',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        Divider(
                            color: isDark
                                ? const Color(0xFF2F2F2F)
                                : const Color(0xFFD1D5DB)),

                        // About Company section
                        _buildSectionHeader(isDark, 'About Company'),
                        SizedBox(height: 16.h),
                        Text(
                          'Reliance Industries Limited (RIL) is India\'s largest private sector company. The company\'s activities span hydrocarbon exploration and production, petroleum refining and marketing, petrochemicals, advanced materials and composites, renewables (solar and hydrogen), retail and digital services. The company\'s products range is from the exploration and production of oil and gas to the manufacture of petroleum products, polyester products, polyester intermediates, plastics, polymer intermediates, chemicals, synthetic textiles and fabrics.',
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black87,
                            fontSize: 14.sp,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        _buildCompanyDetailsTable(isDark),
                        SizedBox(height: 24.h),
                        Divider(
                            color: isDark
                                ? const Color(0xFF2F2F2F)
                                : const Color(0xFFD1D5DB)),
                        // Locate Section
                        SizedBox(height: 24.h),
                        _buildLocateSection(isDark),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Drag handle widget for visual indication that sheet is draggable
  Widget _buildDragHandle(bool isDark) {
    return Container(
      width: double.infinity,
      height: 24.h,
      alignment: Alignment.center,
      child: Container(
        width: 40.w,
        height: 4.h,
        margin: EdgeInsets.only(top: 12.h),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade600 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }

  // Header with stock name, code, price and change information
  Widget _buildHeader(bool isDark) {
    return Row(
      children: [
        // Company logo
        CircleAvatar(
          radius: 18.r,
          backgroundImage: AssetImage("assets/images/reliance logo.png"),
        ),
        SizedBox(width: 12.w),
        // Stock name and code
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.stockName,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              Text(
                widget.stockCode,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
        // Price and change
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              widget.price,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            Text(
              widget.change,
              style: TextStyle(
                // Green for positive change, would be red for negative
                color: widget.change.contains('+') ? Colors.green : Colors.red,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Buy and Sell action buttons
  Widget _buildBuySellButtons() {
    return Row(
      children: [
        // Buy button
        Expanded(
          child: SizedBox(
            height: 50.h,
            child: ElevatedButton(
              onPressed: widget.onBuy,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF22A06B), // Green for buy
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'BUY',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        // Sell button
        Expanded(
          child: SizedBox(
            height: 50.h,
            child: ElevatedButton(
              onPressed: widget.onSell,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE53935), // Red for sell
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'SELL',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Quick action icons row
  Widget _buildActionIcons(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionItem(
          isDark,
          'assets/svgs/setAlert.svg',
          'Set Alert',
        ),
        _buildActionItem(
          isDark,
          'assets/svgs/optionChain.svg',
          'Option Chain',
        ),
        _buildActionItem(
          isDark,
          'assets/svgs/stockSip.svg',
          'Stock SIP',
        ),
      ],
    );
  }

  // Individual action item with icon and label
  Widget _buildActionItem(bool isDark, String iconPath, String label) {
    return Column(
      children: [
        // SVG icon with proper color based on theme
        SvgPicture.asset(
          iconPath,
          height: 22.h,
          width: 22.w,
        ),
        SizedBox(height: 10.h),
        // Action label
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }

  // "View Chart" link button
  Widget _buildViewChartLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'View Chart',
          style: TextStyle(
            color: Color(0xFF1DB954),
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 5.w),
        SvgPicture.asset(
          'assets/svgs/charts.svg',
          height: 22.h,
          color: Color(0xFF1DB954),
          width: 22.w,
        ),
      ],
    );
  }

  // Section header with title and optional info icon
  Widget _buildSectionHeader(bool isDark, String title) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 4.w),
        Icon(
          Icons.info_outline,
          color: isDark ? Colors.white : Colors.grey,
          size: 16.sp,
        ),
      ],
    );
  }

  // Market depth table with bid and offer data
  Widget _buildMarketDepthTable(bool isDark) {
    return Column(
      children: [
        // Table header
        Row(
          children: [
            // Bid side
            Expanded(
              flex: 1,
              child: Text(
                'Bid',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Orders',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Qty.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Gap
            SizedBox(width: 16.w),

            // Offer side
            Expanded(
              flex: 1,
              child: Text(
                'Offers',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Orders',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Qty.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        // Market depth rows - using the original function
        _buildDepthRow(isDark, '777.67', '2', '29', false),
        _buildDepthRow(isDark, '223.45', '6', '110', false),
        _buildDepthRow(isDark, '33.57', '8', '126', false),
        _buildDepthRow(isDark, '22.5', '13', '196', false),
        _buildDepthRow(isDark, '346.46', '15', '257', false),
        SizedBox(height: 8.h),
        Divider(
            color: isDark ? const Color(0xFF2F2F2F) : const Color(0xFFD1D5DB)),
        // Totals row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total buy: 8,99,356',
              style: TextStyle(
                color: isDark ? Colors.grey : Colors.black,
                fontSize: 14.sp,
              ),
            ),
            Text(
              'Total Sell: 8,99,356',
              style: TextStyle(
                color: isDark ? Colors.grey : Colors.black,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }

// Create a new function with a different name to handle the row display
  Widget _buildMarketRowWithGap(bool isDark, String price, String orders,
      String qty, bool isHighlighted) {
    return Row(
      children: [
        // Bid side
        Expanded(
          flex: 1,
          child: Text(
            price,
            style: TextStyle(
              color: Colors.green,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            orders,
            style: TextStyle(
              color: Colors.green,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            qty,
            style: TextStyle(
              color: Colors.green,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        // Gap between bid and offer
        SizedBox(width: 16.w),

        // Offer side
        Expanded(
          flex: 1,
          child: Text(
            price,
            style: TextStyle(
              color: Colors.red,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            orders,
            style: TextStyle(
              color: Colors.red,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            qty,
            style: TextStyle(
              color: Colors.red,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  // Individual row in the market depth table
  Widget _buildDepthRow(
      bool isDark, String price, String orders, String qty, bool isHeader) {
    final TextStyle textStyle = TextStyle(
      color: isHeader
          ? Colors.grey
          : (price == '346.46' ? Colors.green : Colors.red),
      fontSize: 14.sp,
      fontWeight: isHeader ? FontWeight.normal : FontWeight.w500,
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          // Bid Side (Left columns)
          Expanded(
            flex: 1,
            child: Text(
              price,
              style: textStyle.copyWith(color: Colors.green),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              orders,
              style: textStyle.copyWith(color: Colors.green),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              qty,
              style: textStyle.copyWith(color: Colors.green),
              textAlign: TextAlign.center,
            ),
          ),
          // Offer Side (Right columns)
          Expanded(
            flex: 1,
            child: Text(
              price,
              style: textStyle.copyWith(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              orders,
              style: textStyle.copyWith(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              qty,
              style: textStyle.copyWith(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // Performance metrics section with sliders
  Widget _buildPerformanceSection(bool isDark) {
    double todaysLow = 1467.00;
    double todaysHigh = 1567.00; // Example higher value
    double currentPrice = 1500.00;
    return Column(
      children: [
        // Today's range
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Today\'s Low',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
            ),
            Text(
              'Today\'s High',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '1,467.00',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '1,467.00',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        // Today's slider
        Container(
          height: 4.h,
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [Colors.red, Colors.yellow, Colors.green],
            // ),
            color: Color(0xff1DB954),
            borderRadius: BorderRadius.circular(2.r),
          ),
          child: Row(
            children: [
              Container(
                width: 100.w,
                height: 4.h,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Icon(
                      Icons.arrow_drop_up,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // 52 Week range
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '52 Week Low',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
            ),
            Text(
              '52 Week High',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '1,467.00',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '1,467.00',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        // 52 Week slider
        Container(
          height: 4.h,
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [Colors.red, Colors.yellow, Colors.green],
            // ),
            color: Color(0xff1DB954),
            borderRadius: BorderRadius.circular(2.r),
          ),
          child: Row(
            children: [
              Container(
                width: 150.w,
                height: 4.h,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Icon(
                      Icons.arrow_drop_up,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Other performance metrics in grid
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            // Open price
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Open',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '1,467.00',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // High price
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'High',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '1,597.00',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Low price
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Low',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '1,397.00',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Previous close price
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prev. Closed',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '1,467.00',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // Additional metrics row
        Row(
          children: [
            // Volume
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Volume',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '1,467.00',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Upper Circuit
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upper Circuit',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '1,467.00',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Lower Circuit
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lower Circuit',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '1,467.00',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Market Cap
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Market Cap',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '17,61,535 Cr',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 12.h,
        )
      ],
    );
  }

  // Grid of fundamental financial ratios
  Widget _buildRatiosGrid(bool isDark) {
    // Data structure for the ratios grid
    final List<List<String>> ratiosData = [
      ['PE Ratio', '7.72', 'Price to Book Value', '7.72'],
      ['EV to EBIT', '9.06', 'EV to EBITDA', '7.72'],
      ['EV to Capital Employed', '7.72', 'EV to Sales', '7.72'],
      ['PG Ratio', '7.72', 'Dividend Yield', '7.72'],
      ['ROCE (Latest)', '7.72', 'ROC (Latest)', '7.72'],
    ];

    // The full height divider approach
    return Container(
      color: isDark ? Color(0xFF121212) : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fundamental Ratios header with info icon

          // Container that wraps the entire grid with a vertical divider
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left column
                Expanded(
                  child: Column(
                    children: ratiosData.map((row) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              row[0],
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              row[1],
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),

                // Vertical divider that spans the whole grid
                Container(
                  width: 1,
                  height: ratiosData.length *
                      35.0, // Approximate height based on rows
                  color: isDark ? Color(0xFF2F2F2F) : Color(0xFFECECEC),
                ),

                // Right column
                Expanded(
                  child: Column(
                    children: ratiosData.map((row) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16, left: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              row[2],
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              row[3],
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Shareholding pattern header with period selector
  Widget _buildShareholdingHeader(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Section title
        _buildSectionHeader(isDark, 'Shareholding Pattern'),
        // Period selector dropdown
        GestureDetector(
          onTap: () {
            // Show period selector dialog when implemented
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2F2F2F) : const Color(0xFFECECEC),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Row(
              children: [
                Text(
                  shareholdingPeriod,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: isDark ? Colors.white : Colors.black87,
                  size: 16.sp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

// Shareholding pie chart with labels
  Widget buildShareholdingChart(bool isDark) {
    // Using fl_chart for better pie chart visualization
    return Container(
      height: 240,
      child: Row(
        children: [
          // Pie Chart
          Container(
            width: 180,
            height: 180,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 40,
                sectionsSpace: 0,
                startDegreeOffset: 0,
                sections: [
                  PieChartSectionData(
                    value: 25,
                    color: Colors.orange,
                    radius: 50,
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: 25,
                    color: Colors.teal,
                    radius: 50,
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: 25,
                    color: Colors.red.shade300,
                    radius: 50,
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: 25,
                    color: Colors.amber,
                    radius: 50,
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: 25,
                    color: Colors.purple.shade300,
                    radius: 50,
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: 25,
                    color: Colors.blue,
                    radius: 50,
                    showTitle: false,
                  ),
                ],
              ),
            ),
          ),
          // Chart labels with color indicators
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildChartLabel(isDark, Colors.orange, 'Promoter - 25%'),
                buildChartLabel(isDark, Colors.teal, 'FIIs - 25%'),
                buildChartLabel(
                    isDark, Colors.red.shade300, 'Mutual Funds - 25%'),
                buildChartLabel(
                    isDark, Colors.amber, 'Insurance Companies - 25%'),
                buildChartLabel(
                    isDark, Colors.purple.shade300, 'Other DIIs - 25%'),
                buildChartLabel(isDark, Colors.blue, 'Non Institution - 25%'),
              ],
            ),
          ),
        ],
      ),
    );
  }

// Individual chart label with color indicator
  Widget buildChartLabel(bool isDark, Color color, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          // Color indicator circle
          Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8.0),
          // Label text
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  // Earnings section header with period selector
  Widget _buildEarningsHeader(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Section title
        _buildSectionHeader(isDark, 'Earnings'),
        // Period selector dropdown (Yearly/Quarterly)
        GestureDetector(
          onTap: () {
            // Show period selector dialog
            _showPeriodSelector(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2F2F2F) : const Color(0xFFECECEC),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Row(
              children: [
                Text(
                  earningsPeriod,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: isDark ? Colors.white : Colors.black87,
                  size: 16.sp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to show period selector
  void _showPeriodSelector(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      builder: (context) => Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Yearly',
                  style:
                      TextStyle(color: isDark ? Colors.white : Colors.black87)),
              onTap: () {
                setState(() {
                  earningsPeriod = 'Yearly';
                });
                Navigator.pop(context);
              },
              trailing: earningsPeriod == 'Yearly'
                  ? Icon(Icons.check, color: Colors.green)
                  : null,
            ),
            ListTile(
              title: Text('Quarterly',
                  style:
                      TextStyle(color: isDark ? Colors.white : Colors.black87)),
              onTap: () {
                setState(() {
                  earningsPeriod = 'Quarterly';
                });
                Navigator.pop(context);
              },
              trailing: earningsPeriod == 'Quarterly'
                  ? Icon(Icons.check, color: Colors.green)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // Earnings data type selector tabs
  Widget _buildEarningsTabs(bool isDark) {
    return Row(
      children: [
        // Revenue tab
        _buildEarningsTab(isDark, 'Revenue', selectedEarningsTab == 'Revenue'),
        SizedBox(width: 10.w),
        // Profit tab
        _buildEarningsTab(isDark, 'Profit', selectedEarningsTab == 'Profit'),
        SizedBox(width: 10.w),
        // Net Worth tab
        _buildEarningsTab(
            isDark, 'Net Worth', selectedEarningsTab == 'Net Worth'),
      ],
    );
  }

  // Individual earnings tab
  Widget _buildEarningsTab(bool isDark, String title, bool isSelected) {
    return GestureDetector(
      onTap: () {
        // Update selected tab on tap
        setState(() {
          selectedEarningsTab = title;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? Colors.grey.shade800 : Colors.grey.shade300)
              : Colors.transparent,
          border: Border.all(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 14.sp,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Earnings bar chart visualization
  Widget _buildEarningsChart(bool isDark) {
    // Bar chart for earnings data
    return Container(
      height: 200.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Year-wise earnings bars
          _buildBarChartColumn(isDark, '2020', 3246, 9246),
          _buildBarChartColumn(isDark, '2021', 4246, 9246),
          _buildBarChartColumn(isDark, '2022', 6246, 9246),
          _buildBarChartColumn(isDark, '2023', 8246, 9246),
          _buildBarChartColumn(isDark, '2024', 9246, 9246),
        ],
      ),
    );
  }

  // Individual bar in the earnings chart
  Widget _buildBarChartColumn(
      bool isDark, String year, int value, int maxValue) {
    // Calculate bar height as percentage of maximum value
    final double percentage = value / maxValue;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Value label at top of bar
        Text(
          value.toString(),
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 4.h),
        // Bar visualization
        Container(
          width: 30.w,
          height: 150.h * percentage,
          decoration: BoxDecoration(
            color: Color(0xff1DB954),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(2.r),
            ),
          ),
        ),
        SizedBox(height: 4.h),
        // Year label below bar
        Text(
          year,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  // Company details in table format
  Widget _buildCompanyDetailsTable(bool isDark) {
    // Company information
    final Map<String, String> details = {
      'Company name': 'Reliance Industries Ltd.',
      'Founded': '1958',
      'Managing Director': 'Mr. Mukesh Ambani',
      'Industry': 'Refineries',
      'Market Cap Category': 'Large Cap',
    };

    return Column(
      children: details.entries.map((entry) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Detail label
              Expanded(
                flex: 2,
                child: Text(
                  entry.key,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              // Detail value
              Expanded(
                flex: 3,
                child: Text(
                  entry.value,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // Locate section with card selectors
  Widget _buildLocateSection(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Section title
        Text(
          'Locate',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        // Card selector buttons
        Row(
          children: [
            // Card 1 button
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              child: Text(
                'Card 1',
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            // Card 2 button
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              child: Text(
                'Card 2',
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
