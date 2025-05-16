import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class optionChainPrice extends StatefulWidget {
  final String symbol;

  const optionChainPrice({super.key, required this.symbol});

  @override
  State<optionChainPrice> createState() => _optionChainPriceState();
}

class _optionChainPriceState extends State<optionChainPrice>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  final GlobalKey _capsuleKey = GlobalKey();
  final GlobalKey _headerKey = GlobalKey();

  // Mock data for the option chain above the highlighted row
  final List<Map<String, dynamic>> optionChainDataAbove = [
    {
      'leftVolume': '1K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '23,700',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '120K',
    },
    {
      'leftVolume': '2K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '23,750',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '110K',
    },
    {
      'leftVolume': '3K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '23,800',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '100K',
    },
    {
      'leftVolume': '4K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '23,850',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '90K',
    },
    {
      'leftVolume': '1K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '23,700',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '120K',
    },
    {
      'leftVolume': '2K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '23,750',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '110K',
    },
    {
      'leftVolume': '3K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '23,800',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '100K',
    },
    {
      'leftVolume': '4K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '23,850',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '90K',
    },
    {
      'leftVolume': '5K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '23,900',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '85K',
    },
    {
      'leftVolume': '7K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '23,950',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '80K',
    },
    {
      'leftVolume': '10K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '24,000',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '75K',
    },
    {
      'leftVolume': '12K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '24,050',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '70K',
    },
    {
      'leftVolume': '15K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '24,100',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '65K',
    },
    {
      'leftVolume': '18K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '24,150',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '60K',
    },
  ];

  // Mock data for the option chain below the highlighted row
  final List<Map<String, dynamic>> optionChainDataBelow = [
    {
      'leftVolume': '20K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '24,250',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '55L',
    },
    {
      'leftVolume': '18K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '24,300',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '50L',
    },
    {
      'leftVolume': '15K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '24,350',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '45L',
    },
    {
      'leftVolume': '20K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '24,250',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '55L',
    },
    {
      'leftVolume': '18K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '24,300',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '50L',
    },
    {
      'leftVolume': '15K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '24,350',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '45L',
    },
    {
      'leftVolume': '12K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '24,400',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '40L',
    },
    {
      'leftVolume': '10K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '24,450',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '35L',
    },
    {
      'leftVolume': '8K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '24,500',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '30L',
    },
    {
      'leftVolume': '6K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '24,550',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '25L',
    },
    {
      'leftVolume': '5K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '24,600',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '20L',
    },
    {
      'leftVolume': '3K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '24,650',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '15L',
    },
    {
      'leftVolume': '2K',
      'callPrice': '₹1,580.60',
      'callPercent': '+4.55%',
      'strikePrice': '24,700',
      'putPrice': '₹1,580.60',
      'putPercent': '+4.55%',
      'rightVolume': '10L',
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

    // Use a simpler approach to center the capsule
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Use a longer delay to ensure the UI is fully rendered
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!mounted || !_scrollController.hasClients) return;

        // Get the total number of items
        final totalItems =
            optionChainDataAbove.length + 1 + optionChainDataBelow.length;

        // Calculate the index of the capsule (highlighted row)
        final capsuleIndex = optionChainDataAbove.length;

        // Calculate how many items should be visible on screen
        final visibleItemCount =
            7; // Adjust this number based on your screen size

        // Calculate how many items should be above the capsule to center it
        final itemsAboveCapsule = (visibleItemCount - 1) ~/ 2;

        // Calculate which item should be at the top of the screen
        final topItemIndex = capsuleIndex - itemsAboveCapsule;

        // Estimate the height of each row (this is an approximation)
        final estimatedRowHeight = 50.h;

        // Calculate the scroll offset
        final offset = topItemIndex * estimatedRowHeight;

        // Apply the scroll offset
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
              data['callPrice'],
              data['callPercent'],
              data['strikePrice'],
              data['putPrice'],
              data['putPercent'],
              data['rightVolume'],
            ))
        .toList();

    final List<Widget> rowsBelow = optionChainDataBelow
        .map((data) => _buildOptionRow(
              data['leftVolume'],
              data['callPrice'],
              data['callPercent'],
              data['strikePrice'],
              data['putPrice'],
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

                    // Calculate the capsule's natural position
                    final capsuleNaturalOffset = totalHeightAbove -
                        (screenHeight / 2) +
                        (capsuleHeight / 2);

                    // Capsule scrolls normally with the list
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
                  "Call Price",
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
                  "Put Price",
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

  Widget _buildOptionRow(
      String leftVolume,
      String callPrice,
      String callPercent,
      String strikePrice,
      String putPrice,
      String putPercent,
      String rightVolume) {
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
                  callPrice,
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
                Text(
                  callPercent,
                  style: TextStyle(
                      color: const Color(0xff1DB954), fontSize: 14.sp),
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
                  putPrice,
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
                Text(
                  putPercent,
                  style: TextStyle(
                      color: const Color(0xff1DB954), fontSize: 14.sp),
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
