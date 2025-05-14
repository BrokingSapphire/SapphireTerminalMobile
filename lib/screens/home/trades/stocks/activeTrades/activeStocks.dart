// File: activeStocks.dart
// Description: Active trades display screen for the Sapphire Trading application.
// This screen shows a list of currently active trades with detailed information and allows users to view trade details or place orders.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/flutter_svg.dart'; // For SVG image rendering
import 'package:sapphire/screens/home/trades/trades.dart'; // Trade utilities and shared components

/// Trade - Model class to represent a trade entity
/// Contains all relevant information about a single trade
class Trade {
  final String logoPath; // Path to company logo asset
  final String title; // Trade ticker/symbol
  final String companyName; // Full company name
  final String action; // Trade action (BUY/SELL)
  final double currentPrice; // Current market price
  final double priceChange; // Price change amount
  final double percentageChange; // Percentage change in price
  final double entryPrice; // Recommended entry price
  final String entryRange; // Recommended price range for entry
  final String postedDate; // When the trade was posted
  final String targetPrice; // Price target for the trade
  final String holdDuration; // Recommended holding period
  final double netGain; // Current net gain/loss percentage

  /// Constructor to initialize all trade properties
  Trade({
    required this.logoPath,
    required this.title,
    required this.companyName,
    required this.action,
    required this.currentPrice,
    required this.priceChange,
    required this.percentageChange,
    required this.entryPrice,
    required this.entryRange,
    required this.postedDate,
    required this.targetPrice,
    required this.holdDuration,
    required this.netGain,
  });
}

/// TradesActiveScreen - Widget that displays a list of active trades
/// Shows trade cards with detailed information and action buttons
class TradesActiveScreen extends StatefulWidget {
  final List<Trade>? trades; // Optional parameter to inject trade data

  const TradesActiveScreen({super.key, this.trades});

  @override
  State<TradesActiveScreen> createState() => _TradesActiveScreenState();
}

/// State class for the TradesActiveScreen widget
/// Manages the display of active trades and their interactions
class _TradesActiveScreenState extends State<TradesActiveScreen>
    with SingleTickerProviderStateMixin {
  late List<Trade> _trades; // Internal list to manage trades data

  @override
  void initState() {
    super.initState();
    // Initialize _trades with default data if widget.trades is null
    _trades = widget.trades ?? [
      // Sample trade data - Reliance Industries
      Trade(
        logoPath: 'assets/images/reliance logo.png',
        title: 'RELIANCE',
        companyName: 'Reliance Industries Ltd.',
        action: 'BUY',
        currentPrice: 580.60,
        priceChange: 0.55,
        percentageChange: 1.33,
        entryPrice: 1200.00,
        entryRange: '₹1,198.00 - 1,273.00',
        postedDate: '15 Feb 2025 | 03:17 pm',
        targetPrice: '1,380.00',
        holdDuration: '1 - 3 months',
        netGain: 6.08,
      ),
      // Sample trade data - Tata Steel
      Trade(
        logoPath: 'assets/images/reliance logo.png', // TODO: Update with correct Tata Steel logo
        title: 'TATASTEEL',
        companyName: 'Tata Steel Ltd.',
        action: 'SELL',
        currentPrice: 1450.25,
        priceChange: -2.10,
        percentageChange: -0.14,
        entryPrice: 1400.00,
        entryRange: '₹1,390.00 - 1,410.00',
        postedDate: '16 Feb 2025 | 10:00 am',
        targetPrice: '1,500.00',
        holdDuration: '2 - 4 months',
        netGain: 3.45,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(right: 16.w, left: 16.h, top: 16.w, bottom: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header showing the count of active trades
            Text(
              "Active Trades (${_trades.length})",
              style: TextStyle(color: const Color(0xffEBEEF5), fontSize: 15.sp),
            ),
            SizedBox(height: 8.h),
            // List of active trade cards
            Expanded(
              child: ListView.builder(
                itemCount: _trades.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: activeTradeCard(_trades[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Creates a card widget displaying detailed information about an active trade
  /// @param trade - The trade object containing all trade details
  /// @return Widget - A styled card with trade information and action buttons
  Widget activeTradeCard(Trade trade) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xff121413),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Row - Logo + Title + Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Company logo, name and action tag
              Row(
                children: [
                  // Company logo
                  CircleAvatar(
                    radius: 14.r,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.asset(trade.logoPath),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // Company name and ticker with action tag
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Stock ticker/symbol
                          Text(
                            trade.title,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xffEBEEF5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          // Action tag (BUY/SELL)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: const Color(0xff1db954).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              trade.action,
                              style: TextStyle(
                                color: const Color(0xff1db954),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      // Full company name
                      Text(
                        trade.companyName,
                        style: TextStyle(fontSize: 11.sp, color: const Color(0xffC9CACC)),
                      ),
                    ],
                  ),
                ],
              ),
              // Current price and change information
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Current price
                  Text(
                    "₹${trade.currentPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xffEBEEF5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  // Price change with indicator
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svgs/icon-park-solid_up-one.svg",
                        width: 12.sp,
                        height: 12.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "${trade.priceChange.toStringAsFixed(2)} (${trade.percentageChange.toStringAsFixed(2)}%)",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(0xff1db954),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),

          /// Entry Price - Recommended entry price for the trade
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Entry Price", style: _labelStyle()),
              Text("₹${trade.entryPrice.toStringAsFixed(2)}", style: _valueStyle()),
            ],
          ),
          SizedBox(height: 8.h),

          /// Entry Range - Recommended price range for entry
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Entry Range", style: _labelStyle()),
              Text(trade.entryRange, style: _valueStyle()),
            ],
          ),
          SizedBox(height: 8.h),
          Divider(
            color: const Color(0xff2F2F2f),
          ),

          /// Posted, Target, Hold Duration in a row - Additional trade details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Posted date information
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Posted", style: _labelStyle()),
                  Text(trade.postedDate, style: _valueStyle()),
                ],
              ),
              // Target price information
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Target", style: _labelStyle()),
                  Text(trade.targetPrice, style: _valueStyle()),
                ],
              ),
              // Recommended holding duration
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hold Duration", style: _labelStyle()),
                  Text(trade.holdDuration, style: _valueStyle()),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),

          /// Net Gain - Current performance indicator
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xff3a3a3a).withOpacity(0.5),
              borderRadius: BorderRadius.circular(6.r),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Net gain: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                  ),
                ),
                Text(
                  "+${trade.netGain.toStringAsFixed(2)}%",
                  style: TextStyle(
                    color: const Color(0xff1db954),
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),

          /// Action Buttons - About Trade and Place Order
          Row(
            children: [
              // About Trade button - Shows detailed trade information
              Expanded(
                child: SizedBox(
                  height: 34.h,
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: Implement trade details view
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xff2F2F2F)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      "About Trade",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: const Color(0xffEBEEF5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Place Order button - Shows order confirmation dialog
              Expanded(
                child: SizedBox(
                  height: 34.h,
                  child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => TradesUtils.placeOrderPopup(context),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xff1db954),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      side: const BorderSide(color: Color(0xff1db954)),
                    ),
                    child: Text(
                      "Place Order",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: const Color(0xffEBEEF5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Helper method for consistent label text style
  /// @return TextStyle - Style for label texts
  TextStyle _labelStyle() =>
      TextStyle(color: const Color(0xffC9CACC), fontSize: 13.sp);

  /// Helper method for consistent value text style
  /// @return TextStyle - Style for value texts
  TextStyle _valueStyle() =>
      TextStyle(color: const Color(0xffEBEEF5), fontSize: 12.sp);
}