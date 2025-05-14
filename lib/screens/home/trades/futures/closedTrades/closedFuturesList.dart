import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/screens/home/trades/trades.dart';

class TradeModel {
  final String symbol;
  final String companyName;
  final String logo;
  final String action;
  final String status;
  final double entryPrice;
  final String entryDateTime;
  final double exitPrice;
  final String exitDateTime;
  final double netGain;

  TradeModel({
    required this.symbol,
    required this.companyName,
    required this.logo,
    required this.action,
    required this.status,
    required this.entryPrice,
    required this.entryDateTime,
    required this.exitPrice,
    required this.exitDateTime,
    required this.netGain,
  });

  factory TradeModel.fromJson(Map<String, dynamic> json) {
    return TradeModel(
      symbol: json['symbol'],
      companyName: json['company_name'],
      logo: json['logo'],
      action: json['action'],
      status: json['status'],
      entryPrice: json['entry_price'].toDouble(),
      entryDateTime: json['entry_date_time'],
      exitPrice: json['exit_price'].toDouble(),
      exitDateTime: json['exit_date_time'],
      netGain: json['net_gain'].toDouble(),
    );
  }
}

class ClosedFutureListScreen extends StatefulWidget {
  final List<Map<String, dynamic>> trades;
  const ClosedFutureListScreen({super.key, required this.trades});

  @override
  State<ClosedFutureListScreen> createState() => _ClosedFutureListScreenState();
}

class _ClosedFutureListScreenState extends State<ClosedFutureListScreen> {
  // Convert JSON data to TradeModel objects
  late final List<TradeModel> tradesList =
      widget.trades.map((json) => TradeModel.fromJson(json)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < tradesList.length; i++) ...[
              buildTradeCard(tradesList[i]),
              SizedBox(height: 12.h),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildTradeCard(TradeModel trade) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
      decoration: BoxDecoration(
        color: const Color(0xff121413),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Row - Logo + Title + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 14.r,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.asset(trade.logo),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            trade.symbol,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xffEBEEF5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: const Color(0xff143520),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              trade.action,
                              style: TextStyle(
                                color: const Color(0xff22a06b),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        trade.companyName,
                        style: TextStyle(
                            fontSize: 11.sp, color: const Color(0xffC9CACC)),
                      ),
                    ],
                  ),
                ],
              ),
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
          SizedBox(height: 16.h),

          /// Entry Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Entry", style: _labelStyle()),
              Text("₹${trade.entryPrice.toStringAsFixed(2)}",
                  style: _valueStyle()),
              Text(trade.entryDateTime, style: _valueStyle()),
            ],
          ),
          SizedBox(height: 8.h),

          /// Exit Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Exit", style: _labelStyle()),
              Text("₹${trade.exitPrice.toStringAsFixed(2)}", style: _valueStyle()),
              Text(trade.exitDateTime, style: _valueStyle()),
            ],
          ),
          SizedBox(height: 12.h),

          /// Net Gain
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
                  "Net gain:",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                  ),
                ),
                Text(
                  "${trade.netGain >= 0 ? '+' : ''}${trade.netGain.toStringAsFixed(2)}%",
                  style: TextStyle(
                    color: trade.netGain >= 0
                        ? const Color(0xff1db954)
                        : Colors.red,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 6.h),

          /// Buttons
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xff2F2F2F)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r)),
              ),
              child: Text(
                "About Trade",
                style: TextStyle(
                    color: const Color(0xffEBEEF5),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),

          SizedBox(width: 12.w),
        ],
      ),
    );
  }

  TextStyle _labelStyle() =>
      TextStyle(color: const Color(0xffC9CACC), fontSize: 13.sp);

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