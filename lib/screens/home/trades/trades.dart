// File: trades.dart
// Description: Trades management screen in the Sapphire Trading application.
// This screen displays different trading instruments (Stocks, Futures, Options, Commodity) with market data and provides navigation to other app sections.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/svg.dart'; // For SVG image rendering
import 'package:sapphire/main.dart'; // App-wide utilities
import 'package:sapphire/screens/funds/funds.dart'; // Funds management screen
import 'package:sapphire/screens/account/account.dart'; // User profile screen
import 'package:sapphire/screens/home/trades/tradeReuse.dart'; // Reusable trade components
import 'package:sapphire/screens/home/trades/stocks/activeTrades/activeStocks.dart'; // Active stock trades screen
import 'package:sapphire/screens/home/trades/stocks/closedTrades/closedStocks.dart'; // Closed stock trades screen
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI widgets
import 'package:sapphire/utils/naviWithoutAnimation.dart'; // Navigation utility without animations
import '../holdings/holdings.dart'; // Holdings screen

/// TradesScreen - Main screen for displaying and managing trading activities
/// Shows different trading instruments via tabs and displays market data
class TradesScreen extends StatefulWidget {
  const TradesScreen({super.key});

  @override
  State<TradesScreen> createState() => _TradesScreenState();
}

/// State class for the TradesScreen widget
/// Manages the UI display, tab selection, and page controller for trading instruments
class _TradesScreenState extends State<TradesScreen> {
  late PageController _pageController; // Controls the page view for different trading tabs
  final List<String> tabs = ["Stocks", "Futures", "Options", "Commodity"]; // Trading instrument tabs
  int _selectedIndex = 0; // Currently selected tab index

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex); // Initialize page controller with default tab
  }

  @override
  void dispose() {
    _pageController.dispose(); // Clean up page controller resource
    super.dispose();
  }

  /// Handles tab selection and updates the page view
  /// @param index - The index of the selected tab
  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index); // Navigate to corresponding page
    });
  }

  /// Updates the selected tab index when page is changed via swipe
  /// @param index - The index of the new page
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Handles the pull-to-refresh functionality
  /// Refreshes the trade data from the server (currently just a placeholder)
  Future<void> _onRefresh() async {
    // Simulate a network fetch or data refresh
    await Future.delayed(const Duration(seconds: 2));
    // TODO: Implement actual data refresh logic here (e.g., API call)
    setState(() {
      // Update UI if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff000000),
        appBar: AppBar(
          elevation: 0,
          surfaceTintColor: Colors.black,
          shadowColor: Colors.transparent,
          backgroundColor: const Color(0xff000000),
          automaticallyImplyLeading: false,
          toolbarHeight: 0,
        ),
        body: NestedScrollView(
          // Header section with app title, profile access, and market data
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            // App header with title and navigation icons
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Screen title
                    Text(
                      "Trades",
                      style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffEBEEF5),
                      ),
                    ),
                    Spacer(),
                    // Funds navigation button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: GestureDetector(
                        onTap: () {
                          naviWithoutAnimation(context, FundsScreen()); // Navigate to funds screen
                        },
                        child: SvgPicture.asset(
                          "assets/svgs/wallet.svg",
                          width: 20.w,
                          height: 23.h,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Profile navigation button
                    InkWell(
                      onTap: () {
                        naviWithoutAnimation(context, ProfileScreen()); // Navigate to profile screen
                      },
                      child: CircleAvatar(
                        backgroundColor: const Color(0xff021814),
                        radius: 22.r,
                        child: Text(
                          "NK",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff22A06B),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Market data cards section - Shows key market indices
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MarketDataCard("NIFTY 50", "23,018.20", "-218.20 (1.29%)"),
                    MarketDataCard("SENSEX", "73,018.20", "+218.20 (1.29%)"),
                  ],
                ),
              ),
            ),
            // Custom tab bar for trading instruments
            SliverPersistentHeader(
              pinned: true,
              delegate: CustomTabBarDelegate(
                tabNames: tabs,
                selectedIndex: _selectedIndex,
                onTabTapped: _onTabTapped,
              ),
            ),
          ],
          // Main content body with trading instrument tabs
          body: RefreshIndicator(
            onRefresh: _onRefresh,
            color: const Color(0xff1DB954), // Refresh indicator color
            backgroundColor: const Color(0xff121413),
            child: SingleChildScrollView(
              physics:
              const AlwaysScrollableScrollPhysics(), // Ensures scrollability
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page view for different trading instrument tabs
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 100.h,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: _onPageChanged,
                        itemCount: tabs.length,
                        itemBuilder: (context, index) {
                          return TradesTabContent(tabType: tabs[index]); // Load specific tab content
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// CustomTabBarDelegate - Handles the custom persistent header tab bar
/// Displays tabs for different trading instruments and manages their selection state
class CustomTabBarDelegate extends SliverPersistentHeaderDelegate {
  final List<String> tabNames; // Names of tabs to display
  final int selectedIndex; // Currently selected tab
  final Function(int) onTabTapped; // Callback when a tab is tapped

  CustomTabBarDelegate({
    required this.tabNames,
    required this.selectedIndex,
    required this.onTabTapped,
  });

  @override
  double get minExtent => 55.h; // Minimum height of the tab bar

  @override
  double get maxExtent => 55.h; // Maximum height of the tab bar

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(0xff000000),
      child: Stack(children: [
        // Bottom border line for the tab bar
        Positioned.fill(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 1,
              color: const Color(0xff2f2f2f),
            ),
          ),
        ),
        // Row of tab items
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(tabNames.length, (index) {
            final isSelected = index == selectedIndex;
            return Expanded(
              child: GestureDetector(
                onTap: () => onTabTapped(index),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isSelected
                            ? const Color(0xff1DB954) // Green indicator for selected tab
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Text(
                        tabNames[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected ? Colors.green : Colors.white, // Selected tab text is green
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ]),
    );
  }

  @override
  bool shouldRebuild(covariant CustomTabBarDelegate oldDelegate) {
    return tabNames != oldDelegate.tabNames ||
        selectedIndex != oldDelegate.selectedIndex; // Rebuild if tabs or selection changes
  }
}

/// MarketDataCard - Widget that displays market index information
/// Shows the market index name, current price, and price change
/// @param title - Name of the market index
/// @param price - Current price of the index
/// @param change - Price change with percentage
Widget MarketDataCard(String title, String price, String change) {
  final bool isPositive = change.startsWith('+'); // Determine if price change is positive
  final Color changeColor = isPositive ? Colors.green : Colors.red; // Green for positive, red for negative

  return Container(
    height: 62.h,
    width: 175.w,
    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
    decoration: BoxDecoration(
      color: const Color(0xff121413),
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(color: const Color(0xff2F2F2F), width: 1.5.w),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Market index name
        Text(
          title,
          style: TextStyle(
              color: const Color(0xffEBEEF5),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 2.h),
        // Price and change container
        Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: const Color(0xff121413),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Current price
              Text(
                price,
                style:
                TextStyle(color: const Color(0xffEBEEF5), fontSize: 12.sp),
              ),
              SizedBox(width: 6.w),
              // Price change with color indication
              Text(
                change,
                style: TextStyle(color: changeColor, fontSize: 12.sp),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// TradesUtils - Utility class for trade-related helper functions and UI components
/// Provides reusable widgets and dialogs for the trades screens
class TradesUtils {
  /// Creates and returns a dialog for confirming trade orders
  /// @param context - The build context for showing the dialog
  /// @return AlertDialog - A styled dialog with cancel and confirm options
  static Widget placeOrderPopup(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xff121413), // Dark background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      content: Text(
        "Would you like to proceed with this order?",
        style: TextStyle(color: Colors.white, fontSize: 16.sp),
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Cancel button
            Expanded(
              child: TextButton(
                onPressed: () {
                  // Handle Cancel action
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[800], // Dark gray for Cancel
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              ),
            ),
            SizedBox(width: 6.w),
            // Place Order button
            Expanded(
              child: TextButton(
                onPressed: () {
                  // Handle Place Order action
                  Navigator.of(context).pop(); // Close the dialog
                  // TODO: Implement order placement logic here
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green, // Green for Place Order
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  "Place Order",
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}