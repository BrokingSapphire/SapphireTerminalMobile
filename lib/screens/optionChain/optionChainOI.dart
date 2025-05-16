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
      'leftVolume': '1K',
      'callOI': '10K',
      'callPercent': '+4.55%',
      'strikePrice': '23,700',
      'putOI': '12K',
      'putPercent': '+4.55%',
      'rightVolume': '120K',
    },
    {
      'leftVolume': '2K',
      'callOI': '11K',
      'callPercent': '+4.75%',
      'strikePrice': '23,750',
      'putOI': '13K',
      'putPercent': '+5.20%',
      'rightVolume': '110K',
    },
    {
      'leftVolume': '3K',
      'callOI': '12K',
      'callPercent': '+5.00%',
      'strikePrice': '23,800',
      'putOI': '14K',
      'putPercent': '+6.00%',
      'rightVolume': '100K',
    },
    {
      'leftVolume': '4K',
      'callOI': '13K',
      'callPercent': '+5.25%',
      'strikePrice': '23,850',
      'putOI': '15K',
      'putPercent': '+7.10%',
      'rightVolume': '90K',
    },
    {
      'leftVolume': '5K',
      'callOI': '14K',
      'callPercent': '+5.50%',
      'strikePrice': '23,900',
      'putOI': '16K',
      'putPercent': '+8.25%',
      'rightVolume': '85K',
    },
    {
      'leftVolume': '6K',
      'callOI': '15K',
      'callPercent': '+5.75%',
      'strikePrice': '23,950',
      'putOI': '17K',
      'putPercent': '+9.50%',
      'rightVolume': '80K',
    },
    {
      'leftVolume': '7K',
      'callOI': '16K',
      'callPercent': '+6.00%',
      'strikePrice': '24,000',
      'putOI': '18K',
      'putPercent': '+10.75%',
      'rightVolume': '75K',
    },
    {
      'leftVolume': '8K',
      'callOI': '17K',
      'callPercent': '+6.25%',
      'strikePrice': '24,050',
      'putOI': '19K',
      'putPercent': '+12.00%',
      'rightVolume': '70K',
    },
    {
      'leftVolume': '9K',
      'callOI': '18K',
      'callPercent': '+6.50%',
      'strikePrice': '24,100',
      'putOI': '20K',
      'putPercent': '+13.25%',
      'rightVolume': '65K',
    },
    {
      'leftVolume': '10K',
      'callOI': '19K',
      'callPercent': '+6.75%',
      'strikePrice': '24,150',
      'putOI': '21K',
      'putPercent': '+14.50%',
      'rightVolume': '60K',
    },
  ];

  // Data for the option chain below the highlighted row
  final List<Map<String, dynamic>> optionChainDataBelow = [
    {
      'leftVolume': '11K',
      'callOI': '20K',
      'callPercent': '+7.00%',
      'strikePrice': '24,200',
      'putOI': '22K',
      'putPercent': '+15.75%',
      'rightVolume': '55K',
    },
    {
      'leftVolume': '12K',
      'callOI': '21K',
      'callPercent': '+7.25%',
      'strikePrice': '24,250',
      'putOI': '23K',
      'putPercent': '+17.00%',
      'rightVolume': '50K',
    },
    {
      'leftVolume': '13K',
      'callOI': '22K',
      'callPercent': '+7.50%',
      'strikePrice': '24,300',
      'putOI': '24K',
      'putPercent': '+18.25%',
      'rightVolume': '45K',
    },
    {
      'leftVolume': '14K',
      'callOI': '23K',
      'callPercent': '+7.75%',
      'strikePrice': '24,350',
      'putOI': '25K',
      'putPercent': '+19.50%',
      'rightVolume': '40K',
    },
    {
      'leftVolume': '15K',
      'callOI': '24K',
      'callPercent': '+8.00%',
      'strikePrice': '24,400',
      'putOI': '26K',
      'putPercent': '+20.75%',
      'rightVolume': '35K',
    },
    {
      'leftVolume': '16K',
      'callOI': '25K',
      'callPercent': '+8.25%',
      'strikePrice': '24,450',
      'putOI': '27K',
      'putPercent': '+22.00%',
      'rightVolume': '30K',
    },
    {
      'leftVolume': '17K',
      'callOI': '26K',
      'callPercent': '+8.50%',
      'strikePrice': '24,500',
      'putOI': '28K',
      'putPercent': '+23.25%',
      'rightVolume': '25K',
    },
    {
      'leftVolume': '18K',
      'callOI': '27K',
      'callPercent': '+8.75%',
      'strikePrice': '24,550',
      'putOI': '29K',
      'putPercent': '+24.50%',
      'rightVolume': '20K',
    },
    {
      'leftVolume': '19K',
      'callOI': '28K',
      'callPercent': '+9.00%',
      'strikePrice': '24,600',
      'putOI': '30K',
      'putPercent': '+25.75%',
      'rightVolume': '15K',
    },
    {
      'leftVolume': '20K',
      'callOI': '29K',
      'callPercent': '+9.25%',
      'strikePrice': '24,650',
      'putOI': '31K',
      'putPercent': '+27.00%',
      'rightVolume': '10K',
    },
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
              data['leftVolume'],
              data['callOI'],
              data['callPercent'],
              data['strikePrice'],
              data['putOI'],
              data['putPercent'],
              data['rightVolume'],
            ))
        .toList();

    final List<Widget> rowsBelow = optionChainDataBelow
        .map((data) => _buildOptionRow(
              data['leftVolume'],
              data['callOI'],
              data['callPercent'],
              data['strikePrice'],
              data['putOI'],
              data['putPercent'],
              data['rightVolume'],
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
    return Container(
      key: key,
      color: Colors.black,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(
                  "Volume",
                  style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4.h),
                Container(
                  width: double.infinity,
                  height: 1.h,
                  color: Colors.white10,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(
                  "Call OI",
                  style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4.h),
                Container(
                  width: double.infinity,
                  height: 1.h,
                  color: Colors.white10,
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
                  style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4.h),
                Container(
                  width: double.infinity,
                  height: 1.h,
                  color: Colors.white10,
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
                  style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4.h),
                Container(
                  width: double.infinity,
                  height: 1.h,
                  color: Colors.white10,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(
                  "Volume",
                  style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4.h),
                Container(
                  width: double.infinity,
                  height: 1.h,
                  color: Colors.white10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionRow(String leftVolume, String callOI, String callPercent,
      String strikePrice, String putOI, String putPercent, String rightVolume) {
    return Container(
      color: const Color(0xff000000),
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                leftVolume,
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  callOI,
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
                Text(
                  callPercent,
                  style: TextStyle(
                      color: callPercent.startsWith('+')
                          ? const Color(0xff1DB954)
                          : Colors.red,
                      fontSize: 14.sp),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 40.w,
                      height: 1.h,
                      color: Colors.red,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 40.w,
                      height: 1.h,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    strikePrice,
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
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
                  putOI,
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
                Text(
                  putPercent,
                  style: TextStyle(
                      color: putPercent.startsWith('+')
                          ? const Color(0xff1DB954)
                          : Colors.red,
                      fontSize: 14.sp),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                rightVolume,
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
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
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
