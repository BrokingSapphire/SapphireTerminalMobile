import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/screens/home/trades/trades.dart';

class TradeModel {
  final String symbol;
  final String companyName;
  final String logo;
  final String optionName;
  final String action;
  final String status;
  final String postedDateTime;
  final String closedDateTime;
  final String strategyBuy;
  final String strategySell;
  final double entryBuyPrice;
  final double entrySellPrice;
  final double exitBuyPrice;
  final double exitSellPrice;
  final double stoplossAmount;
  final double targetAmount;
  final double netGain;

  TradeModel({
    required this.symbol,
    required this.companyName,
    required this.logo,
    required this.optionName,
    required this.action,
    required this.status,
    required this.postedDateTime,
    required this.closedDateTime,
    required this.strategyBuy,
    required this.strategySell,
    required this.entryBuyPrice,
    required this.entrySellPrice,
    required this.exitBuyPrice,
    required this.exitSellPrice,
    required this.stoplossAmount,
    required this.targetAmount,
    required this.netGain,
  });

  factory TradeModel.fromJson(Map<String, dynamic> json) {
    return TradeModel(
      symbol: json['symbol'],
      companyName: json['company_name'],
      logo: json['logo'],
      optionName: json['option_name'],
      action: json['action'],
      status: json['status'],
      postedDateTime: json['posted_date_time'],
      closedDateTime: json['closed_date_time'],
      strategyBuy: json['strategy_buy'],
      strategySell: json['strategy_sell'],
      entryBuyPrice: json['entry_buy_price'].toDouble(),
      entrySellPrice: json['entry_sell_price'].toDouble(),
      exitBuyPrice: json['exit_buy_price'].toDouble(),
      exitSellPrice: json['exit_sell_price'].toDouble(),
      stoplossAmount: json['stoploss_amount'].toDouble(),
      targetAmount: json['target_amount'].toDouble(),
      netGain: json['net_gain'].toDouble(),
    );
  }
}

class ClosedOptionListScreen extends StatefulWidget {
  final List<Map<String, dynamic>> trades;
  const ClosedOptionListScreen({super.key, required this.trades});


  @override
  State<ClosedOptionListScreen> createState() => _ClosedOptionListScreenState();
}

class _ClosedOptionListScreenState extends State<ClosedOptionListScreen> {
  // Dummy JSON data defined directly as a List<Map<String, dynamic>>

  // Convert JSON data to TradeModel objects
  late final List<TradeModel> trades = widget.trades.map((json) => TradeModel.fromJson(json)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < trades.length; i++) ...[
              buildTradeCard(trades[i]),
              SizedBox(height: 12.h),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildTradeCard(TradeModel trade) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xff1A1A1A),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with logo and date
          Row(
            children: [
              CircleAvatar(
                radius: 16.r,
                backgroundColor: const Color(0xff2A2A2A),
                child: Text(
                  trade.symbol[0],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trade.optionName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    trade.closedDateTime.split(' | ')[0],
                    style: TextStyle(
                      color: const Color(0xffC9CACC),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "Status",
                    style: TextStyle(
                        color: Color(0xffC9CACC),
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: const Color(0xff35332e),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      trade.status,
                      style: TextStyle(
                          color: const Color(0xffffd761), fontSize: 10.sp),
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 11.h),

          // Posted date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Posted ",
                      style: TextStyle(
                        color: const Color(0xffC9CACC),
                        fontSize: 11.sp,
                      ),
                    ),
                    TextSpan(
                      text: trade.postedDateTime,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Closed ",
                      style: TextStyle(
                        color: const Color(0xffC9CACC),
                        fontSize: 11.sp,
                      ),
                    ),
                    TextSpan(
                      text: trade.closedDateTime,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 11.h),

          // Strategy, Entry, Exit headers
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Strategy",
                  style: TextStyle(
                    color: const Color(0xffC9CACC),
                    fontSize: 15.sp,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "Entry",
                  style: TextStyle(
                    color: const Color(0xffC9CACC),
                    fontSize: 15.sp,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "Exit",
                  style: TextStyle(
                    color: const Color(0xffC9CACC),
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // BUY row
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xff22a06b).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        "BUY",
                        style: TextStyle(
                          color: const Color(0xff22a06b),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      trade.strategyBuy,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  "₹${trade.entryBuyPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "₹${trade.exitBuyPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // SELL row
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        "SELL",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      trade.strategySell,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  "₹${trade.entrySellPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "₹${trade.exitSellPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),
          Divider(height: 1.h, color: const Color(0xff2F2F2F)),
          SizedBox(height: 10.h),

          // Stoploss and Target
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Stoploss amount",
                    style: TextStyle(
                      color: const Color(0xffC9CACC),
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    "₹${trade.stoplossAmount.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Target amount",
                    style: TextStyle(
                      color: const Color(0xffC9CACC),
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    "₹${trade.targetAmount.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Net gain
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xff2A2A2A),
              borderRadius: BorderRadius.circular(6.r),
            ),
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Net gain: ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                  TextSpan(
                    text: "${trade.netGain >= 0 ? '+' : ''}${trade.netGain.toStringAsFixed(2)}%",
                    style: TextStyle(
                      color: trade.netGain >= 0 ? const Color(0xff1db954) : Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 34.h,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xff595959)),
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
              Expanded(
                child: Container(
                  height: 34.h,
                  child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            TradesUtils.placeOrderPopup(context),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xff1db954),
                      side: const BorderSide(color: Color(0xff1db954)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      "Place Order",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Color(0xffEBEEF5),
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

  /// Helper for aligned 3-column rows
  Widget buildTripleColumnRow(String title, String val1, String val2) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(title, style: _labelStyle()),
        ),
        Expanded(
          flex: 3,
          child: Text(val1, style: _valueStyle(), textAlign: TextAlign.start),
        ),
        Expanded(
          flex: 3,
          child: Text(val2, style: _valueStyle(), textAlign: TextAlign.end),
        ),
      ],
    );
  }

  Widget buildDoubleColumnRow(String title, String val1, String val2) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(title, style: _labelStyle()),
        ),
        Expanded(
          flex: 3,
          child: Text(val1, style: _valueStyle(), textAlign: TextAlign.start),
        ),
        Expanded(
          flex: 3,
          child: Text(val2, style: _valueStyle(), textAlign: TextAlign.end),
        ),
      ],
    );
  }

  TextStyle _labelStyle() =>
      TextStyle(color: const Color(0xffC9CACC), fontSize: 12.sp);

  TextStyle _valueStyle() =>
      TextStyle(color: const Color(0xffEBEEF5), fontSize: 12.sp);

  Widget statsText(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(color: const Color(0xffC9CACC), fontSize: 10.sp)),
        Text(value,
            style: TextStyle(
                color: const Color(0xffEBEEF5),
                fontSize: 11.sp,
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}