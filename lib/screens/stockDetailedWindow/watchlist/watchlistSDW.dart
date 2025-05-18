// File: watchlistSDW.dart
// Description: Stock Detail Widget for watchlist items in the Sapphire Trading application.
// This widget provides a detailed stock view with comprehensive information including price,
// chart, market depth, fundamentals, and other stock metrics in an expandable bottom sheet.

import 'package:fl_chart/fl_chart.dart'; // For chart visualizations
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/svg.dart'; // For SVG image rendering
import 'package:sapphire/main.dart'; // For main app components
import 'package:sapphire/screens/optionChain/optionChain.dart'; // Option Chain screen
import 'package:sapphire/utils/constWidgets.dart'; // Common widgets used across the app
import 'package:visibility_detector/visibility_detector.dart'; // For detecting widget visibility

// Import tab content files
import 'news.dart'; // News tab content
import 'events.dart'; // Events tab content

/// watchlistSDW - Widget that displays detailed stock information
/// Shows a comprehensive view of a stock with price, chart, market depth, and other metrics
class watchlistSDW extends StatefulWidget {
  final String stockName; // Name of the stock
  final String stockCode; // Stock code/symbol
  final String price; // Current price of the stock
  final String change; // Price change (positive or negative)
  final VoidCallback onBuy; // Callback for Buy button action
  final VoidCallback onSell; // Callback for Sell button action

  /// Constructor to initialize all stock detail properties
  const watchlistSDW(
      { // Added const constructor
      super.key,
      required this.stockName,
      required this.stockCode,
      required this.price,
      required this.change,
      required this.onBuy,
      required this.onSell});

  @override
  State<watchlistSDW> createState() => _watchlistSDWState();
}

/// State class for the watchlistSDW widget
/// Manages the display of stock details and tab navigation
class _watchlistSDWState extends State<watchlistSDW>
    with TickerProviderStateMixin {
  // Tab selection states
  String selectedEarningsTab = 'Revenue'; // Selected tab in earnings section
  String earningsPeriod = 'Yearly'; // Period selection for earnings data
  String shareholdingPeriod =
      'Mar 2025'; // Period selection for shareholding pattern
  bool isNSE = true; // Toggle between NSE and BSE exchange
  String selectedRange = '1D'; // Selected time range for chart
  bool show20depth = false; // Toggle for showing more market depth rows
  bool scroll = false; // Control for scroll behavior
  final GlobalKey _scrollKey = GlobalKey(); // Key for scroll detection
  final ScrollController scrollController =
      ScrollController(); // Controller for scrolling

  bool isDividerVisible = true; // Visibility state for divider

  // Custom tab bar selection state
  String selectedTab = 'Overview'; // Currently selected main tab

  // Custom tab options for the new tab bar
  List<String> customTabOptions = [
    "Overview",
    "News",
    "Events"
  ]; // Available main tabs

  // TabController for the existing tab system
  late TabController _tabController; // Controller for tab navigation

  // PageController for tab content
  late PageController _pageController; // Controller for tab content pages

  // Scroll controller to track scroll position
  late ScrollController _scrollController; // Controller for main scroll view
  bool _showAppBarTitle =
      false; // Toggle for showing title in app bar when scrolled

  List<String> last12Months = []; // List of past 12 months for period selection

  @override
  void initState() {
    super.initState();
    // Initialize tab controller
    _tabController =
        TabController(length: customTabOptions.length, vsync: this);

    // Initialize page controller with initial page index
    int initialPage = customTabOptions.indexOf(selectedTab);
    if (initialPage < 0) initialPage = 0; // Default to first tab if not found
    _pageController = PageController(initialPage: initialPage);

    // Add listener to update selectedTab when tab changes and sync PageView
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) return;
      setState(() {
        selectedTab = customTabOptions[_tabController.index];
        // Sync page controller with tab controller
        _pageController.animateToPage(
          _tabController.index,
          duration: Duration(milliseconds: 150),
          curve: Curves.easeInOut,
        );
      });
    });

    // Initialize scroll controller for visibility detection
    scrollController.addListener(_checkDividerVisibility);

    // Initialize scroll controller for app bar
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    // Generate last 12 months starting from Mar 2025
    DateTime now = DateTime(2025, 3, 1); // Ensure Mar 2025 is first

    // CHANGE THIS NUMBER TO DISPLAY MORE MONTHS (e.g., 24 for 2 years, 36 for 3 years)
    int numberOfMonthsToShow = 12;

    // Generate list of month names (e.g., "Mar 2025", "Feb 2025", etc.)
    last12Months = List.generate(numberOfMonthsToShow, (index) {
      DateTime date = DateTime(now.year, now.month - index, 1);
      String month = _monthName(date.month);
      return '$month ${date.year}';
    });

    // Set initial value to Mar 2025
    shareholdingPeriod = 'Mar 2025';

    // Debug print to verify list is populated
    print('DEBUG: last12Months: $last12Months');
    print('DEBUG: shareholdingPeriod: $shareholdingPeriod');
  }

  /// Helper method to get month name from month number
  /// @param month - Month number (1-12)
  /// @return String - Three-letter abbreviation for the month name
  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  /// Gets chart data based on selected time range
  /// @param range - Time range selection (e.g., "1D", "1M", "1Y")
  /// @return List<FlSpot> - Data points for the chart
  List<FlSpot> getChartData(String range) {
    switch (range) {
      case '1M':
        return List.generate(
            30, (i) => FlSpot(i.toDouble(), 100 + i.toDouble()));
      case '1Y':
        return List.generate(
            12, (i) => FlSpot(i.toDouble(), 100 + (i * 10 % 30).toDouble()));
      default:
        return List.generate(
            10, (i) => FlSpot(i.toDouble(), 100 + (i * 5).toDouble()));
    }
  }

  @override
  void dispose() {
    // Clean up all controllers
    scrollController.removeListener(_checkDividerVisibility);
    scrollController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  /// Method to check if the divider is visible
  /// Updates scroll state based on divider visibility
  void _checkDividerVisibility() {
    if (_scrollKey.currentContext == null) return;

    final RenderBox box =
        _scrollKey.currentContext!.findRenderObject() as RenderBox;
    final position = box.localToGlobal(Offset.zero);

    // If the divider's top position is outside the visible screen bounds (AppBar height or screen height)
    bool currentlyVisible = position.dy >= kToolbarHeight &&
        position.dy <= MediaQuery.of(context).size.height;

    if (isDividerVisible != currentlyVisible) {
      setState(() {
        isDividerVisible = currentlyVisible;
        scroll = !scroll;
        print("Divider visibility changed: $isDividerVisible");
      });
    }
  }

  /// Scroll listener to update app bar title visibility
  /// Shows/hides app bar title based on scroll position
  void _scrollListener() {
    // Show app bar title after scrolling past a threshold (e.g., 100 pixels)
    if (_scrollController.offset > 100 && !_showAppBarTitle) {
      setState(() {
        _showAppBarTitle = true;
      });
    } else if (_scrollController.offset <= 100 && _showAppBarTitle) {
      setState(() {
        _showAppBarTitle = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the current theme brightness
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Show the DraggableScrollableSheet
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        scrolledUnderElevation: 0,
        leadingWidth: 24.w,
        elevation: 0,
        // Dynamic title that shows when scrolled down
        title: _showAppBarTitle
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stock name
                  Text(
                    widget.stockName,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  // Price and change row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.price,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(width: 4.h),
                      Text(
                        widget.change,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: widget.change.contains('+')
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : null,
        centerTitle: false,
        // Divider at bottom of app bar when title is visible
        bottom: _showAppBarTitle
            ? PreferredSize(
                preferredSize: Size.fromHeight(1.0),
                child: Divider(
                  height: 1.0,
                  thickness: 1.0,
                  color: isDark
                      ? const Color(0xFF2F2F2F)
                      : const Color(0xFFD1D5DB),
                ),
              )
            : null,
        // Action buttons in the app bar
        actions: [
          SizedBox(width: 16.w),
          // Save/watchlist button
          SvgPicture.asset("assets/svgs/save.svg",
              width: 22.w,
              height: 22.h,
              color: isDark ? Colors.white : Colors.black),
          SizedBox(width: 16.w),
          // Option chain button
          GestureDetector(
            onTap: () {
              navi(
                  OptionChainWrapper(
                      symbol: widget.stockName,
                      stockName: widget.stockName,
                      price: widget.price,
                      change: widget.change,
                      exchange: isNSE ? "NSE" : "BSE"),
                  context);
            },
            child: SvgPicture.asset("assets/svgs/chain.svg",
                width: 22.w,
                height: 22.h,
                color: isDark ? Colors.white : Colors.black),
          ),
          SizedBox(width: 16.w),
          // Notification button
          SvgPicture.asset("assets/svgs/notification.svg",
              width: 22.w,
              height: 22.h,
              color: isDark ? Colors.white : Colors.black),
          SizedBox(width: 16.w),
          // Search button
          SvgPicture.asset(
            "assets/svgs/search-svgrepo-com (1).svg",
            color: isDark ? Colors.white : Colors.black,
          ),
          SizedBox(
            width: 16.w,
          )
        ],
      ),
      body: Container(
        // Style for the bottom sheet with rounded corners at the top
        decoration: BoxDecoration(
          color: isDark ? Colors.black : Colors.white,
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
            // Main content section with ScrollView
            Expanded(
              child: RefreshIndicator(
                color: Color(0xff1db954),
                backgroundColor: isDark ? Colors.black : Colors.white,
                onRefresh: () async {
                  // Add your refresh logic here
                  // For example, fetch new data from API
                  await Future.delayed(Duration(seconds: 1));
                  // You can update state or fetch new data here
                },
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Stock header with name, price, and exchange toggle
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 9.h),
                        child: _buildHeader(isDark),
                      ),
                      SizedBox(height: 3.h),
                      Divider(
                          color: isDark
                              ? const Color(0xFF2F2F2F)
                              : const Color(0xFFD1D5DB)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 9.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 12.h),
                            // Stock price chart with time range selection
                            stockChartWidget(
                              dataPoints: getChartData(selectedRange),
                              selectedRange: selectedRange,
                              onRangeSelected: (range) {
                                setState(() {
                                  selectedRange = range;
                                });
                              },
                            ),
                            SizedBox(height: 18.h),
                            Divider(
                                color: isDark
                                    ? const Color(0xFF2F2F2F)
                                    : const Color(0xFFD1D5DB)),
                            // Market depth section
                            _buildSectionHeader(isDark, 'Market Depth'),
                            SizedBox(height: 16.h),
                            _buildMarketDepthTable(isDark),
                            // Toggle button for showing more depth
                            Center(
                              child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      show20depth = !show20depth;
                                    });
                                  },
                                  child: show20depth
                                      ? Text(
                                          'Show 5 depth',
                                          style: TextStyle(
                                            color: Color(0xff1DB954),
                                            fontSize: 14.sp,
                                          ),
                                        )
                                      : Text(
                                          'Show 20 depth',
                                          style: TextStyle(
                                            color: Color(0xff1DB954),
                                            fontSize: 14.sp,
                                          ),
                                        )),
                            ),
                            Divider(
                                key: _scrollKey,
                                color: isDark
                                    ? const Color(0xFF2F2F2F)
                                    : const Color(0xFFD1D5DB)),
                            SizedBox(height: 12.h),

                            // Custom tab bar for Overview, News, Events
                            CustomTabBar(
                              tabController: _tabController,
                              options: customTabOptions,
                            ),

                            // Tab content container
                            SizedBox(height: 16.h),
                            Container(
                              height: 600
                                  .h, // Fixed height that can be adjusted as needed
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  // Overview tab content
                                  SingleChildScrollView(
                                    physics: scroll
                                        ? NeverScrollableScrollPhysics()
                                        : AlwaysScrollableScrollPhysics(),
                                    child: _buildOverviewTab(isDark),
                                  ),
                                  // News tab content
                                  SingleChildScrollView(
                                    child: newsTab(isDark: isDark),
                                  ),
                                  // Events tab content
                                  SingleChildScrollView(
                                    child: EventsTab(isDark: isDark),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      // Persistent footer with Buy and Sell buttons
      persistentFooterButtons: [
        _buildBuySellButtons(),
      ],
    );
  }

  /// Builds the stock header with logo, name, code, price and exchange toggle
  /// @param isDark - Current theme mode
  /// @return Widget - Complete header with stock information
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
              Row(
                children: [
                  Text(
                    widget.stockName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  // Exchange indicator (NSE/BSE)
                  isNSE ? _infoChip("NSE") : _infoChip("BSE")
                ],
              ),
              SizedBox(height: 2.h),
              Text(
                widget.stockCode,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 6.h),
              // Price and change information
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.price,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    widget.change,
                    style: TextStyle(
                      // Green for positive change, red for negative
                      color: widget.change.contains('+')
                          ? Colors.green
                          : Colors.red,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Exchange toggle (NSE/BSE)
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(right: 8.w),
              decoration: BoxDecoration(
                color: isDark ? Color(0xff2F2F2F) : Color(0xfff4f4f9),
                borderRadius: BorderRadius.circular(2.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // NSE toggle button
                  GestureDetector(
                    onTap: () => setState(() => isNSE = true),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      height: 22.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: isNSE
                            ? Color(0xff1db954)
                            : isDark
                                ? Colors.transparent
                                : Color(0xFFF4F4F9),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                      child: Center(
                        child: Text(
                          'NSE',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: isNSE
                                ? Colors.white
                                : isDark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  // BSE toggle button
                  GestureDetector(
                    onTap: () => setState(() => isNSE = false),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      height: 22.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: !isNSE
                            ? Color(0xff1db954)
                            : isDark
                                ? Colors.transparent
                                : Color(0xFFF4F4F9),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                      child: Center(
                        child: Text(
                          'BSE',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: !isNSE
                                ? Colors.white
                                : isDark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Creates an information chip widget for displaying exchange type
  /// @param text - Text to display in the chip (typically NSE or BSE)
  /// @return Widget - A styled chip container with the provided text
  Widget _infoChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Color(0xff303030),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 10.sp, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }

  /// Builds the Buy and Sell action buttons
  /// @return Widget - Row with Buy and Sell buttons
  Widget _buildBuySellButtons() {
    return Column(
      children: [
        SizedBox(height: 8.h),
        Row(
          children: [
            // Buy button
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: ElevatedButton(
                  onPressed: widget.onBuy,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF22A06B), // Green for buy
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Buy',
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
                height: 48.h,
                child: ElevatedButton(
                  onPressed: widget.onSell,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935), // Red for sell
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Sell',
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
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  /// Individual action item with icon and label
  /// @param isDark - Current theme mode
  /// @param iconPath - Path to the SVG icon
  /// @param label - Text label for the action
  /// @return Widget - Column with icon and label
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

  /// Stock chart widget with time range selection
  /// @param dataPoints - List of data points for the chart
  /// @param selectedRange - Currently selected time range
  /// @param onRangeSelected - Callback for when a new range is selected
  /// @return Widget - Chart with time range selection buttons
  Widget stockChartWidget({
    required List<FlSpot> dataPoints,
    required String selectedRange,
    required void Function(String) onRangeSelected,
  }) {
    return Column(
      children: [
        // Chart
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SizedBox(
            height: 250.h,
            child: LineChart(
              LineChartData(
                backgroundColor: Colors.black,
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      // Adjust reserved size to reduce gap between chart and buttons
                      reservedSize: 30.h,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        const months = [
                          'Jan',
                          'Feb',
                          'Mar',
                          'Apr',
                          'May',
                          'Jun',
                          'Jul',
                          'Aug',
                          'Sep',
                          'Oct',
                          'Nov',
                          'Dec'
                        ];
                        return Padding(
                          padding: EdgeInsets.only(top: 16.h),
                          child: Text(
                            months[value.toInt() % 12],
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11.sp,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: dataPoints,
                    isCurved: true,
                    color: const Color(0xff1DB954),
                    barWidth: 2,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  )
                ],
                lineTouchData: LineTouchData(enabled: true),
                minY:
                    dataPoints.map((e) => e.y).reduce((a, b) => a < b ? a : b),
                maxY:
                    dataPoints.map((e) => e.y).reduce((a, b) => a > b ? a : b),
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        // Time Range Buttons - horizontal scrollable row
        Container(
          width: double.infinity,
          height: 40.h,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Regular time range options
                for (var range in [
                  '1D',
                  '1W',
                  '1M',
                  '3M',
                  '6M',
                  '1Y',
                  '5Y',
                  'All',
                ])
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                    ),
                    child: ChoiceChip(
                      // Text label with consistent white color
                      label: Text(range,
                          style:
                              TextStyle(color: Colors.white, fontSize: 13.sp)),
                      selected: selectedRange == range,
                      onSelected: (_) => onRangeSelected(range),
                      // Use #2F2F2F for selected chips
                      selectedColor: const Color(0xFF2F2F2F),
                      // Dark background for unselected chips
                      backgroundColor: Colors.black54,
                      // Remove checkmark icon
                      showCheckmark: false,
                      // Ensure no border is visible
                      side: BorderSide.none,
                      elevation: 0,
                      pressElevation: 0,
                      shadowColor: Colors.transparent,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 2),
                    ),
                  ),
                // Expand button with SVG icon
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.w,
                  ),
                  child: ChoiceChip(
                    // SVG icon instead of text
                    label: SvgPicture.asset(
                      'assets/svgs/expand.svg',
                      height: 18.h,
                      width: 18.w,
                      colorFilter:
                          ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                    selected: selectedRange == 'Expand',
                    onSelected: (_) => onRangeSelected('Expand'),
                    // Use #2F2F2F for selected chips
                    selectedColor: const Color(0xFF2F2F2F),
                    // Dark background for unselected chips
                    backgroundColor: Colors.black54,
                    // Remove checkmark icon
                    showCheckmark: false,
                    // Ensure no border is visible
                    side: BorderSide.none,
                    elevation: 0,
                    pressElevation: 0,
                    shadowColor: Colors.transparent,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Helper method to show info in a modal bottom sheet
  /// @param context - Build context
  /// @param title - Title for the info dialog
  /// @param content - Content text to display
  void _showInfoDialog(BuildContext context, String title, String content) {
    // Get the current theme brightness
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Set a specific height for Fundamental Ratios
    final bool isFundamentalRatios = title == 'Fundamental Ratios';
    final double contentHeight =
        isFundamentalRatios ? 500.h : 300.h; // Default height for other dialogs

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: isDark ? Color(0xff121413) : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with drag handle and close icon
              SizedBox(height: 8.h),

              // Title and close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      child: Icon(
                        Icons.close,
                        color: isDark ? Colors.white : Colors.black54,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Divider(
                color:
                    isDark ? const Color(0xFF2F2F2F) : const Color(0xFFD1D5DB),
              ),
              SizedBox(height: 6.h),

              // Content - with fixed height for Fundamental Ratios
              isFundamentalRatios
                  ? Container(
                      height: contentHeight,
                      child: SingleChildScrollView(
                        child: _buildRichRatioContent(isDark, content),
                      ),
                    )
                  : Flexible(
                      child: SingleChildScrollView(
                        child: Text(
                          content,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.9)
                                : Colors.black87,
                            fontSize: 14.sp,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),

              // Bottom padding
              SizedBox(height: 24.h),
            ],
          ),
        );
      },
    );
  }

  /// Helper method to build rich content for ratio descriptions
  /// @param isDark - Current theme mode
  /// @param content - Raw content text with ratio descriptions
  /// @return Widget - Formatted ratio descriptions
  Widget _buildRichRatioContent(bool isDark, String content) {
    // Split the content by double newlines to separate each ratio
    final List<String> sections = content.split('\n\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sections.map((section) {
        // Split each section into title and description
        final parts = section.split('\n');
        if (parts.length >= 2) {
          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title in bold
                Text(
                  parts[0], // Ratio name
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                // Description
                Text(
                  parts[1], // Ratio description
                  style: TextStyle(
                    color:
                        isDark ? Colors.white.withOpacity(0.8) : Colors.black87,
                    fontSize: 14.sp,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      }).toList(),
    );
  }

  /// Section header with title and optional info icon
  /// @param isDark - Current theme mode
  /// @param title - Section title text
  /// @return Widget - Header row with info icon
  Widget _buildSectionHeader(bool isDark, String title) {
    // Get the appropriate info content based on the section title
    String infoContent = '';
    switch (title) {
      case 'Market Depth':
        infoContent =
            'Market Depth shows the real-time demand and supply for a stock at different price levels. It displays the number of buy and sell orders pending at various prices, helping traders assess liquidity, price movement potential, and the overall sentiment in the market.';
        break;
      case 'Performance':
        infoContent =
            'Performance reflects how a stock has behaved over various timeframes—daily, weekly, monthly, or annually. It includes price change percentages, comparisons with indices or peers, and helps investors evaluate a stock\'s consistency, volatility, and returns.';
        break;
      case 'Fundamental Ratios':
        infoContent = 'P/E Ratio\n'
            'Measures a company\'s current share price relative to its per-share earnings.\n\n'
            'Return on Equity (ROE)\n'
            'Indicates how efficiently a company uses shareholders\' equity to generate profit.\n\n'
            'Earnings Per Share (EPS)\n'
            'Shows the portion of a company\'s profit allocated to each outstanding share.\n\n'
            'Debt to Equity Ratio\n'
            'Compares a company\'s total debt to its shareholders\' equity to assess financial leverage.\n\n'
            'ROCE (Latest)\n'
            'Reflects how efficiently a company generates profits from its total capital employed.\n\n'
            'Sector P/E\n'
            'Represents the average price-to-earnings ratio of companies within the same industry sector.\n\n'
            'Book Value\n'
            'The net asset value of a company per share as recorded in its financial books.\n\n'
            'Face Value\n'
            'The original nominal value of a share as stated by the company.\n\n'
            'ROE (Latest)\n'
            'The most recent measure of how effectively a company generates profits from shareholders\' equity.';
        break;
      case 'Shareholding Pattern':
        infoContent =
            'The Shareholding Pattern reveals the ownership distribution of a company among promoters, institutional investors, foreign investors, and the public. It offers transparency on who controls the company and signals investor confidence or concern.';
        break;
      case 'Earnings':
        infoContent =
            'Earnings indicate a company\'s profitability over a specific period, typically quarterly or annually. They include revenue, net profit, earnings per share, and margin data, which are crucial for assessing the company\'s financial performance and growth prospects.';
        break;
      case 'About Company':
        infoContent =
            'This section provides a brief overview of the company, including its history, core business operations, key products or services, leadership, and market presence. It helps investors understand the company\'s identity, mission, and competitive positioning.';
        break;
      default:
        infoContent = 'Information about $title';
    }

    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 4.w),
        // Info icon that opens modal with section information
        GestureDetector(
          onTap: () => _showInfoDialog(context, title, infoContent),
          child: Icon(
            Icons.info_outline,
            color: isDark ? Colors.white : Colors.grey,
            size: 13.sp,
          ),
        ),
      ],
    );
  }

  /// Market depth table with bid and offer data
  /// @param isDark - Current theme mode
  /// @return Widget - Table with bid/offer data
  Widget _buildMarketDepthTable(bool isDark) {
    return Column(
      children: [
        // Table header and market depth rows
        Stack(
          children: [
            // Content
            Column(
              children: [
                // Table header
                Row(
                  children: [
                    // Bid side
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Bid',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.sp,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Orders',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.sp,
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
                                fontSize: 11.sp,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Space for divider
                    SizedBox(width: 16.w),

                    // Offer side
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Offers',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.sp,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Orders',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.sp,
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
                                fontSize: 11.sp,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                // Market depth rows - standard 5 rows
                _buildDepthRow(isDark, '777.67', '2', '29', false),
                _buildDepthRow(isDark, '223.45', '6', '110', false),
                _buildDepthRow(isDark, '33.57', '8', '126', false),
                _buildDepthRow(isDark, '22.5', '13', '196', false),
                _buildDepthRow(isDark, '346.46', '15', '257', false),
                // Additional 15 rows when expanded view is enabled
                if (show20depth) ...[
                  _buildDepthRow(isDark, '777.67', '2', '29', false),
                  _buildDepthRow(isDark, '223.45', '6', '110', false),
                  _buildDepthRow(isDark, '33.57', '8', '126', false),
                  _buildDepthRow(isDark, '22.5', '13', '196', false),
                  _buildDepthRow(isDark, '346.46', '15', '257', false),
                  _buildDepthRow(isDark, '777.67', '2', '29', false),
                  _buildDepthRow(isDark, '223.45', '6', '110', false),
                  _buildDepthRow(isDark, '33.57', '8', '126', false),
                  _buildDepthRow(isDark, '22.5', '13', '196', false),
                  _buildDepthRow(isDark, '346.46', '15', '257', false),
                  _buildDepthRow(isDark, '777.67', '2', '29', false),
                  _buildDepthRow(isDark, '223.45', '6', '110', false),
                  _buildDepthRow(isDark, '33.57', '8', '126', false),
                  _buildDepthRow(isDark, '22.5', '13', '196', false),
                  _buildDepthRow(isDark, '346.46', '15', '257', false),
                ],
                SizedBox(height: 10.h),
              ],
            ),

            // Vertical divider in the center
            Positioned(
              top: 0,
              bottom: 0,
              // Position the divider in the center
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 0.5,
                  height: show20depth ? 550.h : 200.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    // Add a subtle shadow effect
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 1,
                        offset: Offset(0.5, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),
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
                fontSize: 11.sp,
              ),
            ),
            Text(
              'Total Sell: 8,99,356',
              style: TextStyle(
                color: isDark ? Colors.grey : Colors.black,
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Individual row in the market depth table
  /// @param isDark - Current theme mode
  /// @param price - Price value
  /// @param orders - Number of orders
  /// @param qty - Quantity
  /// @param isHeader - Whether this is a header row
  /// @return Widget - Single market depth row
  Widget _buildDepthRow(
      bool isDark, String price, String orders, String qty, bool isHeader) {
    final TextStyle bidStyle = TextStyle(
      color: Colors.green,
      fontSize: 11.sp,
      fontWeight: isHeader ? FontWeight.normal : FontWeight.w500,
    );

    final TextStyle offerStyle = TextStyle(
      color: Colors.red,
      fontSize: 11.sp,
      fontWeight: isHeader ? FontWeight.normal : FontWeight.w500,
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          // Bid Side (Left columns)
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    price, // Bid price
                    style: bidStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    orders, // Number of bid orders
                    style: bidStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    qty, // Bid quantity
                    style: bidStyle,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),

          // Space for the central divider
          SizedBox(width: 16.w),

          // Offer Side (Right columns)
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    price, // Offer price
                    style: offerStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    orders, // Number of offer orders
                    style: offerStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    qty, // Offer quantity
                    style: offerStyle,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Performance metrics section with sliders
  /// @param isDark - Current theme mode
  /// @return Widget - Section with performance metrics and sliders
  Widget _buildPerformanceSection(bool isDark) {
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
                fontSize: 11.sp,
              ),
            ),
            Text(
              'Today\'s High',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '1,467.00',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '1,467.00',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        // Today's slider indicator
        Container(
          height: 4.h,
          decoration: BoxDecoration(
            color: Color(0xff1DB954),
            borderRadius: BorderRadius.circular(2.r),
          ),
          child: Row(
            children: [
              Container(
                width: 100.w,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Icon(
                      Icons.arrow_drop_up,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),

        // 52 Week range
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '52 Week Low',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 11.sp,
              ),
            ),
            Text(
              '52 Week High',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 11.sp,
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
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              '1,467.00',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        // 52 Week slider indicator
        Container(
          height: 4.h,
          decoration: BoxDecoration(
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
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),

        // Other performance metrics in grid layout
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Open price
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Open',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '1,467.00',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(width: 24.w),
            // High price
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'High',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '1,597.00',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(width: 24.w),
            // Low price
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Low   ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '1,397.00',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(width: 24.w),
            // Previous close price
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Prev. Closed',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '1,467.00',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // Additional metrics row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Volume
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Volume',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '1,467.00',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            // Upper Circuit
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Up. Circuit',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '1,467.00',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            // Lower Circuit
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'L. Circuit',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '1,467.00',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            // Market Cap
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Market Cap',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '17,61,535 Cr',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 12.h,
        )
      ],
    );
  }

  /// Grid of fundamental financial ratios
  /// @param isDark - Current theme mode
  /// @return Widget - Two-column grid of financial ratios
  Widget _buildRatiosGrid(bool isDark) {
    // Data structure for the ratios grid
    final List<List<String>> ratiosData = [
      ['PE Ratio', '7.72', 'Sector P/E', '7.72'],
      ['Return on Equity', '9.06', 'Book Value', '7.72'],
      ['Earning Per Share (EPS)', '7.72', 'Face Value', '7.72'],
      ['Debt to Equity Ratio', '7.72', 'Dividend Yield', '7.72'],
      ['ROCE (Latest)', '7.72', 'ROE (Latest)', '7.72'],
    ];

    // The full height divider approach
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                      padding: EdgeInsets.only(bottom: 12.h, right: 12.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            row[0], // Ratio name
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            row[1], // Ratio value
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black87,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
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
                    26.0, // Approximate height based on rows
                color: isDark ? Color(0xFF2F2F2F) : Color(0xFFECECEC),
              ),

              // Right column
              Expanded(
                child: Column(
                  children: ratiosData.map((row) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h, left: 12.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            row[2], // Ratio name (right column)
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11.sp,
                            ),
                          ),
                          Text(
                            row[3], // Ratio value (right column)
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black87,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
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
    );
  }

  /// Shareholding pattern header with period selector
  /// @param isDark - Current theme mode
  /// @return Widget - Header row with dropdown
  Widget _buildShareholdingHeader(bool isDark) {
    // Debug print to verify dropdown state at render time
    print('DEBUG: Rendering dropdown with value: $shareholdingPeriod');
    print('DEBUG: Available months: $last12Months');

    // Fallback list in case last12Months is empty
    final displayMonths = last12Months.isEmpty
        ? ['Mar 2025', 'Feb 2025', 'Jan 2025']
        : last12Months;

    // ============= COLOR CUSTOMIZATION =============
    // Container colors for the dropdown
    final Color containerBackgroundColor =
        const Color(0xFF1A1A1A); // Darker background
    final Color containerBorderColor = const Color(0xFF333333); // Subtle border

    // Dropdown colors
    final Color dropdownBackgroundColor =
        const Color(0xFF121413); // Dropdown menu background
    final Color textColor = const Color(0xFFFFFFFF); // Text color
    final Color iconColor =
        const Color(0xFF999999); // Icon color (slightly dimmed)
    // =============================================

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Section title
        _buildSectionHeader(isDark, 'Shareholding Pattern'),
        // Period selector dropdown styled to match image
        Center(
          child: Container(
            height: 32.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: containerBackgroundColor, // Custom background color
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                  color: containerBorderColor, width: 1), // Subtle border
            ),
            child: Theme(
              // Apply a theme to try to influence scrollbar color
              data: Theme.of(context).copyWith(
                scrollbarTheme: ScrollbarThemeData(
                  thumbColor: WidgetStateProperty.all(const Color(0xFF2F2F2F)),
                  trackColor: WidgetStateProperty.all(const Color(0xFF2F2F2F)),
                  thickness: WidgetStateProperty.all(4.0),
                  radius: const Radius.circular(10.0),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: shareholdingPeriod,
                  dropdownColor:
                      dropdownBackgroundColor, // Custom dropdown background
                  style: TextStyle(
                    color: textColor, // Custom text color
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: iconColor, // Custom icon color
                    size: 16.sp,
                  ),
                  // Match the compact look in the image
                  isDense: true,
                  // Show more items with a larger height
                  menuMaxHeight: MediaQuery.of(context).size.height *
                      0.5, // 50% of screen height
                  // Use our fallback list
                  items: displayMonths.map((String month) {
                    return DropdownMenuItem<String>(
                      value: month,
                      child: Text(
                        month,
                        style: TextStyle(
                          color: textColor, // Custom text color for items
                          fontSize: 11.sp,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    print('DEBUG: Dropdown changed to: $newValue');
                    setState(() {
                      shareholdingPeriod = newValue!;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Track which section of the pie chart is currently selected
  int selectedPieSection = -1; // -1 means no section is selected

  /// Builds the shareholding pattern pie chart
  /// @param isDark - Current theme mode
  /// @return Widget - Pie chart with labels and interactive highlighting
  Widget buildShareholdingChart(bool isDark) {
    // Define section data for easy reference
    final List<Map<String, dynamic>> sectionData = [
      {
        'title': 'Promoter',
        'value': 25,
        'color': Color(0xffff9e42),
      },
      {
        'title': 'FIIs',
        'value': 25,
        'color': Color(0xff064d51),
      },
      {
        'title': 'Mutual Funds',
        'value': 25,
        'color': Color(0xffff6359),
      },
      {
        'title': 'Insurance Companies',
        'value': 25,
        'color': Color(0xfffbbc05),
      },
      {
        'title': 'Other DIIs',
        'value': 25,
        'color': Color(0xff9747ff),
      },
      {
        'title': 'Non Institution',
        'value': 25,
        'color': Color(0xff0563fb),
      },
    ];

    // Using fl_chart for better pie chart visualization
    return Container(
      height: 240.h,
      child: Stack(
        children: [
          // Row containing the pie chart and labels
          Row(
            children: [
              // Pie Chart Container
              Container(
                width: 180.h,
                height: 180.h,
                child: PieChart(
                  PieChartData(
                    // Center hole radius
                    centerSpaceRadius: 40.r,
                    // Space between sections (0 means no space)
                    sectionsSpace: 0,
                    // Starting angle offset
                    startDegreeOffset: 0,
                    // Enable touch interactions
                    pieTouchData: PieTouchData(
                      // Enable touch interactions and handle section selection
                      enabled: true,
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        // Handle touch events to highlight sections
                        setState(() {
                          if (event is FlTapUpEvent &&
                              pieTouchResponse?.touchedSection != null) {
                            // Get the index of the touched section
                            final touchedIndex = pieTouchResponse!
                                .touchedSection!.touchedSectionIndex;

                            // If already selected, deselect it (reset to normal state)
                            if (selectedPieSection == touchedIndex) {
                              selectedPieSection = -1; // Deselect
                            } else {
                              // Select the new section
                              selectedPieSection = touchedIndex;
                            }
                          } else if (event is FlLongPressEnd) {
                            // Reset selection on long press
                            selectedPieSection = -1;
                          }
                        });
                      },
                    ),
                    // Define the pie chart sections
                    sections: List.generate(sectionData.length, (i) {
                      // Apply fading effect to non-selected sections when a section is selected
                      final bool isSelected = selectedPieSection == i;
                      final bool shouldFade =
                          selectedPieSection != -1 && !isSelected;

                      // Get base color
                      final Color baseColor = sectionData[i]['color'];

                      // Apply fading if needed
                      final Color sectionColor = shouldFade
                          ? baseColor.withOpacity(
                              0.3) // Fade out non-selected sections
                          : baseColor;

                      return PieChartSectionData(
                        value: sectionData[i]['value'].toDouble(),
                        color: sectionColor,
                        radius: isSelected ? 55 : 45, // Expand selected section
                        showTitle: false, // Never show title inside the chart
                        borderSide: BorderSide(width: 0),
                      );
                    }),
                  ),
                ),
              ),
              // Chart labels with color indicators
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(sectionData.length, (i) {
                    final bool isSelected = selectedPieSection == i;
                    final bool shouldFade =
                        selectedPieSection != -1 && !isSelected;

                    // Get base color
                    final Color baseColor = sectionData[i]['color'];

                    // Apply fading if needed
                    final Color labelColor = shouldFade
                        ? baseColor
                            .withOpacity(0.3) // Fade out non-selected labels
                        : baseColor;

                    // Create label text with percentage
                    final String labelText =
                        '${sectionData[i]['title']} - ${sectionData[i]['value']}%';

                    return buildChartLabel(
                      isDark,
                      labelColor,
                      labelText,
                      isHighlighted: isSelected,
                    );
                  }),
                ),
              ),
            ],
          ),
          // Floating text label for selected section (similar to reference image)
          if (selectedPieSection != -1)
            Positioned(
              left: 60.w, // Position it over the pie chart
              top: 70.h,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Color dot matching the pie section
                    Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: sectionData[selectedPieSection]['color'],
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    // Text showing the section name and value
                    Text(
                      '${sectionData[selectedPieSection]['title']}: ${sectionData[selectedPieSection]['value']}%',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Individual chart label with color indicator
  /// @param isDark - Current theme mode
  /// @param color - Color for the indicator dot
  /// @param label - Label text
  /// @param isHighlighted - Whether this label is currently highlighted
  /// @return Widget - Row with color indicator and label
  Widget buildChartLabel(bool isDark, Color color, String label,
      {bool isHighlighted = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          // Color indicator circle
          Container(
            width: 8.0,
            height: 8.0,
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
              fontSize: 11.sp,
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  /// Earnings section header with period selector
  /// @param isDark - Current theme mode
  /// @return Widget - Header row with dropdown
  Widget _buildEarningsHeader(bool isDark) {
    // Define colors to match the image style
    final Color containerBackgroundColor = const Color(0xFF1E1E1E);
    final Color containerBorderColor = const Color(0xFF333333);
    final Color textColor = Colors.white;
    final Color iconColor = Colors.white.withOpacity(0.7);
    final Color dropdownBackgroundColor = const Color(0xFF1E1E1E);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Section title
        _buildSectionHeader(isDark, 'Earnings'),
        // Period selector dropdown styled to match image
        Center(
          child: Container(
            height: 32.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: containerBackgroundColor,
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(color: containerBorderColor, width: 1),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                scrollbarTheme: ScrollbarThemeData(
                  thumbColor: WidgetStateProperty.all(const Color(0xFF2F2F2F)),
                  trackColor: WidgetStateProperty.all(const Color(0xFF2F2F2F)),
                  thickness: WidgetStateProperty.all(4.0),
                  radius: const Radius.circular(10.0),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: earningsPeriod,
                  dropdownColor: dropdownBackgroundColor,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: iconColor,
                    size: 16.sp,
                  ),
                  isDense: true,
                  menuMaxHeight: MediaQuery.of(context).size.height * 0.5,
                  items: <String>['Yearly', 'Quarterly']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 11.sp,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      earningsPeriod = newValue!;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Earnings data type selector tabs
  /// @param isDark - Current theme mode
  /// @return Widget - Row of selectable tabs
  Widget _buildEarningsTabs(bool isDark) {
    return Row(
      children: [
        // Revenue tab
        _buildEarningsTab(isDark, 'Revenue', selectedEarningsTab == 'Revenue'),
        SizedBox(width: 16.w),
        // Profit tab
        _buildEarningsTab(isDark, 'Profit', selectedEarningsTab == 'Profit'),
        SizedBox(width: 16.w),
        // Net Worth tab
        _buildEarningsTab(
            isDark, 'Net Worth', selectedEarningsTab == 'Net Worth'),
      ],
    );
  }

  /// Individual earnings tab
  /// @param isDark - Current theme mode
  /// @param title - Tab title
  /// @param isSelected - Whether this tab is currently selected
  /// @return Widget - Selectable tab
  Widget _buildEarningsTab(bool isDark, String title, bool isSelected) {
    return GestureDetector(
      onTap: () {
        // Update selected tab on tap and reset animation
        setState(() {
          selectedEarningsTab = title;
          // Generate a new key to force widget rebuild and restart animation
          _animationKey = UniqueKey();
          // Reset the visibility state to trigger animation again
          _earningsChartVisible = true;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xff2f2f2f) : Color(0xFFC9CACC))
              : Colors.transparent,
          border: Border.all(
              color: isDark
                  ? isSelected
                      ? const Color(0xffEBEEF5)
                      : const Color(0xffC9CACC)
                  : const Color(0xffC9CACC),
              width: isSelected ? 1 : 0.5),
          borderRadius: BorderRadius.circular(2.r),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 11.sp,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Key for the visibility detector
  final Key _earningsChartKey = Key('earningsChart');

  // Track if the earnings chart has been seen
  bool _earningsChartVisible = false;

  // Animation key to force rebuild and restart animation
  Key _animationKey = UniqueKey();

  /// Earnings bar chart visualization
  /// @param isDark - Current theme mode
  /// @return Widget - Animated bar chart visualization
  Widget _buildEarningsChart(bool isDark) {
    // Bar chart for earnings data
    return VisibilityDetector(
      key: _earningsChartKey,
      onVisibilityChanged: (VisibilityInfo info) {
        // If more than 30% of the widget is visible, consider it "seen"
        if (info.visibleFraction > 0.3 && !_earningsChartVisible) {
          setState(() {
            _earningsChartVisible = true;
          });
        }
      },
      child: Container(
        height: 200.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Year-wise earnings bars
            _buildBarChartColumn(
                isDark, '2020', 3246, 9246, _earningsChartVisible),
            _buildBarChartColumn(
                isDark, '2021', 4246, 9246, _earningsChartVisible),
            _buildBarChartColumn(
                isDark, '2022', 6246, 9246, _earningsChartVisible),
            _buildBarChartColumn(
                isDark, '2023', 8246, 9246, _earningsChartVisible),
            _buildBarChartColumn(
                isDark, '2024', 9246, 9246, _earningsChartVisible),
          ],
        ),
      ),
    );
  }

  /// Individual bar in the earnings chart
  /// @param isDark - Current theme mode
  /// @param year - Year label
  /// @param value - Value for the bar
  /// @param maxValue - Maximum value for scaling
  /// @param isVisible - Whether the chart is visible to trigger animation
  /// @return Widget - Animated bar column with label
  Widget _buildBarChartColumn(
      bool isDark, String year, int value, int maxValue, bool isVisible) {
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
            fontSize: 11.sp,
          ),
        ),
        SizedBox(height: 4.h),
        // Bar visualization with animation - using key to force rebuild
        TweenAnimationBuilder<double>(
          key:
              _animationKey, // Using the key to force rebuild and restart animation
          // Always start from 0 (bottom) and animate to the target percentage if visible
          tween: Tween<double>(begin: 0, end: isVisible ? percentage : 0),
          // Animation duration
          duration: Duration(milliseconds: 1000),
          // Smoother easing curve
          curve: Curves.easeOutQuad,
          builder: (context, animatedPercentage, child) {
            return Container(
              width: 20.w,
              height: 150.h * animatedPercentage,
              decoration: BoxDecoration(
                color: Color(0xff1DB954),
              ),
            );
          },
        ),
        SizedBox(height: 4.h),
        // Year label below bar
        Text(
          year,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  /// Company details in table format
  /// @param isDark - Current theme mode
  /// @return Widget - Column of company information rows
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
          padding: EdgeInsets.symmetric(vertical: 6.h),
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
                flex: 2,
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

  // Track which card is selected in the locate section
  String selectedCard = 'Card 1';

  /// Individual tab option
  /// @param isDark - Current theme mode
  /// @param title - Tab title
  /// @param isSelected - Whether this tab is selected
  /// @return Widget - Tab option widget
  Widget _buildTabOption(bool isDark, String title, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = title;
            // Update tab controller to match selected tab
            int index = customTabOptions.indexOf(title);
            if (index >= 0) {
              _tabController.animateTo(index);
            }
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? const Color(0xff2F2F2F) : Colors.white)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6.r),
            border: isSelected
                ? Border.all(
                    color: isSelected
                        ? const Color(0xff1DB954)
                        : Colors.transparent,
                    width: isSelected ? 1 : 0,
                  )
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected
                  ? (isDark ? const Color(0xff1DB954) : const Color(0xff1DB954))
                  : (isDark
                      ? const Color(0xffC9CACC)
                      : const Color(0xff6B7280)),
              fontSize: 13.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  /// Locate section with card selectors
  /// @param isDark - Current theme mode
  /// @return Widget - Header with card selector buttons
  Widget _buildLocateSection(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Section title
        Text(
          'Locate',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        // Card selector buttons
        Row(
          children: [
            // Card 1 button - using the same style as earnings tabs
            _buildCardTab(isDark, 'Card 1', selectedCard == 'Card 1'),
            SizedBox(width: 16.w),
            // Card 2 button - using the same style as earnings tabs
            _buildCardTab(isDark, 'Card 2', selectedCard == 'Card 2'),
          ],
        ),
      ],
    );
  }

  /// Individual card tab with the same design as earnings tabs
  /// @param isDark - Current theme mode
  /// @param title - Tab title
  /// @param isSelected - Whether this card is selected
  /// @return Widget - Selectable card tab
  Widget _buildCardTab(bool isDark, String title, bool isSelected) {
    return GestureDetector(
      onTap: () {
        // Update selected card on tap
        setState(() {
          selectedCard = title;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xff2f2f2f) : Color(0xFFC9CACC))
              : Colors.transparent,
          border: Border.all(
              color: isDark
                  ? isSelected
                      ? const Color(0xffEBEEF5)
                      : const Color(0xffC9CACC)
                  : const Color(0xffC9CACC),
              width: isSelected ? 1 : 0.5),
          borderRadius: BorderRadius.circular(2.r),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 11.sp,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  /// Helper method to build a metric row
  /// @param isDark - Current theme mode
  /// @param label - Metric label
  /// @param value - Metric value
  /// @param isPositive - Whether value indicates positive change
  /// @param showTrend - Whether to show trend indicator
  /// @return Widget - Row with metric label and value
  Widget _buildMetricRow(bool isDark, String label, String value,
      {bool isPositive = true, bool showTrend = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black87,
              fontSize: 13.sp,
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  color: showTrend
                      ? (isPositive ? Colors.green : Colors.red)
                      : (isDark ? Colors.white : Colors.black),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (showTrend)
                Icon(
                  isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                  color: isPositive ? Colors.green : Colors.red,
                  size: 14.sp,
                ),
            ],
          ),
        ],
      ),
    );
  }

  /// Summary metrics for the Summary tab
  /// @param isDark - Current theme mode
  /// @return Widget - Column of summary metrics
  Widget _buildSummaryMetrics(bool isDark) {
    return Column(
      children: [
        _buildMetricRow(isDark, 'Market Cap', '₹16,75,311 Cr'),
        _buildMetricRow(isDark, '52 Week High', '₹2,930'),
        _buildMetricRow(isDark, '52 Week Low', '₹2,180'),
        _buildMetricRow(isDark, 'P/E Ratio', '28.54'),
        _buildMetricRow(isDark, 'EPS (TTM)', '96.57'),
        _buildMetricRow(isDark, 'Dividend Yield', '0.34%'),
        _buildMetricRow(isDark, 'Book Value', '₹1,148.5'),
        _buildMetricRow(isDark, 'ROE', '8.41%',
            isPositive: true, showTrend: true),
      ],
    );
  }

  /// Financial metrics for the Financials tab
  /// @param isDark - Current theme mode
  /// @return Widget - Column of financial metrics
  Widget _buildFinancialMetrics(bool isDark) {
    return Column(
      children: [
        _buildMetricRow(isDark, 'Revenue (FY23)', '₹8,93,138 Cr',
            isPositive: true, showTrend: true),
        _buildMetricRow(isDark, 'Net Profit (FY23)', '₹73,670 Cr',
            isPositive: true, showTrend: true),
        _buildMetricRow(isDark, 'Revenue Growth (YoY)', '18.8%',
            isPositive: true, showTrend: true),
        _buildMetricRow(isDark, 'Profit Growth (YoY)', '9.2%',
            isPositive: true, showTrend: true),
        _buildMetricRow(isDark, 'EBITDA Margin', '16.4%'),
        _buildMetricRow(isDark, 'Net Profit Margin', '8.2%'),
        _buildMetricRow(isDark, 'Debt to Equity', '0.36'),
        _buildMetricRow(isDark, 'Interest Coverage', '9.8'),
      ],
    );
  }

  /// News items for the News tab
  /// @param isDark - Current theme mode
  /// @return Widget - Column of news items
  Widget _buildNewsItems(bool isDark) {
    // Sample news data
    List<Map<String, String>> newsItems = [
      {
        'title': 'Reliance announces Q4 results, beats market expectations',
        'date': '15 May 2025',
        'source': 'Economic Times'
      },
      {
        'title': 'Reliance Retail acquires majority stake in online pharmacy',
        'date': '12 May 2025',
        'source': 'Business Standard'
      },
      {
        'title':
            'Jio Platforms partners with global tech giant for cloud services',
        'date': '08 May 2025',
        'source': 'Mint'
      },
      {
        'title': 'Reliance sets 2035 target for net carbon zero operations',
        'date': '03 May 2025',
        'source': 'Financial Express'
      },
    ];

    return Column(
      children: newsItems.map((news) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xff242424) : const Color(0xffF9FAFB),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                news['title']!,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    news['date']!,
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black54,
                      fontSize: 11.sp,
                    ),
                  ),
                  Text(
                    news['source']!,
                    style: TextStyle(
                      color: const Color(0xff1DB954),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// Overview tab content
  /// @param isDark - Current theme mode
  /// @return Widget - Complete overview tab content
  Widget _buildOverviewTab(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Performance section
        _buildSectionHeader(isDark, 'Performance'),
        SizedBox(height: 12.h),
        _buildPerformanceSection(isDark),
        Divider(
            color: isDark ? const Color(0xFF2F2F2F) : const Color(0xFFD1D5DB)),
        SizedBox(height: 12.h),
        // Fundamental Ratios grid display
        _buildSectionHeader(isDark, 'Fundamental Ratios'),
        SizedBox(height: 16.h),
        _buildRatiosGrid(isDark),
        Divider(
            color: isDark ? const Color(0xFF2F2F2F) : const Color(0xFFD1D5DB)),

        // Shareholding Pattern with pie chart
        SizedBox(
          height: 12.h,
        ),
        _buildShareholdingHeader(isDark),
        // SizedBox(height: 16.h),
        buildShareholdingChart(isDark),
        Divider(
            color: isDark ? const Color(0xFF2F2F2F) : const Color(0xFFD1D5DB)),
        SizedBox(
          height: 12.h,
        ),
        // Earnings section with chart
        _buildEarningsHeader(isDark),
        SizedBox(height: 16.h),
        _buildEarningsTabs(isDark),
        SizedBox(height: 16.h),
        _buildEarningsChart(isDark),
        SizedBox(height: 10.h),
        Center(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              '*All values are in crore',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Divider(
            color: isDark ? const Color(0xFF2F2F2F) : const Color(0xFFD1D5DB)),

        // About Company section
        SizedBox(height: 12.h),
        _buildSectionHeader(isDark, 'About Company'),
        SizedBox(height: 16.h),
        Text(
          'Reliance Industries Limited (RIL) is India\'s largest private sector company. The company\'s activities span hydrocarbon exploration and production, petroleum refining and marketing, petrochemicals, advanced materials and composites, renewables (solar and hydrogen), retail and digital services. The company\'s products range is from the exploration and production of oil and gas to the manufacture of petroleum products, polyester products, polyester intermediates, plastics, polymer intermediates, chemicals, synthetic textiles and fabrics.',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 13.sp,
            height: 1.5,
          ),
        ),
        SizedBox(height: 16.h),
        _buildCompanyDetailsTable(isDark),
        SizedBox(height: 24.h),
        Divider(
            color: isDark ? const Color(0xFF2F2F2F) : const Color(0xFFD1D5DB)),
        // Locate Section
        SizedBox(height: 16.h),
        // _buildCustomTabBar(isDark),
        // SizedBox(height: 16.h),
        // _buildTabContent(isDark),
        // SizedBox(height: 16.h),
        _buildLocateSection(isDark),
        SizedBox(height: 24.h),
      ],
    );
  }
}
