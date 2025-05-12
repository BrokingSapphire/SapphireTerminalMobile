import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class closedGridScreen extends StatefulWidget {
  final List<Map<String, String>>? filteredStocks;

  const closedGridScreen({super.key, this.filteredStocks});

  @override
  State<closedGridScreen> createState() => _closedGridScreenState();
}

class _closedGridScreenState extends State<closedGridScreen> {
  final ScrollController _scrollController = ScrollController();

  // Default data if no filtered stocks are provided
  final List<Map<String, String>> defaultData = [
    {
      "symbol": "DABUR\nMAR FUT",
      "entry": "₹510.68",
      "exit": "₹512.00",
      "quantity": "100",
      "duration": "1000",
      "netgain": "₹189",
      "margin": "₹1,15,678.00",
      "postedby": "User1",
      "status": "Target Miss"
    },
    {
      "symbol": "DABUR\nMAR FUT",
      "entry": "₹510.68",
      "exit": "₹510.68",
      "quantity": "60",
      "duration": "2778",
      "netgain": "₹189",
      "margin": "₹1,15,678.00",
      "postedby": "{postedby.name}",
      "status": "Stoploss Hit"
    },
    {
      "symbol": "DLF\nMAR FUT",
      "entry": "₹510.68",
      "exit": "₹510.68",
      "quantity": "270",
      "duration": "1000",
      "netgain": "₹189",
      "margin": "₹1,15,678.00",
      "postedby": "{postedby.name}",
      "status": "Stoploss Hit"
    },
    {
      "symbol": "DABUR\nMAR FUT",
      "entry": "₹510.68",
      "exit": "₹510.68",
      "quantity": "90",
      "duration": "5000",
      "netgain": "₹189",
      "margin": "₹1,15,678.00",
      "postedby": "{postedby.name}",
      "status": "Target Achieved"
    },
    {
      "symbol": "RECLTD\nMAR FUT",
      "entry": "₹520.50",
      "exit": "₹530.00",
      "quantity": "200",
      "duration": "200",
      "netgain": "₹500",
      "margin": "₹2,00,000.00",
      "postedby": "User2",
      "status": "Target Achieved"
    },
  ];

  final List<Map<String, dynamic>> headers = [
    {"text": "Entry Price", "width": 94.w},
    {"text": "Exit Price", "width": 94.w},
    {"text": "Quantity", "width": 94.w},
    {"text": "Duration", "width": 94.w},
    {"text": "Net Gain", "width": 88.w},
    {"text": "Margin", "width": 94.w},
    {"text": "Posted By", "width": 147.w},
    {"text": "Status", "width": 140.w},
  ];

  // Get the data to display - either filtered stocks or default data
  List<Map<String, String>> get data {
    if (widget.filteredStocks != null && widget.filteredStocks!.isNotEmpty) {
      // Map the filtered stocks to the format expected by the grid
      return widget.filteredStocks!.map((stock) {
        return {
          "symbol": "${stock['symbol']}\nMAR FUT",
          "entry": "₹510.68",
          "exit": "₹512.00",
          "quantity": "100",
          "duration": "1000",
          "netgain": "₹189",
          "margin": "₹1,15,678.00",
          "postedby": "User1",
          "status": "Target Miss"
        };
      }).toList();
    }
    return defaultData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 100.w),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 30.w),
                            child: Row(
                              children: headers
                                  .map((h) =>
                                      _buildHeader(h["text"], h["width"]))
                                  .toList(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 30.w),
                            child: Column(
                              children: data.map((row) {
                                return Row(
                                  children: [
                                    _buildCell(row["entry"]!, 94.w),
                                    _buildCell(row["exit"]!, 94.w),
                                    _buildCell(row["quantity"]!, 94.w),
                                    _buildCell(row["duration"]!, 94.w),
                                    _buildCell(row["netgain"]!, 88.w),
                                    _buildCell(row["margin"]!, 94.w),
                                    _buildCell(row["postedby"]!, 147.w),
                                    _buildStatusCell(row["status"]!),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      color: Colors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFixedCell("SYMBOL", isHeader: true),
                          Column(
                            children: data.map((row) {
                              var parts = row["symbol"]!.split("\n");
                              return _buildFixedCell(parts[0],
                                  subtitle: parts.length > 1 ? parts[1] : "");
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String text, double width) {
    return Container(
      width: width,
      height: 40.h,
      color: Colors.black,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text,
              style: TextStyle(color: Color(0xffC9CACC), fontSize: 13.sp)),
          SizedBox(width: 5.w),
          // Icon(Icons.swap_vert_rounded, color: Color(0xffC9CACC), size: 17.sp),
          SvgPicture.asset(
            "assets/svgs/arrow-up-down-svgrepo-com 1.svg",
            color: Color(0xffC9CACC),
          ),
        ],
      ),
    );
  }

  Widget _buildCell(String text, double width) {
    return Container(
      width: width,
      height: 50.h,
      color: Colors.black,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(color: Color(0xffEBEEF5), fontSize: 13.sp),
      ),
    );
  }

  Widget _buildStatusCell(String text) {
    Color bg, fg;
    switch (text) {
      case "Target Miss":
        bg = Color(0xff35332e);
        fg = Color(0xffffd761);
        break;
      case "Target Achieved":
        bg = Color(0xFF072712);
        fg = Color(0xff22a06b);
        break;
      case "Stoploss Hit":
        bg = Color(0xff322121);
        fg = Color(0xffe53935);
        break;
      default:
        bg = Color(0xff35332e);
        fg = Color(0xffffd761);
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
        // width: 85.w,
        height: 20.h,
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(5.r)),
        alignment: Alignment.center,
        child: Text(text, style: TextStyle(color: fg, fontSize: 10.sp)),
      ),
    );
  }

  Widget _buildFixedCell(String title,
      {String subtitle = "", bool isHeader = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      width: 118.w,
      height: 50.h,
      color: Color(0xff121413),
      alignment: Alignment.centerLeft,
      child: isHeader
          ? Text(title,
              style: TextStyle(
                  color: Color(0xffC9CACC),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: TextStyle(
                        color: Color(0xffEBEEF5),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600)),
                Text(subtitle,
                    style:
                        TextStyle(color: Color(0xffEBEEF5), fontSize: 10.sp)),
              ],
            ),
    );
  }
}
