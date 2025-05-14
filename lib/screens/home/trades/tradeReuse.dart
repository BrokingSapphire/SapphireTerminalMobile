// File: tradesReuse.dart
// Description: Trade tab content management for the Sapphire Trading application.
// This file handles the display of active and closed trades for different trading instruments (Stocks, Futures, Options, Commodity).

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:sapphire/screens/home/trades/commodity/activeTrades/activeCommodity.dart'; // Active commodity trades screen
import 'package:sapphire/screens/home/trades/commodity/closedTrades/closedCommodity.dart'; // Closed commodity trades screen
import 'package:sapphire/screens/home/trades/options/activeTrades/activeOptions.dart'; // Active options trades screen
import 'package:sapphire/screens/home/trades/options/closedTrades/closedOptions.dart'; // Closed options trades screen
import 'package:sapphire/screens/home/trades/stocks/activeTrades/activeStocks.dart'; // Active stocks trades screen
import 'package:sapphire/screens/home/trades/stocks/closedTrades/closedStocks.dart'; // Closed stocks trades screen
import 'package:sapphire/screens/home/trades/futures/activeTrades/activeFutures.dart'; // Active futures trades screen
import 'package:sapphire/screens/home/trades/futures/closedTrades/closedFutures.dart'; // Closed futures trades screen

/// TradesTabContent - Widget that manages the content display for each trading instrument tab
/// Allows toggling between active and closed trades for the selected instrument type
class TradesTabContent extends StatefulWidget {
  final String tabType; // The type of trading instrument (Stocks, Futures, Options, Commodity)

  const TradesTabContent({super.key, required this.tabType});

  @override
  State<TradesTabContent> createState() => _TradesTabContentState();
}

/// State class for the TradesTabContent widget
/// Manages the UI display and toggle state between active and closed trades
class _TradesTabContentState extends State<TradesTabContent> {
  bool isEmpty = false; // Flag to indicate if there are no trades to display
  bool isActive = true; // Toggle state - true for active trades, false for closed trades

  @override
  Widget build(BuildContext context) {
    print(
        'TradesTabContent: tabType=${widget.tabType}, isEmpty=$isEmpty, isActive=$isActive'); // Debug information
    if (isEmpty) {
      // Empty state UI - Shown when no trades are available
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty state illustration
            SizedBox(
                height: 150.h,
                width: 150.w,
                child: Image.asset("assets/emptyPng/trades.png")),
            // Empty state main message
            Text(
              "No Trades Idea Yet",
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            // Empty state supportive text
            SizedBox(
              width: 250.w,
              child: Text(
                "Discover market opportunities and start explore more trading ideas!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.sp, color: Colors.grey),
              ),
            ),
          ],
        ),
      );
    } else {
      // Trades content UI - Shown when trades are available
      return Column(
        children: [
          SizedBox(height: 12.h),
          // Toggle button to switch between active and closed trades
          _toggleButton(isActive, (value) {
            setState(() {
              isActive = value;
            });
          }),
          // Content area displaying the appropriate trades screen
          Flexible(
            child: _buildContent(widget.tabType),
          ),
        ],
      );
    }
  }

  /// Conditionally loads the appropriate trades screen based on tabType and toggle state
  /// @param type - The type of trading instrument to display
  /// @return Widget - The corresponding trades screen widget
  Widget _buildContent(String type) {
    print('Building content for type: $type, isActive: $isActive'); // Debug information
    switch (type.toLowerCase()) {
      case "futures":
      // Futures trades screens
        return isActive
            ? const TradesFutureActiveScreen() // Active futures trades
            : const TradesFutureClosedScreen(); // Closed futures trades
      case "stocks":
      // Stocks trades screens
        return isActive
            ? const TradesActiveScreen() // Active stock trades
            : const TradesClosedScreen(); // Closed stock trades
      case "options":
      // Options trades screens
        return isActive
            ? const TradesOptionActiveScreen() // Active options trades
            : const TradesOptionClosedScreen(); // Closed options trades
      case "commodity":
      // Commodity trades screens
        return isActive
            ? const TradesComActiveScreen() // Active commodity trades
            : const TradesComClosedScreen(); // Closed commodity trades
      default:
      // Fallback for undefined tab types
        return Center(
          child: Text(
            "Coming Soon!",
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
        );
    }
  }

  /// Creates a toggle button to switch between active and closed trades
  /// @param isActiveTrades - Current toggle state (true for active, false for closed)
  /// @param onToggle - Callback function when toggle state changes
  /// @return Widget - A styled toggle button container
  Widget _toggleButton(bool isActiveTrades, Function(bool) onToggle) {
    return Container(
      height: 44.h,
      width: 360.w,
      decoration: BoxDecoration(
        color: const Color(0xff121413),
        borderRadius: BorderRadius.circular(30.r),
      ),
      padding: EdgeInsets.all(5.w),
      child: Stack(
        children: [
          // Animated selection indicator that moves between toggle options
          AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment:
            isActiveTrades ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: 180.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: const Color(0xff3A3A3A),
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
          ),
          // Toggle option buttons row
          Row(
            children: [
              // Active trades toggle option
              _toggleOption(
                  "Active Trades", isActiveTrades, () => onToggle(true)),
              // Closed trades toggle option
              _toggleOption(
                  "Closed Trades", !isActiveTrades, () => onToggle(false)),
            ],
          ),
        ],
      ),
    );
  }

  /// Creates a single toggle option button
  /// @param title - Text to display on the toggle option
  /// @param isSelected - Whether this option is currently selected
  /// @param onTap - Callback function when this option is tapped
  /// @return Widget - A styled toggle option
  Widget _toggleOption(String title, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 33.h,
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              // Green text for selected option, gray for unselected
              color: isSelected
                  ? const Color(0xff1DB954)
                  : const Color(0xffC9CACC),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}