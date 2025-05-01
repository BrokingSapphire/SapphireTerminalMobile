import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/funds/funds.dart';
import 'package:sapphire/screens/account/account.dart';
import 'package:sapphire/screens/home/watchlist/searchPage.dart';
import 'package:sapphire/screens/orderWindow/BuyScreens/buyWrapper.dart';
import 'package:sapphire/screens/orderWindow/SellScreens/sellWrapper.dart';
import 'package:sapphire/utils/constWidgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sapphire/utils/naviWithoutAnimation.dart';
import 'package:sapphire/screens/home/watchlist/watchlistTabBar.dart';
import 'package:sapphire/utils/filters.dart';
import 'package:sapphire/wat.dart'; // For showFilterBottomSheet
import 'package:sapphire/screens/home/watchlist/stockDetailSheet.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen>
    with SingleTickerProviderStateMixin {
  // --- Added for filter/sort/search ---
  String? _selectedFilterLabel;
  String? _selectedDirection;
  String _searchQuery = '';
  //-----------------------------------
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

  List<Map<String, dynamic>> watchlistData = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    // Initialize watchlistData
    watchlistData = [
      {
        'items': [
          ...initialWatchlistData.sublist(0, 2), // First two stocks
          ...initialWatchlistData.sublist(2, 5), // Next three stocks
          ...initialWatchlistData.sublist(5), // Remaining stocks
        ],
      }
    ];
    print('Initial tab set to: Watchlist ${_selectedIndex + 1}');
  }

  void _onTabTapped(int index) {
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

  // --- Refresh logic ---
  Future<void> _onRefresh() async {
    // Simulate a network fetch or data refresh
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      // Example: Reset or update watchlistData for the current tab
      watchlistData[_selectedIndex]['items'] = [
        ...initialWatchlistData, // Reload initial data or fetch new data
      ];
      print("Refreshed Watchlist ${tabNames[_selectedIndex]}");
    });
  }

  void _showEditCategoryDialog(
      BuildContext context, String currentName, int itemIndex) {
    final TextEditingController controller =
        TextEditingController(text: currentName);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xff121413) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          bottom: MediaQuery.of(context).viewInsets.bottom + 15.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Edit Category",
                  style: TextStyle(
                    fontSize: 21.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? const Color(0xffEBEEF5) : Colors.black,
                  ),
                ),
                Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset("assets/svgs/delete.svg",
                        color: isDark ? Colors.white : Colors.black)),
                IconButton(
                  icon: Icon(Icons.close,
                      color: isDark ? Colors.white : Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Enter New Category Name",
                style: TextStyle(
                  color: isDark ? Color(0xffEBEEF5) : Colors.black,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                hintText: "Enter Category Name",
                labelStyle:
                    TextStyle(color: isDark ? Color(0xffEBEEF5) : Colors.black),
                hintStyle: TextStyle(
                    color: isDark ? Color(0xffEBEEF5) : Colors.black,
                    fontSize: 15.sp),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.r)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.r)),
                  borderSide: BorderSide(color: Color(0XFF2F2F2F)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.r)),
                  borderSide: BorderSide(color: Colors.green, width: 2.0),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            constWidgets.greenButton("Save", onTap: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  watchlistData[_selectedIndex]['items'][itemIndex] = controller
                      .text
                      .trim()
                      .toUpperCase(); // Update category name in all caps
                });
                Navigator.pop(context);
              }
            }),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }

  Widget _buildWatchlistTab(int index, bool isDark) {
    List<dynamic> currentItems = watchlistData[index]['items'] is List
        ? List<dynamic>.from(watchlistData[index]['items'])
        : [];

    // --- Apply search filter ---
    if (_searchQuery.isNotEmpty) {
      currentItems = currentItems.where((item) {
        if (item is Map<String, String>) {
          return (item['symbol']
                      ?.toLowerCase()
                      .contains(_searchQuery.toLowerCase()) ??
                  false) ||
              (item['company']
                      ?.toLowerCase()
                      .contains(_searchQuery.toLowerCase()) ??
                  false);
        } else if (item is String) {
          return item.toLowerCase().contains(_searchQuery.toLowerCase());
        }
        return false;
      }).toList();
    }

    // --- Apply sorting if a filter is selected ---
    if (_selectedFilterLabel != null && _selectedDirection != null) {
      List<String> categories = currentItems.whereType<String>().toList();
      List<Map<String, String>> stocks =
          currentItems.whereType<Map<String, String>>().toList();

      if (_selectedFilterLabel == 'Alphabetical') {
        stocks.sort((a, b) {
          String aStr = a['symbol'] ?? '';
          String bStr = b['symbol'] ?? '';
          int cmp = aStr.compareTo(bStr);
          return _selectedDirection == 'A–Z' ? cmp : -cmp;
        });
      } else if (_selectedFilterLabel == 'Price') {
        stocks.sort((a, b) {
          double aPrice = double.tryParse(a['price'] ?? '') ?? 0;
          double bPrice = double.tryParse(b['price'] ?? '') ?? 0;
          return _selectedDirection == 'Ascending'
              ? aPrice.compareTo(bPrice)
              : bPrice.compareTo(aPrice);
        });
      } else if (_selectedFilterLabel == 'Change (1 Day)') {
        stocks.sort((a, b) {
          double aChange = double.tryParse((a['change'] ?? '')
                  .split(' ')
                  .first
                  .replaceAll('+', '')
                  .replaceAll('%', '')) ??
              0;
          double bChange = double.tryParse((b['change'] ?? '')
                  .split(' ')
                  .first
                  .replaceAll('+', '')
                  .replaceAll('%', '')) ??
              0;
          return _selectedDirection == 'Ascending'
              ? aChange.compareTo(bChange)
              : bChange.compareTo(aChange);
        });
      }
      currentItems = [...categories, ...stocks];
      watchlistData[index]['items'] = currentItems;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: _isSearchBarVisible,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
            child: _searchAndFilterBar(isDark),
          ),
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollStartNotification) {
                _previousOffset = scrollNotification.metrics.pixels;
              } else if (scrollNotification is ScrollUpdateNotification) {
                double currentOffset = scrollNotification.metrics.pixels;
                bool isScrollingDown = currentOffset > _previousOffset;

                // Fixed logic: Don't restrict to top 5.0 pixels
                // Handle search bar visibility based on scroll direction
                if (isScrollingDown) {
                  // Hide search bar when scrolling down
                  if (_isSearchBarVisible) {
                    setState(() {
                      _isSearchBarVisible = false;
                    });
                  }
                } else if (!isScrollingDown && currentOffset <= 10.0) {
                  // Show search bar when scrolling up and near the top
                  // Only at the top to prevent showing in the middle
                  if (!_isSearchBarVisible) {
                    setState(() {
                      _isSearchBarVisible = true;
                    });
                  }
                }

                _previousOffset = currentOffset;
              } else if (scrollNotification is ScrollEndNotification) {
                // Add this to handle when scrolling ends at the top
                if (scrollNotification.metrics.pixels == 0) {
                  if (!_isSearchBarVisible) {
                    setState(() {
                      _isSearchBarVisible = true;
                    });
                  }
                }
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
                : RefreshIndicator(
                    color: Color(0xff1DB954), // Match app's theme
                    onRefresh: _onRefresh,
                    child: ReorderableListView.builder(
                      itemCount: currentItems.length,
                      itemBuilder: (context, itemIndex) {
                        final item = currentItems[itemIndex];
                        if (item is String) {
                          // Render category with dividers and slidable delete option
                          return Slidable(
                            key: ValueKey('category_$item'),
                            endActionPane: ActionPane(
                              motion: const DrawerMotion(),
                              extentRatio: 0.2,
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                watchlistData[_selectedIndex]
                                                        ['items']
                                                    .removeAt(itemIndex);
                                                print(
                                                    "Deleted category '$item' from Watchlist ${tabNames[_selectedIndex]}");
                                              });
                                            },
                                            child: SvgPicture.asset(
                                              "assets/svgs/delete.svg",
                                              color: Color(0xff1DB954),
                                              width: 24.w,
                                              height: 24.h,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onLongPress: () {
                                // Use a Timer to ensure 2-second long press
                                Timer(Duration(milliseconds: 2000), () {
                                  if (mounted) {
                                    _showEditCategoryDialog(
                                        context, item, itemIndex);
                                  }
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(),
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
                                          fontSize: 16.sp,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                                                        color: Color(
                                                            0xff1DB954)))),
                                            Container(
                                                width: 1,
                                                color: Color(0xFF2F2F2F)),
                                            Expanded(
                                                child: Center(
                                                    child: SvgPicture.asset(
                                                        "assets/svgs/link.svg",
                                                        color: Color(
                                                            0xff1DB954)))),
                                            Container(
                                                width: 1,
                                                color: Color(0xFF2F2F2F)),
                                            Expanded(
                                                child: Center(
                                                    child: SvgPicture.asset(
                                                        "assets/svgs/bookmark-x.svg",
                                                        color: Color(
                                                            0xff1DB954)))),
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
                                                behavior:
                                                    HitTestBehavior.opaque,
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
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SellScreenWrapper())),
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
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    isDismissible: true,
                                    enableDrag: true,
                                    builder: (_) => StockDetailBottomSheet(
                                      stockName: item['symbol'] ?? '',
                                      stockCode: item['company'] ?? '',
                                      price: item['price'] ?? '',
                                      change: item['change'] ?? '',
                                      onBuy: () {
                                        // Handle buy action
                                      },
                                      onSell: () {
                                        // Handle sell action
                                      },
                                    ),
                                  );
                                },
                                child: constWidgets.watchListDataView(
                                  "https://companieslogo.com/img/orig/${item['symbol']}.png?t=1720244493",
                                  item['symbol']!,
                                  item['company']!,
                                  item['price']!,
                                  item['change']!,
                                  isDark,
                                ),
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
        )
      ],
    );
  }

  // --- Custom search/filter bar with search and filter callbacks ---
  Widget _searchAndFilterBar(bool isDark) {
    return Row(
      children: [
        // Search field
        Expanded(
          child: constWidgets.searchField(
              context, "Search Everything...", "orders", isDark),
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
                            letterSpacing: 1,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? const Color(0xffEBEEF5)
                                : Colors.black)),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: GestureDetector(
                        onTap: () =>
                            naviWithoutAnimation(context, FundsScreen()),
                        child: SvgPicture.asset("assets/svgs/wallet.svg",
                            width: 20.w,
                            height: 23.h,
                            color: isDark ? Colors.white : Colors.black),
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          naviWithoutAnimation(context, ProfileScreen()),
                      child: CircleAvatar(
                        backgroundColor: isDark
                            ? const Color(0xff021814)
                            : const Color(0xff22A06B).withOpacity(0.2),
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
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 14.h),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    marketDataCard(context, "NIFTY 50", "23,018.20",
                        "-218.20 (1.29%)", isDark),
                    marketDataCard(context, "SENSEX", "73,018.20",
                        "+218.20 (1.29%)", isDark),
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
    return Container(
      height: 38.0, // Explicitly set the height to match maxExtent
      color: isDark
          ? const Color(0xff000000)
          : Colors.white, // Optional: Match background
      child: WatchlistTabBar(
        tabNames: tabNames,
        selectedIndex: selectedIndex,
        onTabTapped: onTabTapped,
        onEditWatchlist: onEditWatchlist,
        onCreateWatchlist: onCreateWatchlist,
        onAddCategory: onAddCategory,
        isDark: isDark,
      ),
    );
  }

  @override
  double get maxExtent => 38.0; // Ensure this matches the actual height

  @override
  double get minExtent => 38.0; // Ensure this matches the actual height

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

/// MarketDataCard: A card displaying market data, now fully theme-aware
Widget marketDataCard(BuildContext context, String title, String price,
    String change, bool isDark) {
  final bool isPositive = change.startsWith('+');
  final Color changeColor = isPositive ? Colors.green : Colors.red;

  return Container(
    height: 62.h,
    width: 175.w,
    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
    decoration: BoxDecoration(
      // Card background adapts to theme
      color: isDark ? Color(0xff121413) : const Color(0xFFF4F4F9),
      borderRadius: BorderRadius.circular(10.r),
      // Card border adapts to theme divider
      border: Border.all(
          color: isDark ? Color(0xff2F2F2F) : Color(0xFFF4F4F9), width: 1.5.w),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: isDark ? const Color(0xffEBEEF5) : Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 2.h),
        Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
              color: isDark ? Color(0xff121413) : Colors.grey.shade200,
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
