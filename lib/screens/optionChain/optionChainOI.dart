import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class optionChainOI extends StatefulWidget {
  final String symbol;

  const optionChainOI({super.key, required this.symbol});

  @override
  State<optionChainOI> createState() => _optionChainOIState();
}

class _optionChainOIState extends State<optionChainOI>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  final GlobalKey _capsuleKey = GlobalKey();
  final GlobalKey _headerKey = GlobalKey();

  // Data for the option chain above the highlighted row
  final List<Map<String, dynamic>> optionChainDataAbove = [
    {
      "callOI": "10K",
      "callOiPercentage": "+4.55%",
      "callPrice": "₹1,580.60",
      "callPricePercentage": "+4.45%",
      "strikePrice": "23,700",
      "putPrice": "₹80.60",
      "putPricePercentage": "+4.55%",
      "putOI": "12K",
      "putOiPercentage": "+4.55%"
    },
    {
      "callOI": "11K",
      "callOiPercentage": "+4.75%",
      "callPrice": "₹1,580.60",
      "callPricePercentage": "+4.45%",
      "strikePrice": "23,750",
      "putPrice": "₹80.60",
      "putPricePercentage": "+5.20%",
      "putOI": "13K",
      "putOiPercentage": "+5.20%"
    },
    {
      "callOI": "12K",
      "callOiPercentage": "+5.00%",
      "callPrice": "₹1,580.60",
      "callPricePercentage": "+4.45%",
      "strikePrice": "23,800",
      "putPrice": "₹80.60",
      "putPricePercentage": "+6.00%",
      "putOI": "14K",
      "putOiPercentage": "+6.00%"
    },
    {
      "callOI": "13K",
      "callOiPercentage": "+5.25%",
      "callPrice": "₹1,580.60",
      "callPricePercentage": "+4.45%",
      "strikePrice": "23,850",
      "putPrice": "₹80.60",
      "putPricePercentage": "+7.10%",
      "putOI": "15K",
      "putOiPercentage": "+7.10%"
    },
    {
      "callOI": "14K",
      "callOiPercentage": "+5.50%",
      "callPrice": "₹1,580.60",
      "callPricePercentage": "+4.45%",
      "strikePrice": "23,900",
      "putPrice": "₹80.60",
      "putPricePercentage": "+8.25%",
      "putOI": "16K",
      "putOiPercentage": "+8.25%"
    },
    {
      "callOI": "15K",
      "callOiPercentage": "+5.75%",
      "callPrice": "₹1,580.60",
      "callPricePercentage": "+4.45%",
      "strikePrice": "23,950",
      "putPrice": "₹80.60",
      "putPricePercentage": "+9.50%",
      "putOI": "17K",
      "putOiPercentage": "+9.50%"
    },
    {
      "callOI": "16K",
      "callOiPercentage": "+6.00%",
      "callPrice": "₹1,580.60",
      "callPricePercentage": "+4.45%",
      "strikePrice": "24,000",
      "putPrice": "₹80.60",
      "putPricePercentage": "+10.75%",
      "putOI": "18K",
      "putOiPercentage": "+10.75%"
    },
    {
      "callOI": "17K",
      "callOiPercentage": "+6.25%",
      "callPrice": "₹1,580.60",
      "callPricePercentage": "+4.45%",
      "strikePrice": "24,050",
      "putPrice": "₹80.60",
      "putPricePercentage": "+12.00%",
      "putOI": "19K",
      "putOiPercentage": "+12.00%"
    },
    {
      "callOI": "18K",
      "callOiPercentage": "+6.50%",
      "callPrice": "₹1,580.60",
      "callPricePercentage": "+4.45%",
      "strikePrice": "24,100",
      "putPrice": "₹80.60",
      "putPricePercentage": "+13.25%",
      "putOI": "20K",
      "putOiPercentage": "+13.25%"
    },
    {
      "callOI": "19K",
      "callOiPercentage": "+6.75%",
      "callPrice": "₹1,580.60",
      "callPricePercentage": "+4.45%",
      "strikePrice": "24,150",
      "putPrice": "₹80.60",
      "putPricePercentage": "+14.50%",
      "putOI": "21K",
      "putOiPercentage": "+14.50%"
    }
  ];

  // Data for the option chain below the highlighted row
  final List<Map<String, dynamic>> optionChainDataBelow = [
    {
      "callOI": "10K",
      "callOiPercentage": "+4.55%",
      "callPrice": "₹1,580.60",
      "callPricePercentage": "+4.45%",
      "strikePrice": "23,700",
      "putPrice": "₹80.60",
      "putPricePercentage": "+4.55%",
      "putOI": "12K",
      "putOiPercentage": "+4.55%"
    },
    {
      "callOI": "11K",
      "callOiPercentage": "+4.75%",
      "callPrice": "₹1,580.60",
      "callPricePercentage": "+4.45%",
      "strikePrice": "23,750",
      "putPrice": "₹80.60",
      "putPricePercentage": "+5.20%",
      "putOI": "13K",
      "putOiPercentage": "+5.20%"
    },
    {
      "callOI": "12K",
      "callOiPercentage": "+5.00%",
      "callPrice": "₹1,580.60",
      "callPricePercentage": "+4.45%",
      "strikePrice": "23,800",
      "putPrice": "₹80.60",
      "putPricePercentage": "+6.00%",
      "putOI": "14K",
      "putOiPercentage": "+6.00%"
    },
    {
      "callOI": "13K",
      "callOiPercentage": "+5.25%",
      "callPrice": "₹1,580.60",
      "callPricePercentage": "+4.45%",
      "strikePrice": "23,850",
      "putPrice": "₹80.60",
      "putPricePercentage": "+7.10%",
      "putOI": "15K",
      "putOiPercentage": "+7.10%"
    },
    {
      "callOI": "14K",
      "callOiPercentage": "+5.50%",
      "callPrice": "₹1,580.60",
      "callPricePercentage": "+4.45%",
      "strikePrice": "23,900",
      "putPrice": "₹80.60",
      "putPricePercentage": "+8.25%",
      "putOI": "16K",
      "putOiPercentage": "+8.25%"
    },
    {
      "callOI": "15K",
      "callOiPercentage": "+5.75%",
      "callPrice": "₹1,580.60",
      "callPricePercentage": "+4.45%",
      "strikePrice": "23,950",
      "putPrice": "₹80.60",
      "putPricePercentage": "+9.50%",
      "putOI": "17K",
      "putOiPercentage": "+9.50%"
    },
    {
      "callOI": "16K",
      "callOiPercentage": "+6.00%",
      "callPrice": "₹1,580.60",
      "callPricePercentage": "+4.45%",
      "strikePrice": "24,000",
      "putPrice": "₹80.60",
      "putPricePercentage": "+10.75%",
      "putOI": "18K",
      "putOiPercentage": "+10.75%"
    },
    {
      "callOI": "17K",
      "callOiPercentage": "+6.25%",
      "callPrice": "₹1,580.60",
      "callPricePercentage": "+4.45%",
      "strikePrice": "24,050",
      "putPrice": "₹80.60",
      "putPricePercentage": "+12.00%",
      "putOI": "19K",
      "putOiPercentage": "+12.00%"
    },
    {
      "callOI": "18K",
      "callOiPercentage": "+6.50%",
      "callPrice": "₹1,580.60",
      "callPricePercentage": "+4.45%",
      "strikePrice": "24,100",
      "putPrice": "₹80.60",
      "putPricePercentage": "+13.25%",
      "putOI": "20K",
      "putOiPercentage": "+13.25%"
    },
    {
      "callOI": "19K",
      "callOiPercentage": "+6.75%",
      "callPrice": "₹1,580.60",
      "callPricePercentage": "+4.45%",
      "strikePrice": "24,150",
      "putPrice": "₹80.60",
      "putPricePercentage": "+14.50%",
      "putOI": "21K",
      "putOiPercentage": "+14.50%"
    }
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!mounted || !_scrollController.hasClients) return;

        final totalItems =
            optionChainDataAbove.length + 1 + optionChainDataBelow.length;
        final capsuleIndex = optionChainDataAbove.length;
        final visibleItemCount = 7;
        final itemsAboveCapsule = (visibleItemCount - 1) ~/ 2;
        final topItemIndex = capsuleIndex - itemsAboveCapsule;
        final estimatedRowHeight = 50.h;
        final offset = topItemIndex * estimatedRowHeight;

        if (offset >= 0) {
          _scrollController.jumpTo(offset);
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> rowsAbove = optionChainDataAbove
        .map((data) => _buildOptionRow(
              data['callOI'],
              data['callOiPercentage'],
              data['callPrice'],
              data['callPricePercentage'],
              data['strikePrice'],
              data['putPrice'],
              data['putPricePercentage'],
              data['putOI'],
              data['putOiPercentage'],
            ))
        .toList();

    final List<Widget> rowsBelow = optionChainDataBelow
        .map((data) => _buildOptionRow(
              data['callOI'],
              data['callOiPercentage'],
              data['callPrice'],
              data['callPricePercentage'],
              data['strikePrice'],
              data['putPrice'],
              data['putPricePercentage'],
              data['putOI'],
              data['putOiPercentage'],
            ))
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          _buildHeaderRow(key: _headerKey),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo is ScrollUpdateNotification) {
                  setState(() {
                    final rowHeight = 50.h;
                    final capsuleHeight = 30.h;
                    final totalHeightAbove =
                        optionChainDataAbove.length * rowHeight;
                    final screenHeight = MediaQuery.of(context).size.height;

                    final capsuleNaturalOffset = totalHeightAbove -
                        (screenHeight / 2) +
                        (capsuleHeight / 2);
                  });
                }
                return false;
              },
              child: CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(rowsAbove),
                  ),
                  SliverToBoxAdapter(
                    child: _buildHighlightedRow(key: _capsuleKey),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(rowsBelow),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderRow({Key? key}) {
    return Column(
      children: [
        Container(
          key: key,
          color: Colors.black,
          padding: EdgeInsets.only(top: 8.h),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      "Call OI",
                      style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      "Call Price",
                      style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      "Strike Price",
                      style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      "Put Price",
                      style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      "Put OI",
                      style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Divider(
          color: Color(0xff2f2f2f),
        )
      ],
    );
  }

  Widget _buildOptionRow(
      String callOI,
      String callOiPercentage,
      String callPrice,
      String callPricePercentage,
      String strikePrice,
      String putPrice,
      String putPricePercentage,
      String putOI,
      String putOiPercentage) {
    return Container(
      color: const Color(0xff000000),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  callOI,
                  style: TextStyle(color: Colors.white, fontSize: 11.sp),
                ),
                Text(
                  callOiPercentage,
                  style: TextStyle(
                      color: callOiPercentage.startsWith('+')
                          ? const Color(0xff1DB954)
                          : Colors.red,
                      fontSize: 11.sp),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  callPrice,
                  style: TextStyle(color: Colors.white, fontSize: 11.sp),
                ),
                Text(
                  callPricePercentage,
                  style: TextStyle(
                      color: callPricePercentage.startsWith('+')
                          ? const Color(0xff1DB954)
                          : Colors.red,
                      fontSize: 11.sp),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                // alignment: Alignment.center,
                children: [
                  Text(
                    strikePrice,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 25.w,
                        height: 1.h,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Container(
                        width: 25.w,
                        height: 1.h,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  putPrice,
                  style: TextStyle(color: Colors.white, fontSize: 11.sp),
                ),
                Text(
                  putPricePercentage,
                  style: TextStyle(
                      color: putPricePercentage.startsWith('+')
                          ? const Color(0xff1DB954)
                          : Colors.red,
                      fontSize: 11.sp),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  putOI,
                  style: TextStyle(color: Colors.white, fontSize: 11.sp),
                ),
                Text(
                  putOiPercentage,
                  style: TextStyle(
                      color: putPricePercentage.startsWith('+')
                          ? const Color(0xff1DB954)
                          : Colors.red,
                      fontSize: 11.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightedRow({Key? key}) {
    return Container(
      key: key,
      color: Colors.black,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 2.h,
                    color: const Color(0xff1A1A1A),
                  ),
                ),
                SizedBox(width: 120.w),
                Expanded(
                  child: Container(
                    height: 2.h,
                    color: const Color(0xff1A1A1A),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
            decoration: BoxDecoration(
              color: const Color(0xff1D1D1D),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              "81,580.00 (-0.46%)",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
