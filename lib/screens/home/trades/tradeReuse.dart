import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/screens/home/trades/commodity/activeCommodity.dart';
import 'package:sapphire/screens/home/trades/commodity/closedCommodity.dart';
import 'package:sapphire/screens/home/trades/options/activeOptions.dart';
import 'package:sapphire/screens/home/trades/options/closedOptions.dart';
import 'package:sapphire/screens/home/trades/stocks/activeStocks.dart';
import 'package:sapphire/screens/home/trades/stocks/closedStocks.dart';
import 'package:sapphire/screens/home/trades/futures/activeFutures.dart';
import 'package:sapphire/screens/home/trades/futures/closedFutures.dart';

class TradesTabContent extends StatefulWidget {
  final String tabType;
  const TradesTabContent({super.key, required this.tabType});

  @override
  State<TradesTabContent> createState() => _TradesTabContentState();
}

class _TradesTabContentState extends State<TradesTabContent> {
  bool isEmpty = false;
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    print('TradesTabContent: tabType=${widget.tabType}, isEmpty=$isEmpty, isActive=$isActive');
    if (isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 150.h,
                width: 150.w,
                child: Image.asset("assets/emptyPng/trades.png")),
            Text(
              "No Trades Idea Yet",
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
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
      return Column(
        children: [
          SizedBox(height: 12.h),
          _toggleButton(isActive, (value) {
            setState(() {
              isActive = value;
            });
          }),
          
          Flexible(
            child: _buildContent(widget.tabType),
          ),
        ],
      );
    }
  }

  /// Conditionally loads the screen based on tabType and toggle state
  Widget _buildContent(String type) {
    print('Building content for type: $type, isActive: $isActive');
    switch (type.toLowerCase()) {
      case "futures":
        return isActive
            ? const TradesFutureActiveScreen()
            : const TradesFutureClosedScreen();
      case "stocks":
        return isActive
            ? const TradesActiveScreen()
            : const tradesClosedScreen();
      case "options":
        return isActive
            ? const TradesOptionActiveScreen()
            : const TradesOptionClosedScreen();
      case "commodity":
        return isActive
            ? const TradesComActiveScreen()
            : const TradesComClosedScreen();
      default:
        return Center(
          child: Text(
            "Coming Soon!",
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
        );
    }
  }

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
          Row(
            children: [
              _toggleOption(
                  "Active Trades", isActiveTrades, () => onToggle(true)),
              _toggleOption(
                  "Closed Trades", !isActiveTrades, () => onToggle(false)),
            ],
          ),
        ],
      ),
    );
  }

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
