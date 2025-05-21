import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/optionChain/optionChain.dart';
import 'package:sapphire/utils/constWidgets.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'news.dart';
import 'events.dart';

class watchlistSDW extends StatefulWidget {
  final String stockName, stockCode, price, change;
  final VoidCallback onBuy, onSell;
  const watchlistSDW(
      {super.key,
      required this.stockName,
      required this.stockCode,
      required this.price,
      required this.change,
      required this.onBuy,
      required this.onSell});

  @override
  State<watchlistSDW> createState() => _watchlistSDWState();
}

class _watchlistSDWState extends State<watchlistSDW>
    with TickerProviderStateMixin {
  String selectedEarningsTab = 'Revenue',
      earningsPeriod = 'Yearly',
      shareholdingPeriod = 'Mar 2025',
      selectedTab = 'Overview',
      selectedRange = '1D';
  bool isNSE = true,
      show20depth = false,
      scroll = false,
      isDividerVisible = true,
      _showAppBarTitle = false,
      _earningsChartVisible = false;
  final GlobalKey _scrollKey = GlobalKey();
  final ScrollController scrollController = ScrollController(),
      _scrollController = ScrollController();
  late TabController _tabController;
  late PageController _pageController;
  List<String> last12Months = [];
  List<String> customTabOptions = ["Overview", "News", "Events"];
  Key _animationKey = UniqueKey(), _earningsChartKey = Key('earningsChart');
  int selectedPieSection = -1;
  String selectedCard = 'Card 1';

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: customTabOptions.length, vsync: this);
    _pageController = PageController(
        initialPage: customTabOptions
            .indexOf(selectedTab)
            .clamp(0, customTabOptions.length - 1));
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) return;
      setState(() {
        selectedTab = customTabOptions[_tabController.index];
        _pageController.animateToPage(_tabController.index,
            duration: Duration(milliseconds: 150), curve: Curves.easeInOut);
      });
    });
    scrollController.addListener(_checkDividerVisibility);
    _scrollController.addListener(_scrollListener);
    DateTime now = DateTime(2025, 3, 1);
    last12Months = List.generate(
        12,
        (index) =>
            '${_monthName(DateTime(now.year, now.month - index, 1).month)} ${DateTime(now.year, now.month - index, 1).year}');
  }

  String _monthName(int month) => [
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
      ][month - 1];

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
    scrollController.removeListener(_checkDividerVisibility);
    scrollController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _checkDividerVisibility() {
    if (_scrollKey.currentContext == null) return;
    final RenderBox box =
        _scrollKey.currentContext!.findRenderObject() as RenderBox;
    final position = box.localToGlobal(Offset.zero);
    bool currentlyVisible = position.dy >= kToolbarHeight &&
        position.dy <= MediaQuery.of(context).size.height;
    if (isDividerVisible != currentlyVisible)
      setState(() => isDividerVisible = currentlyVisible);
  }

  void _scrollListener() {
    setState(() => _showAppBarTitle = _scrollController.offset > 100);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        scrolledUnderElevation: 0,
        leadingWidth: 24.w,
        elevation: 0,
        title: _showAppBarTitle
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.stockName,
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black)),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(widget.price,
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.white : Colors.black)),
                      SizedBox(width: 4.h),
                      Text(widget.change,
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: widget.change.contains('+')
                                  ? Colors.green
                                  : Colors.red)),
                    ],
                  ),
                ],
              )
            : null,
        centerTitle: false,
        bottom: _showAppBarTitle
            ? PreferredSize(
                preferredSize: Size.fromHeight(1.0),
                child: Divider(
                    height: 1.0,
                    thickness: 1.0,
                    color: isDark ? Color(0xFF2F2F2F) : Color(0xFFD1D5DB)),
              )
            : null,
        actions: [
          SizedBox(width: 16.w),
          SvgPicture.asset("assets/svgs/save.svg",
              width: 22.w,
              height: 22.h,
              color: isDark ? Colors.white : Colors.black),
          SizedBox(width: 16.w),
          GestureDetector(
            onTap: () => navi(
                OptionChainWrapper(
                    symbol: widget.stockName,
                    stockName: widget.stockName,
                    price: widget.price,
                    change: widget.change,
                    exchange: isNSE ? "NSE" : "BSE"),
                context),
            child: SvgPicture.asset("assets/svgs/chain.svg",
                width: 22.w,
                height: 22.h,
                color: isDark ? Colors.white : Colors.black),
          ),
          SizedBox(width: 16.w),
          SvgPicture.asset("assets/svgs/notification.svg",
              width: 22.w,
              height: 22.h,
              color: isDark ? Colors.white : Colors.black),
          SizedBox(width: 16.w),
          SvgPicture.asset("assets/svgs/search-svgrepo-com (1).svg",
              color: isDark ? Colors.white : Colors.black),
          SizedBox(width: 16.w),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.black : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 1)
          ],
        ),
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
                child: _buildHeader(isDark),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 3.h)),
            SliverToBoxAdapter(
                child: Divider(
                    color: isDark ? Color(0xFF2F2F2F) : Color(0xFFD1D5DB))),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),
                    stockChartWidget(
                      dataPoints: getChartData(selectedRange),
                      selectedRange: selectedRange,
                      onRangeSelected: (range) =>
                          setState(() => selectedRange = range),
                    ),
                    SizedBox(height: 18.h),
                    Divider(
                        color: isDark ? Color(0xFF2F2F2F) : Color(0xFFD1D5DB)),
                    _buildSectionHeader(isDark, 'Market Depth'),
                    SizedBox(height: 16.h),
                    _buildMarketDepthTable(isDark),
                    Center(
                      child: TextButton(
                        onPressed: () =>
                            setState(() => show20depth = !show20depth),
                        child: Text(
                            show20depth ? 'Show 5 depth' : 'Show 20 depth',
                            style: TextStyle(
                                color: Color(0xff1DB954), fontSize: 14.sp)),
                      ),
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                minHeight: 45.h,
                maxHeight: 50.h,
                child: Container(
                  color: isDark ? Colors.black : Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: CustomTabBar(
                        tabController: _tabController,
                        options: customTabOptions),
                  ),
                ),
              ),
            ),
          ],
          body: RefreshIndicator(
            color: Color(0xff1db954),
            backgroundColor: isDark ? Colors.black : Colors.white,
            onRefresh: () async => await Future.delayed(Duration(seconds: 1)),
            child: TabBarView(
              controller: _tabController,
              children: [
                CustomScrollView(
                  physics: scroll
                      ? NeverScrollableScrollPhysics()
                      : AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(child: _buildOverviewTab(isDark)),
                  ],
                ),
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: newsTab(isDark: isDark)),
                  ],
                ),
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: EventsTab(isDark: isDark)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [_buildBuySellButtons()],
    );
  }

  Widget _buildHeader(bool isDark) {
    return Row(
      children: [
        CircleAvatar(
            radius: 18.r,
            backgroundImage: AssetImage("assets/images/reliance logo.png")),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(widget.stockName,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                          color: isDark ? Colors.white : Colors.black)),
                  SizedBox(width: 6.w),
                  isNSE ? _infoChip("NSE") : _infoChip("BSE"),
                ],
              ),
              SizedBox(height: 2.h),
              Text(widget.stockCode,
                  style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 15.sp)),
              SizedBox(height: 6.h),
              Row(
                children: [
                  Text(widget.price,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                          color: isDark ? Colors.white : Colors.black)),
                  SizedBox(width: 4.w),
                  Text(widget.change,
                      style: TextStyle(
                          color: widget.change.contains('+')
                              ? Colors.green
                              : Colors.red,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(right: 8.w),
              decoration: BoxDecoration(
                  color: isDark ? Color(0xff2F2F2F) : Color(0xfff4f4f9),
                  borderRadius: BorderRadius.circular(2.r)),
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                          child: Text('NSE',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: isNSE
                                      ? Colors.white
                                      : isDark
                                          ? Colors.white
                                          : Colors.black))),
                    ),
                  ),
                  SizedBox(height: 2.h),
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
                          child: Text('BSE',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: !isNSE
                                      ? Colors.white
                                      : isDark
                                          ? Colors.white
                                          : Colors.black))),
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

  Widget _infoChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
          color: Color(0xff303030), borderRadius: BorderRadius.circular(4.r)),
      child: Text(text,
          style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white)),
    );
  }

  Widget _buildBuySellButtons() {
    return Column(
      children: [
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: ElevatedButton(
                  onPressed: widget.onBuy,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF22A06B),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r))),
                  child: Text('Buy',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: ElevatedButton(
                  onPressed: widget.onSell,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE53935),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r))),
                  child: Text('Sell',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget stockChartWidget(
      {required List<FlSpot> dataPoints,
      required String selectedRange,
      required void Function(String) onRangeSelected}) {
    return Column(
      children: [
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
                      reservedSize: 30.h,
                      interval: 1,
                      getTitlesWidget: (value, meta) => Padding(
                        padding: EdgeInsets.only(top: 16.h),
                        child: Text(
                            [
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
                            ][value.toInt() % 12],
                            style:
                                TextStyle(color: Colors.grey, fontSize: 11.sp)),
                      ),
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                      spots: dataPoints,
                      isCurved: true,
                      color: Color(0xff1DB954),
                      barWidth: 2,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false))
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
        Container(
          width: double.infinity,
          height: 40.h,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var range in [
                  '1D',
                  '1W',
                  '1M',
                  '3M',
                  '6M',
                  '1Y',
                  '5Y',
                  'All'
                ])
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: ChoiceChip(
                      label: Text(range,
                          style:
                              TextStyle(color: Colors.white, fontSize: 13.sp)),
                      selected: selectedRange == range,
                      onSelected: (_) => onRangeSelected(range),
                      selectedColor: Color(0xFF2F2F2F),
                      backgroundColor: Colors.black54,
                      showCheckmark: false,
                      side: BorderSide.none,
                      elevation: 0,
                      pressElevation: 0,
                      shadowColor: Colors.transparent,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.r)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                      labelPadding: EdgeInsets.symmetric(horizontal: 2),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: ChoiceChip(
                    label: SvgPicture.asset('assets/svgs/expand.svg',
                        height: 18.h,
                        width: 18.w,
                        colorFilter:
                            ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                    selected: selectedRange == 'Expand',
                    onSelected: (_) => onRangeSelected('Expand'),
                    selectedColor: Color(0xFF2F2F2F),
                    backgroundColor: Colors.black54,
                    showCheckmark: false,
                    side: BorderSide.none,
                    elevation: 0,
                    pressElevation: 0,
                    shadowColor: Colors.transparent,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.r)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                    labelPadding: EdgeInsets.symmetric(horizontal: 2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showInfoDialog(BuildContext context, String title, String content) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isFundamentalRatios = title == 'Fundamental Ratios';
    final double contentHeight = isFundamentalRatios ? 500.h : 300.h;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => Container(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isDark ? Color(0xff121413) : Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 1)
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp)),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                      padding: EdgeInsets.all(4.w),
                      child: Icon(Icons.close,
                          color: isDark ? Colors.white : Colors.black54,
                          size: 20.sp)),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Divider(color: isDark ? Color(0xFF2F2F2F) : Color(0xFFD1D5DB)),
            SizedBox(height: 6.h),
            isFundamentalRatios
                ? Container(
                    height: contentHeight,
                    child: SingleChildScrollView(
                        child: _buildRichRatioContent(isDark, content)))
                : Flexible(
                    child: SingleChildScrollView(
                        child: Text(content,
                            style: TextStyle(
                                color: isDark
                                    ? Colors.white.withOpacity(0.9)
                                    : Colors.black87,
                                fontSize: 14.sp,
                                height: 1.5)))),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildRichRatioContent(bool isDark, String content) {
    final List<String> sections = content.split('\n\n');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sections.map((section) {
        final parts = section.split('\n');
        if (parts.length >= 2) {
          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(parts[0],
                    style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp)),
                SizedBox(height: 4.h),
                Text(parts[1],
                    style: TextStyle(
                        color: isDark
                            ? Colors.white.withOpacity(0.8)
                            : Colors.black87,
                        fontSize: 14.sp,
                        height: 1.4)),
              ],
            ),
          );
        }
        return SizedBox.shrink();
      }).toList(),
    );
  }

  Widget _buildSectionHeader(bool isDark, String title) {
    String infoContent = {
          'Market Depth':
              'Market Depth shows the real-time demand and supply for a stock at different price levels...',
          'Performance':
              'Performance reflects how a stock has behaved over various timeframes...',
          'Fundamental Ratios':
              'P/E Ratio\nMeasures a company\'s current share price relative to its per-share earnings...\n\nReturn on Equity (ROE)\nIndicates how efficiently a company uses shareholders\' equity...',
          'Shareholding Pattern':
              'The Shareholding Pattern reveals the ownership distribution of a company...',
          'Earnings':
              'Earnings indicate a company\'s profitability over a specific period...',
          'About Company':
              'This section provides a brief overview of the company...',
        }[title] ??
        'Information about $title';
    return Row(
      children: [
        Text(title,
            style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500)),
        SizedBox(width: 4.w),
        GestureDetector(
            onTap: () => _showInfoDialog(context, title, infoContent),
            child: Icon(Icons.info_outline,
                color: isDark ? Colors.white : Colors.grey, size: 13.sp)),
      ],
    );
  }

  Widget _buildMarketDepthTable(bool isDark) {
    return Column(
      children: [
        Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text('Bid',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 11.sp),
                                  textAlign: TextAlign.left)),
                          Expanded(
                              flex: 2,
                              child: Text('Orders',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 11.sp),
                                  textAlign: TextAlign.center)),
                          Expanded(
                              flex: 1,
                              child: Text('Qty.',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 11.sp),
                                  textAlign: TextAlign.right)),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text('Offers',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 11.sp),
                                  textAlign: TextAlign.left)),
                          Expanded(
                              flex: 2,
                              child: Text('Orders',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 11.sp),
                                  textAlign: TextAlign.center)),
                          Expanded(
                              flex: 1,
                              child: Text('Qty.',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 11.sp),
                                  textAlign: TextAlign.right)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                _buildDepthRow(isDark, '777.67', '2', '29', false),
                _buildDepthRow(isDark, '223.45', '6', '110', false),
                _buildDepthRow(isDark, '33.57', '8', '126', false),
                _buildDepthRow(isDark, '22.5', '13', '196', false),
                _buildDepthRow(isDark, '346.46', '15', '257', false),
                if (show20depth) ...[
                  for (var _ in List.generate(15, (_) => 0)) ...[
                    _buildDepthRow(isDark, '777.67', '2', '29', false),
                    _buildDepthRow(isDark, '223.45', '6', '110', false),
                    _buildDepthRow(isDark, '33.57', '8', '126', false),
                    _buildDepthRow(isDark, '22.5', '13', '196', false),
                    _buildDepthRow(isDark, '346.46', '15', '257', false),
                  ]
                ],
                SizedBox(height: 10.h),
              ],
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                    width: 0.5,
                    height: show20depth ? 550.h : 200.h,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 1,
                              offset: Offset(0.5, 0))
                        ])),
              ),
            )
          ],
        ),
        SizedBox(height: 12.h),
        Divider(color: isDark ? Color(0xFF2F2F2F) : Color(0xFFD1D5DB)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total buy: 8,99,356',
                style: TextStyle(
                    color: isDark ? Colors.grey : Colors.black,
                    fontSize: 11.sp)),
            Text('Total Sell: 8,99,356',
                style: TextStyle(
                    color: isDark ? Colors.grey : Colors.black,
                    fontSize: 11.sp)),
          ],
        ),
      ],
    );
  }

  Widget _buildDepthRow(
      bool isDark, String price, String orders, String qty, bool isHeader) {
    final TextStyle style = TextStyle(
        color: isHeader
            ? Colors.grey
            : (price == 'Bid' ? Colors.green : Colors.red),
        fontSize: 11.sp,
        fontWeight: isHeader ? FontWeight.normal : FontWeight.w500);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child:
                        Text(price, style: style, textAlign: TextAlign.left)),
                Expanded(
                    flex: 2,
                    child: Text(orders,
                        style: style, textAlign: TextAlign.center)),
                Expanded(
                    flex: 1,
                    child: Text(qty, style: style, textAlign: TextAlign.right)),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child:
                        Text(price, style: style, textAlign: TextAlign.left)),
                Expanded(
                    flex: 2,
                    child: Text(orders,
                        style: style, textAlign: TextAlign.center)),
                Expanded(
                    flex: 1,
                    child: Text(qty, style: style, textAlign: TextAlign.right)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceSection(bool isDark) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Today\'s Low',
              style: TextStyle(color: Colors.grey, fontSize: 11.sp)),
          Text('Today\'s High',
              style: TextStyle(color: Colors.grey, fontSize: 11.sp))
        ]),
        SizedBox(height: 6.h),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('1,467.00',
              style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500)),
          Text('1,467.00',
              style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500))
        ]),
        SizedBox(height: 12.h),
        Container(
          height: 4.h,
          decoration: BoxDecoration(
              color: Color(0xff1DB954),
              borderRadius: BorderRadius.circular(2.r)),
          child: Row(children: [
            Container(
                width: 100.w,
                child: Stack(alignment: Alignment.centerLeft, children: [
                  Icon(Icons.arrow_drop_up, color: Colors.white, size: 24.sp)
                ]))
          ]),
        ),
        SizedBox(height: 24.h),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('52 Week Low',
              style: TextStyle(color: Colors.grey, fontSize: 11.sp)),
          Text('52 Week High',
              style: TextStyle(color: Colors.grey, fontSize: 11.sp))
        ]),
        SizedBox(height: 8.h),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('1,467.00',
              style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400)),
          Text('1,467.00',
              style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400))
        ]),
        SizedBox(height: 8.h),
        Container(
          height: 4.h,
          decoration: BoxDecoration(
              color: Color(0xff1DB954),
              borderRadius: BorderRadius.circular(2.r)),
          child: Row(children: [
            Container(
                width: 150.w,
                height: 4.h,
                child: Stack(alignment: Alignment.centerLeft, children: [
                  Icon(Icons.arrow_drop_up, color: Colors.white, size: 24.sp)
                ]))
          ]),
        ),
        SizedBox(height: 24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Open',
                  style: TextStyle(color: Colors.grey, fontSize: 11.sp)),
              SizedBox(height: 4.h),
              Text('1,467.00',
                  style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400))
            ]),
            SizedBox(width: 24.w),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('High',
                  style: TextStyle(color: Colors.grey, fontSize: 11.sp)),
              SizedBox(height: 4.h),
              Text('1,597.00',
                  style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400))
            ]),
            SizedBox(width: 24.w),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Low   ',
                  style: TextStyle(color: Colors.grey, fontSize: 11.sp)),
              SizedBox(height: 4.h),
              Text('1,397.00',
                  style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400))
            ]),
            SizedBox(width: 24.w),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Prev. Closed',
                  style: TextStyle(color: Colors.grey, fontSize: 11.sp)),
              SizedBox(height: 4.h),
              Text('1,467.00',
                  style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400))
            ]),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Volume',
                  style: TextStyle(color: Colors.grey, fontSize: 11.sp)),
              SizedBox(height: 4.h),
              Text('1,467.00',
                  style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400))
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Up. Circuit',
                  style: TextStyle(color: Colors.grey, fontSize: 11.sp)),
              SizedBox(height: 4.h),
              Text('1,467.00',
                  style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400))
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('L. Circuit',
                  style: TextStyle(color: Colors.grey, fontSize: 11.sp)),
              SizedBox(height: 4.h),
              Text('1,467.00',
                  style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400))
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Market Cap',
                  style: TextStyle(color: Colors.grey, fontSize: 11.sp)),
              SizedBox(height: 4.h),
              Text('17,61,535 Cr',
                  style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400))
            ]),
          ],
        ),
        SizedBox(height: 12.h),
      ],
    );
  }

  Widget _buildRatiosGrid(bool isDark) {
    final List<List<String>> ratiosData = [
      ['PE Ratio', '7.72', 'Sector P/E', '7.72'],
      ['Return on Equity', '9.06', 'Book Value', '7.72'],
      ['Earning Per Share (EPS)', '7.72', 'Face Value', '7.72'],
      ['Debt to Equity Ratio', '7.72', 'Dividend Yield', '7.72'],
      ['ROCE (Latest)', '7.72', 'ROE (Latest)', '7.72'],
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: ratiosData
                      .map((row) => Padding(
                            padding: EdgeInsets.only(bottom: 12.h, right: 12.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(row[0],
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w400)),
                                Text(row[1],
                                    style: TextStyle(
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black87,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
              Container(
                  width: 1,
                  height: ratiosData.length * 26.0,
                  color: isDark ? Color(0xFF2F2F2F) : Color(0xFFECECEC)),
              Expanded(
                child: Column(
                  children: ratiosData
                      .map((row) => Padding(
                            padding: EdgeInsets.only(bottom: 12.h, left: 12.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(row[2],
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 11.sp)),
                                Text(row[3],
                                    style: TextStyle(
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black87,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildShareholdingHeader(bool isDark) {
    final Color containerBackgroundColor = Color(0xFF1A1A1A),
        containerBorderColor = Color(0xFF333333),
        dropdownBackgroundColor = Color(0xFF121413),
        textColor = Color(0xFFFFFFFF),
        iconColor = Color(0xFF999999);
    final displayMonths = last12Months.isEmpty
        ? ['Mar 2025', 'Feb 2025', 'Jan 2025']
        : last12Months;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSectionHeader(isDark, 'Shareholding Pattern'),
        Center(
          child: Container(
            height: 32.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
                color: containerBackgroundColor,
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(color: containerBorderColor, width: 1)),
            child: Theme(
              data: Theme.of(context).copyWith(
                  scrollbarTheme: ScrollbarThemeData(
                      thumbColor: WidgetStateProperty.all(Color(0xFF2F2F2F)),
                      trackColor: WidgetStateProperty.all(Color(0xFF2F2F2F)),
                      thickness: WidgetStateProperty.all(4.0),
                      radius: Radius.circular(10.0))),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: shareholdingPeriod,
                  dropdownColor: dropdownBackgroundColor,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400),
                  icon: Icon(Icons.keyboard_arrow_down,
                      color: iconColor, size: 16.sp),
                  isDense: true,
                  menuMaxHeight: MediaQuery.of(context).size.height * 0.5,
                  items: displayMonths
                      .map((month) => DropdownMenuItem<String>(
                          value: month,
                          child: Text(month,
                              style: TextStyle(
                                  color: textColor, fontSize: 11.sp))))
                      .toList(),
                  onChanged: (newValue) =>
                      setState(() => shareholdingPeriod = newValue!),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildShareholdingChart(bool isDark) {
    final List<Map<String, dynamic>> sectionData = [
      {'title': 'Promoter', 'value': 25, 'color': Color(0xffff9e42)},
      {'title': 'FIIs', 'value': 25, 'color': Color(0xff064d51)},
      {'title': 'Mutual Funds', 'value': 25, 'color': Color(0xffff6359)},
      {'title': 'Insurance Companies', 'value': 25, 'color': Color(0xfffbbc05)},
      {'title': 'Other DIIs', 'value': 25, 'color': Color(0xff9747ff)},
      {'title': 'Non Institution', 'value': 25, 'color': Color(0xff0563fb)},
    ];
    return Container(
      height: 240.h,
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: 180.h,
                height: 180.h,
                child: PieChart(
                  PieChartData(
                    centerSpaceRadius: 40.r,
                    sectionsSpace: 0,
                    startDegreeOffset: 0,
                    pieTouchData: PieTouchData(
                      enabled: true,
                      touchCallback: (event, response) {
                        setState(() {
                          if (event is FlTapUpEvent &&
                              response?.touchedSection != null) {
                            final touchedIndex =
                                response!.touchedSection!.touchedSectionIndex;
                            selectedPieSection =
                                selectedPieSection == touchedIndex
                                    ? -1
                                    : touchedIndex;
                          } else if (event is FlLongPressEnd) {
                            selectedPieSection = -1;
                          }
                        });
                      },
                    ),
                    sections: List.generate(sectionData.length, (i) {
                      final bool isSelected = selectedPieSection == i,
                          shouldFade = selectedPieSection != -1 && !isSelected;
                      final Color sectionColor = shouldFade
                          ? sectionData[i]['color'].withOpacity(0.3)
                          : sectionData[i]['color'];
                      return PieChartSectionData(
                          value: sectionData[i]['value'].toDouble(),
                          color: sectionColor,
                          radius: isSelected ? 55 : 45,
                          showTitle: false,
                          borderSide: BorderSide(width: 0));
                    }),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(sectionData.length, (i) {
                    final bool isSelected = selectedPieSection == i,
                        shouldFade = selectedPieSection != -1 && !isSelected;
                    final Color labelColor = shouldFade
                        ? sectionData[i]['color'].withOpacity(0.3)
                        : sectionData[i]['color'];
                    return buildChartLabel(isDark, labelColor,
                        '${sectionData[i]['title']} - ${sectionData[i]['value']}%',
                        isHighlighted: isSelected);
                  }),
                ),
              ),
            ],
          ),
          if (selectedPieSection != -1)
            Positioned(
              left: 60.w,
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
                          spreadRadius: 1)
                    ]),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                            color: sectionData[selectedPieSection]['color'],
                            shape: BoxShape.circle)),
                    SizedBox(width: 6.w),
                    Text(
                        '${sectionData[selectedPieSection]['title']}: ${sectionData[selectedPieSection]['value']}%',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildChartLabel(bool isDark, Color color, String label,
      {bool isHighlighted = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          SizedBox(width: 8.0),
          Text(label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontSize: 11.sp,
                  fontWeight:
                      isHighlighted ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildEarningsHeader(bool isDark) {
    final Color containerBackgroundColor = Color(0xFF1E1E1E),
        containerBorderColor = Color(0xFF333333),
        textColor = Colors.white,
        iconColor = Colors.white.withOpacity(0.7),
        dropdownBackgroundColor = Color(0xFF1E1E1E);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSectionHeader(isDark, 'Earnings'),
        Center(
          child: Container(
            height: 32.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
                color: containerBackgroundColor,
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(color: containerBorderColor, width: 1)),
            child: Theme(
              data: Theme.of(context).copyWith(
                  scrollbarTheme: ScrollbarThemeData(
                      thumbColor: WidgetStateProperty.all(Color(0xFF2F2F2F)),
                      trackColor: WidgetStateProperty.all(Color(0xFF2F2F2F)),
                      thickness: WidgetStateProperty.all(4.0),
                      radius: Radius.circular(10.0))),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: earningsPeriod,
                  dropdownColor: dropdownBackgroundColor,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400),
                  icon: Icon(Icons.keyboard_arrow_down,
                      color: iconColor, size: 16.sp),
                  isDense: true,
                  menuMaxHeight: MediaQuery.of(context).size.height * 0.5,
                  items: <String>['Yearly', 'Quarterly']
                      .map((value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: TextStyle(
                                  color: textColor, fontSize: 11.sp))))
                      .toList(),
                  onChanged: (newValue) =>
                      setState(() => earningsPeriod = newValue!),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEarningsTabs(bool isDark) {
    return Row(
      children: [
        _buildEarningsTab(isDark, 'Revenue', selectedEarningsTab == 'Revenue'),
        SizedBox(width: 16.w),
        _buildEarningsTab(isDark, 'Profit', selectedEarningsTab == 'Profit'),
        SizedBox(width: 16.w),
        _buildEarningsTab(
            isDark, 'Net Worth', selectedEarningsTab == 'Net Worth'),
      ],
    );
  }

  Widget _buildEarningsTab(bool isDark, String title, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() {
        selectedEarningsTab = title;
        _animationKey = UniqueKey();
        _earningsChartVisible = true;
      }),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? Color(0xff2f2f2f) : Color(0xFFC9CACC))
              : Colors.transparent,
          border: Border.all(
              color: isDark
                  ? (isSelected ? Color(0xffEBEEF5) : Color(0xffC9CACC))
                  : Color(0xffC9CACC),
              width: isSelected ? 1 : 0.5),
          borderRadius: BorderRadius.circular(2.r),
        ),
        child: Text(title,
            style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 11.sp,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal)),
      ),
    );
  }

  Widget _buildEarningsChart(bool isDark) {
    return VisibilityDetector(
      key: _earningsChartKey,
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_earningsChartVisible)
          setState(() => _earningsChartVisible = true);
      },
      child: Container(
        height: 200.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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

  Widget _buildBarChartColumn(
      bool isDark, String year, int value, int maxValue, bool isVisible) {
    final double percentage = value / maxValue;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(value.toString(),
            style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 11.sp)),
        SizedBox(height: 4.h),
        TweenAnimationBuilder<double>(
          key: _animationKey,
          tween: Tween<double>(begin: 0, end: isVisible ? percentage : 0),
          duration: Duration(milliseconds: 1000),
          curve: Curves.easeOutQuad,
          builder: (context, animatedPercentage, child) => Container(
              width: 20.w,
              height: 150.h * animatedPercentage,
              decoration: BoxDecoration(color: Color(0xff1DB954))),
        ),
        SizedBox(height: 4.h),
        Text(year, style: TextStyle(color: Colors.grey, fontSize: 11.sp)),
      ],
    );
  }

  Widget _buildCompanyDetailsTable(bool isDark) {
    final Map<String, String> details = {
      'Company name': 'Reliance Industries Ltd.',
      'Founded': '1958',
      'Managing Director': 'Mr. Mukesh Ambani',
      'Industry': 'Refineries',
      'Market Cap Category': 'Large Cap',
    };
    return Column(
      children: details.entries
          .map((entry) => Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(entry.key,
                            style: TextStyle(
                                color: Colors.grey, fontSize: 14.sp))),
                    Expanded(
                        flex: 2,
                        child: Text(entry.value,
                            style: TextStyle(
                                color: isDark ? Colors.white : Colors.black87,
                                fontSize: 14.sp))),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildLocateSection(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Locate',
            style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500)),
        Row(
          children: [
            _buildCardTab(isDark, 'Card 1', selectedCard == 'Card 1'),
            SizedBox(width: 16.w),
            _buildCardTab(isDark, 'Card 2', selectedCard == 'Card 2'),
          ],
        ),
      ],
    );
  }

  Widget _buildCardTab(bool isDark, String title, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => selectedCard = title),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? Color(0xff2f2f2f) : Color(0xFFC9CACC))
              : Colors.transparent,
          border: Border.all(
              color: isDark
                  ? (isSelected ? Color(0xffEBEEF5) : Color(0xffC9CACC))
                  : Color(0xffC9CACC),
              width: isSelected ? 1 : 0.5),
          borderRadius: BorderRadius.circular(2.r),
        ),
        child: Text(title,
            style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 11.sp,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal)),
      ),
    );
  }

  Widget _buildMetricRow(bool isDark, String label, String value,
      {bool isPositive = true, bool showTrend = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black87,
                  fontSize: 13.sp)),
          Row(
            children: [
              Text(value,
                  style: TextStyle(
                      color: showTrend
                          ? (isPositive ? Colors.green : Colors.red)
                          : (isDark ? Colors.white : Colors.black),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500)),
              if (showTrend)
                Icon(isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                    color: isPositive ? Colors.green : Colors.red, size: 14.sp),
            ],
          ),
        ],
      ),
    );
  }

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

  Widget _buildNewsItems(bool isDark) {
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
      children: newsItems
          .map((news) => Container(
                margin: EdgeInsets.only(bottom: 12.h),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                    color: isDark ? Color(0xff242424) : Color(0xffF9FAFB),
                    borderRadius: BorderRadius.circular(6.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(news['title']!,
                        style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(news['date']!,
                            style: TextStyle(
                                color: isDark ? Colors.white70 : Colors.black54,
                                fontSize: 11.sp)),
                        Text(news['source']!,
                            style: TextStyle(
                                color: Color(0xff1DB954),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildOverviewTab(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        _buildSectionHeader(isDark, 'Performance'),
        SizedBox(height: 12.h),
        _buildPerformanceSection(isDark),
        Divider(color: isDark ? Color(0xFF2F2F2F) : Color(0xFFD1D5DB)),
        SizedBox(height: 12.h),
        _buildSectionHeader(isDark, 'Fundamental Ratios'),
        SizedBox(height: 16.h),
        _buildRatiosGrid(isDark),
        Divider(color: isDark ? Color(0xFF2F2F2F) : Color(0xFFD1D5DB)),
        SizedBox(height: 12.h),
        _buildShareholdingHeader(isDark),
        buildShareholdingChart(isDark),
        Divider(color: isDark ? Color(0xFF2F2F2F) : Color(0xFFD1D5DB)),
        SizedBox(height: 12.h),
        _buildEarningsHeader(isDark),
        SizedBox(height: 16.h),
        _buildEarningsTabs(isDark),
        SizedBox(height: 16.h),
        _buildEarningsChart(isDark),
        SizedBox(height: 10.h),
        Center(
            child: Align(
                alignment: Alignment.centerRight,
                child: Text('*All values are in crore',
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp)))),
        SizedBox(height: 12.h),
        Divider(color: isDark ? Color(0xFF2F2F2F) : Color(0xFFD1D5DB)),
        SizedBox(height: 12.h),
        _buildSectionHeader(isDark, 'About Company'),
        SizedBox(height: 16.h),
        Text(
          'Reliance Industries Limited (RIL) is India\'s largest private sector company. The company\'s activities span hydrocarbon exploration and production, petroleum refining and marketing, petrochemicals, advanced materials and composites, renewables (solar and hydrogen), retail and digital services...',
          style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 13.sp,
              height: 1.5),
        ),
        SizedBox(height: 16.h),
        _buildCompanyDetailsTable(isDark),
        SizedBox(height: 24.h),
        Divider(color: isDark ? Color(0xFF2F2F2F) : Color(0xFFD1D5DB)),
        SizedBox(height: 16.h),
        _buildLocateSection(isDark),
        SizedBox(height: 24.h),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
