import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/accountSection/fundsScreen.dart';
import 'package:sapphire/screens/accountSection/profileScreen.dart';
import 'package:sapphire/screens/home/searchPage.dart';
import 'package:sapphire/screens/orderWindow/BuyScreens/buyScreenWrapper.dart';
import 'package:sapphire/utils/constWidgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sapphire/utils/naviWithoutAnimation.dart';
import 'package:sapphire/utils/watchlistTabBar.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  List<String> tabNames = ['Watchlist 1'];
  int _selectedIndex = 0;
  bool _isSearchBarVisible = true;
  double _previousOffset = 0.0;

  final List<Map<String, String>> initialWatchlistData = [
    {
      "symbol": "BAJFINANCE",
      "company": "Bajaj Finance Ltd.",
      "price": "6800.00",
      "change": "-150.50 (-2.17%)"
    },
    {
      "symbol": "KOTAKBANK",
      "company": "Kotak Mahindra Bank Ltd.",
      "price": "1800.60",
      "change": "+22.30 (+1.25%)"
    },
    {
      "symbol": "HINDUNILVR",
      "company": "Hindustan Unilever Ltd.",
      "price": "2400.90",
      "change": "-30.40 (-1.25%)"
    },
    {
      "symbol": "ASIANPAINT",
      "company": "Asian Paints Ltd.",
      "price": "2900.25",
      "change": "+45.15 (+1.58%)"
    },
    {
      "symbol": "MARUTI",
      "company": "Maruti Suzuki India Ltd.",
      "price": "12500.70",
      "change": "-200.30 (-1.58%)"
    },
    {
      "symbol": "BHARTIARTL",
      "company": "Bharti Airtel Ltd.",
      "price": "950.80",
      "change": "+10.20 (+1.08%)"
    },
    {
      "symbol": "ITC",
      "company": "ITC Ltd.",
      "price": "425.50",
      "change": "-5.75 (-1.33%)"
    },
    {
      "symbol": "LT",
      "company": "Larsen & Toubro Ltd.",
      "price": "3400.10",
      "change": "+60.40 (+1.81%)"
    },
    {
      "symbol": "AXISBANK",
      "company": "Axis Bank Ltd.",
      "price": "1050.35",
      "change": "-15.65 (-1.47%)"
    },
    {
      "symbol": "RELIANCE",
      "company": "Reliance Industries Ltd.",
      "price": "2500.00",
      "change": "-25.55 (-1.01%)"
    },
    {
      "symbol": "TCS",
      "company": "Tata Consultancy Services",
      "price": "3200.50",
      "change": "+123.45 (+4.01%)"
    },
    {
      "symbol": "INFY",
      "company": "Infosys",
      "price": "1450.75",
      "change": "-34.20 (-2.30%)"
    },
    {
      "symbol": "HDFCBANK",
      "company": "HDFC Bank Ltd.",
      "price": "1600.30",
      "change": "+15.75 (+0.99%)"
    },
    {
      "symbol": "ICICIBANK",
      "company": "ICICI Bank Ltd.",
      "price": "1100.20",
      "change": "-12.10 (-1.09%)"
    },
    {
      "symbol": "SBIN",
      "company": "State Bank of India",
      "price": "750.40",
      "change": "+8.25 (+1.11%)"
    },
  ];

  // Define watchlistData as List<Map<String, dynamic>> to store a unified list of items
  List<Map<String, dynamic>> watchlistData = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    // Initialize watchlistData with a unified list of categories and stocks
    watchlistData = [
      {
        'items': [
          'Banking', // Category
          ...initialWatchlistData.sublist(0, 2), // First two stocks
          'FMCG', // Category
          ...initialWatchlistData.sublist(2, 5), // Next three stocks
          'Automobile', // Category
          ...initialWatchlistData.sublist(5), // Remaining stocks
        ],
      }
    ];
    print('Initial tab set to: Watchlist ${_selectedIndex + 1}');
  }

  void _onTabTapped(int index) {
    print(
        'Tapped tab: Switching to Watchlist ${index + 1} (from Watchlist ${_selectedIndex + 1})');
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  void _onPageChanged(int index) {
    print(
        'Swiped tab: Switching to Watchlist ${index + 1} (from Watchlist ${_selectedIndex + 1})');
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAddTab() {
    setState(() {
      int newTabNumber = tabNames.length + 1;
      tabNames.add('Watchlist $newTabNumber');
      watchlistData.add({
        'items': <dynamic>[],
      });
      _selectedIndex = tabNames.length - 1;
      _pageController.jumpToPage(_selectedIndex);
      print(
          'Added new tab: Watchlist $newTabNumber, now on Watchlist $newTabNumber');
    });
  }

  Widget _buildWatchlistTab(int index, bool isDark) {
    // Safely access the unified items list
    final watchlist = watchlistData[index];
    List<dynamic> currentItems = watchlist['items'] is List
        ? List<dynamic>.from(watchlist['items'])
        : [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: _isSearchBarVisible,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
            child: constWidgets.searchField(
                context, "Search Everything...", "watchlist", isDark),
          ),
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollStartNotification) {
                _previousOffset = scrollNotification.metrics.pixels;
              } else if (scrollNotification is ScrollUpdateNotification) {
                double currentOffset = scrollNotification.metrics.pixels;
                bool isAtTop = currentOffset < 5.0;
                bool isScrollingDown = currentOffset > _previousOffset;

                if (isAtTop && isScrollingDown) {
                  if (_isSearchBarVisible) {
                    setState(() {
                      _isSearchBarVisible = false;
                    });
                  }
                } else if (currentOffset < 5.0 && !isScrollingDown) {
                  if (!_isSearchBarVisible) {
                    setState(() {
                      _isSearchBarVisible = true;
                    });
                  }
                }
                _previousOffset = currentOffset;
              }
              return true;
            },
            child: currentItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 150.h,
                            width: 150.w,
                            child:
                                Image.asset("assets/emptyPng/instruments.png")),
                        Text("Watchlist ${index + 1} is empty",
                            style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black)),
                        SizedBox(height: 10.h),
                        SizedBox(
                            width: 250.w,
                            child: Text(
                                "Use search bar to find and track favourite stocks here",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.sp, color: Colors.grey))),
                      ],
                    ),
                  )
                : ReorderableListView.builder(
                    itemCount: currentItems.length,
                    itemBuilder: (context, itemIndex) {
                      final item = currentItems[itemIndex];
                      if (item is String) {
                        // Render category
                        return Container(
                          key: ValueKey('category_$item'),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (itemIndex == 0)
                                Divider(
                                  color: Color(0xFF2F2F2F),
                                  thickness: 1,
                                  height: 1.h,
                                ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6.h, horizontal: 16.w),
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0xffEBEEF5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Divider(
                                color: Color(0xFF2F2F2F),
                                thickness: 1,
                                height: 1.h,
                              ),
                            ],
                          ),
                        );
                      } else if (item is Map<String, String>) {
                        // Render stock
                        return Container(
                          key: ValueKey('stock_${item['symbol']}'),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Color(0xFF2F2F2F), width: 1))),
                          child: Slidable(
                            key: ValueKey("slidable_${item['symbol']}"),
                            closeOnScroll: true,
                            startActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                extentRatio: 0.4,
                                children: [
                                  Expanded(
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                              child: Center(
                                                  child: SvgPicture.asset(
                                                      "assets/svgs/chart-candlestick.svg",
                                                      color:
                                                          Color(0xff1DB954)))),
                                          Container(
                                              width: 1,
                                              color: Color(0xFF2F2F2F)),
                                          Expanded(
                                              child: Center(
                                                  child: SvgPicture.asset(
                                                      "assets/svgs/link.svg",
                                                      color:
                                                          Color(0xff1DB954)))),
                                          Container(
                                              width: 1,
                                              color: Color(0xFF2F2F2F)),
                                          Expanded(
                                              child: Center(
                                                  child: SvgPicture.asset(
                                                      "assets/svgs/bookmark-x.svg",
                                                      color:
                                                          Color(0xff1DB954)))),
                                          Container(
                                              width: 1,
                                              color: Color(0xFF2F2F2F)),
                                        ]),
                                  ),
                                ]),
                            endActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                extentRatio: 0.4,
                                children: [
                                  Expanded(
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                              width: 1,
                                              color: Color(0xFF2F2F2F)),
                                          Expanded(
                                            child: GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BuyScreenWrapper(
                                                              isbuy: true))),
                                              child: Center(
                                                  child: Text("B",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18.sp))),
                                            ),
                                          ),
                                          Container(
                                              width: 1,
                                              color: Color(0xFF2F2F2F)),
                                          Expanded(
                                            child: GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BuyScreenWrapper(
                                                              isbuy: false))),
                                              child: Center(
                                                  child: Text("S",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18.sp))),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ]),
                            child: constWidgets.watchListDataView(
                              "https://companieslogo.com/img/orig/${item['symbol']}.png?t=1720244493",
                              item['symbol']!,
                              item['company']!,
                              item['price']!,
                              item['change']!,
                              isDark,
                            ),
                          ),
                        );
                      }
                      return SizedBox
                          .shrink(); // Fallback for invalid item types
                    },
                    onReorder: (int oldIndex, int newIndex) {
                      setState(() {
                        if (oldIndex < newIndex) newIndex -= 1;
                        final item = currentItems.removeAt(oldIndex);
                        currentItems.insert(newIndex, item);
                        watchlistData[_selectedIndex]['items'] = currentItems;
                        print(
                            "Reordered items in Watchlist ${tabNames[_selectedIndex]}: ${currentItems.map((e) => e is String ? e : e['symbol']).toList()}");
                      });
                    },
                  ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: isDark ? Colors.black : Colors.white,
        shadowColor: Colors.transparent,
        backgroundColor: isDark ? const Color(0xff000000) : Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Watchlist",
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? const Color(0xffEBEEF5)
                                : Colors.black)),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: GestureDetector(
                        onTap: () => navi(FundsScreen(), context),
                        child: SvgPicture.asset("assets/svgs/wallet.svg",
                            width: 22.w,
                            height: 25.h,
                            colorFilter: ColorFilter.mode(
                                isDark ? Colors.white70 : Colors.black,
                                BlendMode.srcIn)),
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          naviWithoutAnimation(context, ProfileScreen()),
                      child: CircleAvatar(
                        backgroundColor: isDark
                            ? const Color(0xff021814)
                            : Colors.grey.shade200,
                        radius: 22.r,
                        child: Text("NK",
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff22A06B))),
                      ),
                    ),
                  ]),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 10.h),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MarketDataCard(
                        context, "NIFTY 50", "23,018.20", "-218.20 (1.29%)"),
                    MarketDataCard(
                        context, "SENSEX", "73,018.20", "+218.20 (1.29%)"),
                  ]),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _WatchlistTabBarDelegate(
              tabNames: tabNames,
              selectedIndex: _selectedIndex,
              onTabTapped: _onTabTapped,
              onEditWatchlist: (index, newName) {
                setState(() {
                  tabNames[index] = newName;
                });
              },
              onCreateWatchlist: (name) {
                setState(() {
                  tabNames.add(name);
                  watchlistData.add({
                    'items': <dynamic>[],
                  });
                  _selectedIndex = tabNames.length - 1;
                  _pageController.jumpToPage(_selectedIndex);
                });
              },
              onAddCategory: (categories) {
                setState(() {
                  if (_selectedIndex < watchlistData.length) {
                    // Append new categories to the items list
                    watchlistData[_selectedIndex]['items'] = [
                      ...watchlistData[_selectedIndex]['items'],
                      ...categories
                    ];
                    print(
                        "Added categories to Watchlist ${tabNames[_selectedIndex]}: $categories");
                  } else {
                    print("Error: Invalid watchlist index $_selectedIndex");
                  }
                });
              },
            ),
          ),
        ],
        body: PageView.builder(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          itemCount: tabNames.length,
          itemBuilder: (context, index) => _buildWatchlistTab(index, isDark),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class _WatchlistTabBarDelegate extends SliverPersistentHeaderDelegate {
  final List<String> tabNames;
  final int selectedIndex;
  final Function(int) onTabTapped;
  final Function(int, String) onEditWatchlist;
  final Function(String) onCreateWatchlist;
  final Function(List<String>) onAddCategory;

  _WatchlistTabBarDelegate({
    required this.tabNames,
    required this.selectedIndex,
    required this.onTabTapped,
    required this.onEditWatchlist,
    required this.onCreateWatchlist,
    required this.onAddCategory,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return WatchlistTabBar(
      tabNames: tabNames,
      selectedIndex: selectedIndex,
      onTabTapped: onTabTapped,
      onEditWatchlist: onEditWatchlist,
      onCreateWatchlist: onCreateWatchlist,
      onAddCategory: onAddCategory,
      isDark: isDark,
    );
  }

  @override
  double get maxExtent => 48.0;

  @override
  double get minExtent => 48.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

/// MarketDataCard: A card displaying market data, now fully theme-aware
Widget MarketDataCard(
    BuildContext context, String title, String price, String change) {
  final bool isPositive = change.startsWith('+');
  final Color changeColor = isPositive
      ? Theme.of(context).colorScheme.primary
      : Theme.of(context).colorScheme.error;

  return Container(
    height: 62.h,
    width: 175.w,
    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
    decoration: BoxDecoration(
      // Card background adapts to theme
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(10.r),
      // Card border adapts to theme divider
      border: Border.all(color: Theme.of(context).dividerColor, width: 1.5.w),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title text adapts to theme
        Text(title,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 2.h),
        // Price & change container adapts to theme
        Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(6.r)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            // Price text adapts to theme
            Text(price,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 12.sp)),
            SizedBox(width: 6.w),
            // Change text uses theme primary/error
            Text(change, style: TextStyle(color: changeColor, fontSize: 12.sp)),
          ]),
        ),
      ],
    ),
  );
}
