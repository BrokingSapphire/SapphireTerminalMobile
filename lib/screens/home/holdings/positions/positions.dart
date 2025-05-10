import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/screens/home/holdings/holdingsBottomSheet.dart';
import 'package:sapphire/utils/constWidgets.dart';

class positionScreen extends StatefulWidget {
  const positionScreen({super.key});

  @override
  State<positionScreen> createState() => _positionScreenState();
}

class _positionScreenState extends State<positionScreen> {
  // Text controller for search field
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Get filtered and sorted position data
  List<Map<String, dynamic>> _getFilteredPositionData() {
    // Sort the position data alphabetically by title
    List<Map<String, dynamic>> sortedPositionData = List.from(positionData);
    sortedPositionData
        .sort((a, b) => a["title"].toString().compareTo(b["title"].toString()));

    // Filter based on search query
    if (_searchQuery.isEmpty) {
      return sortedPositionData;
    }

    // Return only positions that start with the search query
    return sortedPositionData.where((position) {
      return position["title"]
          .toString()
          .toUpperCase()
          .startsWith(_searchQuery.toUpperCase());
    }).toList();
  }

  List<Map<String, dynamic>> positionData = [
    {
      "title": "ALKYLAMINE",
      "midtitle": "Alklyl Amines Chemical Ltd",
      "subtitle": "1,782 (-2.5%)",
      "trail1": "+3,20,734.12 (+1.5%)",
      "trail2": "BUY",
      "trail3": "INTRADAY",
      "isBuy": true,
      "isOpen": true
    },
    {
      "title": "ALKYLAMINE 1200 CC",
      "midtitle": "24 April 2025",
      "subtitle": "1,782 (-2.5%)",
      "trail1": "-3,23,067.14 (-1.5%)",
      "trail2": "SELL",
      "trail3": "INTRADAY",
      "isBuy": false,
      "isOpen": true
    },
    {
      "title": "ALKYLAMINE FUT",
      "midtitle": "27 Mar 2025",
      "subtitle": "1,782 (-2.5%)",
      "trail1": "+3,20,734.12 (+1.5%)",
      "trail2": "BUY",
      "trail3": "INTRADAY",
      "isBuy": true,
      "isOpen": true
    },
    {
      "title": "ALKYLAMINE 1200 CE",
      "midtitle": "24 Apr 2025",
      "subtitle": "1,782 (-2.5%)",
      "trail1": "-3,23,067.14 (-1.5%)",
      "trail2": "SELL",
      "trail3": "CARRYFORWARD",
      "isBuy": false,
      "isOpen": false
    },
    {
      "title": "ALKYLAMINE",
      "midtitle": "Alklyl Amines Chemical Tech",
      "subtitle": "1,782 (-2.5%)",
      "trail1": "+3,20,734.12 (+1.5%)",
      "trail2": "BUY",
      "trail3": "INTRADAY",
      "isBuy": true,
      "isOpen": false
    },
    {
      "title": "ALKYLAMINE 1200 CC",
      "midtitle": "24 April 2025",
      "subtitle": "1,782 (-2.5%)",
      "trail1": "-3,23,067.14 (-1.5%)",
      "trail2": "SELL",
      "trail3": "INTRADAY",
      "isBuy": false,
      "isOpen": false
    },
    {
      "title": "ALKYLAMINE FUT",
      "midtitle": "27 Mar 2025",
      "subtitle": "1,782 (-2.5%)",
      "trail1": "+3,20,734.12 (+1.5%)",
      "trail2": "BUY",
      "trail3": "INTRADAY",
      "isBuy": true,
      "isOpen": false
    },
    {
      "title": "ALKYLAMINE 1200 CE",
      "midtitle": "24 Apr 2025",
      "subtitle": "1,782 (-2.5%)",
      "trail1": "-3,23,067.14 (-1.5%)",
      "trail2": "SELL",
      "trail3": "CARRYFORWARD",
      "isBuy": false,
      "isOpen": false
    }
  ];

  // Function to get chip colors based on label
  Map<String, Color> _getChipColors(String label) {
    switch (label.toUpperCase()) {
      case 'DELIVERY':
        return {
          'background': Color(0xff1e2e2a),
          'text': Color(0xffa5d6c9),
        };
      case 'INTRADAY':
        return {
          'background': Color(0xff33260d),
          'text': Color(0xffffb74d),
        };
      case 'CARRYFORWARD':
        return {
          'background': Color(0xff1f2537),
          'text': Color(0xff9fa8da),
        };
      case 'MTF':
        return {
          'background': Color(0xff2a1e38),
          'text': Color(0xffce93d8),
        };
      default:
        return {
          'background': Color(0xff1a1a1a),
          'text': Colors.white,
        };
    }
  }

  Widget positionCard(String firstValue, String secondValue, bool isDark) {
    // Determine titles based on values
    String firstTitle = firstValue.contains('-') ? "Total Loss" : "Total Gain";
    String secondTitle =
        secondValue.contains('-') ? "Today's Loss" : "Today's Gain";

    return Container(
      height: 120.h / 2,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  firstTitle,
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: isDark ? Colors.white : Colors.black),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    Text(
                      firstValue,
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: firstValue.contains('-')
                              ? Colors.red
                              : Colors.green),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      "(-22.51%)",
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: isDark ? Colors.white : Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Get filtered position data
    final filteredPositionData = _getFilteredPositionData();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: RefreshIndicator(
        onRefresh: () async {
          // Add your refresh logic here
        },
        color: const Color(0xff1DB954), // Green refresh indicator
        backgroundColor: isDark ? const Color(0xff121413) : Colors.white,
        child: filteredPositionData.isEmpty
            ? SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 64.h,
                          width: 64.w,
                          child: SvgPicture.asset("assets/svgs/doneMark.svg")),
                      SizedBox(height: 20.h),
                      Text("No Open Positions",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black)),
                      SizedBox(height: 10.h),
                      SizedBox(
                          width: 250.w,
                          child: Text(
                              "Your active trades will be listed here. Start Trading Now!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13.sp, color: Colors.grey))),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.r),
                                  color: isDark
                                      ? const Color(0xFF121413)
                                      : const Color(0xFFF4F4F9)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    positionCard(
                                        '-₹15,11,750', "-₹45,096", isDark),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: constWidgets.searchFieldWithInput(context,
                                "Search by name or ticker", "positions", isDark,
                                controller: _searchController,
                                onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            }),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: filteredPositionData.length,
                              itemBuilder: (context, index) {
                                var data = filteredPositionData[index];
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) => holdingsBottomSheet(
                                        stockName: data['title'] ?? '',
                                        stockCode: data['code'] ?? '',
                                        price: data['price'] ?? '',
                                        change: data['change'] ?? '',
                                      ),
                                    );
                                  },
                                  child: positionScreenTiles(
                                      data['title'] ?? '',
                                      data['midtitle'] ?? '',
                                      data['subtitle'] ?? '',
                                      data['trail1'] ?? '',
                                      data['trail2'] ?? '',
                                      data['trail3'] ?? '',
                                      data['isBuy'] ?? false,
                                      isDark,
                                      isOpen: data.containsKey('isOpen')
                                          ? data['isOpen']
                                          : true,
                                      index: index),
                                );
                              })
                        ])
                  ],
                ),
              ),
      ),
    );
  }

  Widget positionScreenTiles(String title, String midtitle, String subtitle,
      String trail1, String trail2, String trail3, bool isBuy, bool isDark,
      {bool isOpen = true, int? index}) {
    // Check if this is one of the last 2 items
    bool shouldFade = index != null && index >= positionData.length - 2;
    // Get chip colors for trail3
    final chipColors = _getChipColors(trail3);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          child: Container(
            child: Row(
              children: [
                Container(
                    height: 70.h,
                    width: 2.w,
                    color: shouldFade
                        ? (trail1.startsWith("-")
                            ? Colors.red.withOpacity(0.5)
                            : Colors.green.withOpacity(0.5))
                        : (trail1.startsWith("-") ? Colors.red : Colors.green)),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: shouldFade
                              ? (isDark
                                  ? Color(0xffebeef5).withOpacity(0.6)
                                  : Colors.black.withOpacity(0.5))
                              : (isDark ? Colors.white : Colors.black)),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      midtitle,
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: shouldFade
                              ? (isDark
                                  ? Color(0xffebeef5).withOpacity(0.6)
                                  : Colors.black.withOpacity(0.5))
                              : (isDark ? Colors.white : Colors.black)),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: isBuy
                                ? (isDark
                                    ? shouldFade
                                        ? Color(0xff143520).withOpacity(.5)
                                        : Color(0xff143520)
                                    : Colors.green.withOpacity(0.2))
                                : (isDark
                                    ? shouldFade
                                        ? Color(0xff3A0C0C).withOpacity(0.5)
                                        : Color(0xff3a0c0c)
                                    : Color(0xffFF0000).withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            trail2,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: shouldFade
                                  ? (isBuy
                                      ? Colors.green.withOpacity(0.5)
                                      : Colors.red.withOpacity(0.5))
                                  : (isBuy ? Colors.green : Colors.red),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: chipColors['background'],
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            trail3,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: shouldFade
                                  ? (isDark
                                      ? Color(0xffebeef5).withOpacity(0.6)
                                      : Colors.black.withOpacity(0.5))
                                  : chipColors['text'],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      trail1,
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: trail1.startsWith("-")
                              ? shouldFade
                                  ? Colors.red.withOpacity(0.6)
                                  : Colors.red
                              : shouldFade
                                  ? Colors.green.withOpacity(0.6)
                                  : Colors.green),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "LTP :",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: shouldFade
                                  ? (isDark
                                      ? Colors.grey.withOpacity(0.6)
                                      : Colors.black.withOpacity(0.5))
                                  : (isDark ? Colors.grey : Colors.black)),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: shouldFade
                                  ? (isDark
                                      ? Colors.white.withOpacity(0.6)
                                      : Colors.black.withOpacity(0.5))
                                  : (isDark ? Colors.white : Colors.black)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Quantity :",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: shouldFade
                                  ? (isDark
                                      ? Colors.grey.withOpacity(0.6)
                                      : Colors.black.withOpacity(0.5))
                                  : (isDark ? Colors.grey : Colors.black)),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "365",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: shouldFade
                                  ? (isDark
                                      ? Colors.white.withOpacity(0.6)
                                      : Colors.black.withOpacity(0.5))
                                  : (isDark ? Colors.white : Colors.black)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: isDark ? Color(0xFF2f2f2f) : const Color(0xffD1D5DB),
        )
      ],
    );
  }
}
