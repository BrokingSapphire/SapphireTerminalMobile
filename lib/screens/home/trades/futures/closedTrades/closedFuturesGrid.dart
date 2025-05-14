import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClosedFutureGridScreen extends StatefulWidget {
  const ClosedFutureGridScreen({super.key});

  @override
  State<ClosedFutureGridScreen> createState() => _ClosedFutureGridScreen();
}

class _ClosedFutureGridScreen extends State<ClosedFutureGridScreen> {
  final ScrollController _scrollController = ScrollController();
  String? _sortColumn; // Tracks the currently sorted column
  bool _isAscending = true; // Tracks sort direction

  final List<Map<String, String>> data = [
    {
      "symbol": "DABUR\nMAR FUT",
      "date": "15 Feb 2024 09.15",
      "entry": "₹550.25",
      "exit": "₹560.00",
      "netgain": "₹975",
      "margin": "₹1,25,000.00",
      "postedby": "Alice",
      "status": "Target Achieved"
    },
    {
      "symbol": "RECLTD\nAPR FUT",
      "date": "10 Jan 2024 14.45",
      "entry": "₹480.10",
      "exit": "₹475.50",
      "netgain": "-₹460",
      "margin": "₹95,678.00",
      "postedby": "Bob",
      "status": "Stoploss Hit"
    },
    {
      "symbol": "DLF\nMAR FUT",
      "date": "20 Mar 2024 11.30",
      "entry": "₹510.68",
      "exit": "₹512.00",
      "netgain": "₹132",
      "margin": "₹1,15,678.00",
      "postedby": "Charlie",
      "status": "Target Miss"
    },
    {
      "symbol": "HDFC\nMAY FUT",
      "date": "05 Apr 2024 10.00",
      "entry": "₹600.00",
      "exit": "₹590.00",
      "netgain": "-₹1000",
      "margin": "₹2,50,000.00",
      "postedby": "David",
      "status": "Stoploss Hit"
    },
    {
      "symbol": "TCS\nJUN FUT",
      "date": "25 Feb 2024 13.20",
      "entry": "₹520.50",
      "exit": "₹530.00",
      "netgain": "₹950",
      "margin": "₹1,80,000.00",
      "postedby": "Eve",
      "status": "Target Achieved"
    },
  ];

  final List<Map<String, dynamic>> headers = [
    {"text": "Date & Time", "width": 140.w},
    {"text": "Entry Price", "width": 94.w},
    {"text": "Exit Price", "width": 94.w},
    {"text": "Net Gain", "width": 88.w},
    {"text": "Margin", "width": 94.w},
    {"text": "Posted By", "width": 147.w},
    {"text": "Status", "width": 140.w},
  ];

  // Getter to return sorted data
  List<Map<String, String>> get sortedData {
    List<Map<String, String>> dataList = List.from(data);

    if (_sortColumn != null) {
      dataList.sort((a, b) {
        String aValue = a[_sortColumn] ?? '';
        String bValue = b[_sortColumn] ?? '';

        // Handle numeric fields (remove ₹ and commas, convert to double)
        if (['entry', 'exit', 'netgain', 'margin'].contains(_sortColumn)) {
          double aNum =
              double.tryParse(aValue.replaceAll(RegExp(r'[₹,]'), '')) ?? 0;
          double bNum =
              double.tryParse(bValue.replaceAll(RegExp(r'[₹,]'), '')) ?? 0;
          return _isAscending ? aNum.compareTo(bNum) : bNum.compareTo(aNum);
        }
        // Handle date field
        else if (_sortColumn == 'date') {
          DateTime? aDate = _parseDate(aValue);
          DateTime? bDate = _parseDate(bValue);
          return _isAscending
              ? (aDate ?? DateTime(0)).compareTo(bDate ?? DateTime(0))
              : (bDate ?? DateTime(0)).compareTo(aDate ?? DateTime(0));
        }
        // Handle text fields (postedby, status)
        else {
          return _isAscending
              ? aValue.compareTo(bValue)
              : bValue.compareTo(aValue);
        }
      });
    }

    return dataList;
  }

  // Parse date string to DateTime
  DateTime? _parseDate(String dateStr) {
    try {
      // Assuming format: "DD MMM YYYY HH.MM"
      final parts = dateStr.split(' ');
      final day = int.parse(parts[0]);
      final month = _monthToInt(parts[1]);
      final year = int.parse(parts[2]);
      final timeParts = parts[3].split('.');
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      return DateTime(year, month, day, hour, minute);
    } catch (e) {
      return null;
    }
  }

  // Convert month abbreviation to number
  int _monthToInt(String month) {
    const months = {
      'Jan': 1,
      'Feb': 2,
      'Mar': 3,
      'Apr': 4,
      'May': 5,
      'Jun': 6,
      'Jul': 7,
      'Aug': 8,
      'Sep': 9,
      'Oct': 10,
      'Nov': 11,
      'Dec': 12,
    };
    return months[month] ?? 1;
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
                              children: sortedData.map((row) {
                                return Row(
                                  children: [
                                    _buildCell(row["date"]!, 140.w),
                                    _buildCell(row["entry"]!, 94.w),
                                    _buildCell(row["exit"]!, 94.w),
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
                            children: sortedData.map((row) {
                              var parts = row["symbol"]!.split("\n");
                              return _buildFixedCell(
                                parts[0],
                                subtitle: parts.length > 1 ? parts[1] : "",
                              );
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
    // Map header text to data key for sorting
    final Map<String, String> headerToKey = {
      "Date & Time": "date",
      "Entry Price": "entry",
      "Exit Price": "exit",
      "Net Gain": "netgain",
      "Margin": "margin",
      "Posted By": "postedby",
      "Status": "status",
    };
    String? sortKey = headerToKey[text];

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
          GestureDetector(
            onTap: sortKey != null
                ? () {
                    setState(() {
                      if (_sortColumn == sortKey) {
                        // Toggle sort direction if same column
                        _isAscending = !_isAscending;
                      } else {
                        // Set new sort column and default to ascending
                        _sortColumn = sortKey;
                        _isAscending = true;
                      }
                    });
                  }
                : null,
            child: Icon(
              Icons.swap_vert_rounded,
              color: Color(0xffC9CACC),
              size: 17.sp,
            ),
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
        width: 85.w,
        height: 20.h,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(5.r),
        ),
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
      color: const Color(0xff121413),
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
