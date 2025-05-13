import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapphire/screens/home/trades/trades.dart';

// Model class to represent a trade
class Trade {
  final String logoPath;
  final String title;
  final String companyName;
  final String action; // e.g., "BUY"
  final double currentPrice;
  final double priceChange;
  final double percentageChange;
  final double entryPrice;
  final String entryRange;
  final String postedDate;
  final String targetPrice;
  final String holdDuration;
  final double netGain;

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

class TradesActiveScreen extends StatefulWidget {
  final List<Trade>? trades; // Optional parameter

  const TradesActiveScreen({super.key, this.trades});

  @override
  State<TradesActiveScreen> createState() => _TradesActiveScreenState();
}

class _TradesActiveScreenState extends State<TradesActiveScreen>
    with SingleTickerProviderStateMixin {
  late List<Trade> _trades; // Internal list to manage trades

  @override
  void initState() {
    super.initState();
    // Initialize _trades with default data if widget.trades is null
    _trades = widget.trades ?? [
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
      Trade(
        logoPath: 'assets/images/reliance logo.png',
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
            Text(
              "Active Trades (${_trades.length})",
              style: TextStyle(color: const Color(0xffEBEEF5), fontSize: 15.sp),
            ),
            SizedBox(height: 8.h),
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
              Row(
                children: [
                  CircleAvatar(
                    radius: 14.r,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.asset(trade.logoPath),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            trade.title,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xffEBEEF5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 6.w),
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
                      Text(
                        trade.companyName,
                        style: TextStyle(fontSize: 11.sp, color: const Color(0xffC9CACC)),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "₹${trade.currentPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xffEBEEF5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
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

          /// Entry Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Entry Price", style: _labelStyle()),
              Text("₹${trade.entryPrice.toStringAsFixed(2)}", style: _valueStyle()),
            ],
          ),
          SizedBox(height: 8.h),

          /// Entry Range
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

          /// Posted, Target, Hold Duration in a row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Posted", style: _labelStyle()),
                  Text(trade.postedDate, style: _valueStyle()),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Target", style: _labelStyle()),
                  Text(trade.targetPrice, style: _valueStyle()),
                ],
              ),
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

          /// Buttons
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 34.h,
                  child: OutlinedButton(
                    onPressed: () {},
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

  TextStyle _labelStyle() =>
      TextStyle(color: const Color(0xffC9CACC), fontSize: 13.sp);

  TextStyle _valueStyle() =>
      TextStyle(color: const Color(0xffEBEEF5), fontSize: 12.sp);
}