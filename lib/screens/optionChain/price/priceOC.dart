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
  final GlobalKey _firstRowKey = GlobalKey();

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
      'leftVolume': '5K',
      'callPrice': '₹1,620.30',
      'callPercent': '+3.80%',
      'strikePrice': '23,650',
      'putPrice': '₹1,540.20',
      'putPercent': '+5.10%',
      'rightVolume': '150K',
    },
    {
      'leftVolume': '8K',
      'callPrice': '₹1,660.00',
      'callPercent': '+3.20%',
      'strikePrice': '23,600',
      'putPrice': '₹1,500.00',
      'putPercent': '+5.75%',
      'rightVolume': '90K',
    },
    {
      'leftVolume': '12K',
      'callPrice': '₹1,700.50',
      'callPercent': '+2.65%',
      'strikePrice': '23,550',
      'putPrice': '₹1,460.80',
      'putPercent': '+6.30%',
      'rightVolume': '200K',
    },
    {
      'leftVolume': '15K',
      'callPrice': '₹1,740.20',
      'callPercent': '+2.10%',
      'strikePrice': '23,500',
      'putPrice': '₹1,420.40',
      'putPercent': '+6.90%',
      'rightVolume': '80K',
    },
    {
      'leftVolume': '18K',
      'callPrice': '₹1,780.60',
      'callPercent': '+1.55%',
      'strikePrice': '23,450',
      'putPrice': '₹1,380.60',
      'putPercent': '+7.45%',
      'rightVolume': '60K',
    },
    {
      'leftVolume': '20K',
      'callPrice': '₹1,820.00',
      'callPercent': '+1.00%',
      'strikePrice': '23,400',
      'putPrice': '₹1,340.00',
      'putPercent': '+8.00%',
      'rightVolume': '50K',
    },
    {
      'leftVolume': '22K',
      'callPrice': '₹1,860.50',
      'callPercent': '+0.50%',
      'strikePrice': '23,350',
      'putPrice': '₹1,300.50',
      'putPercent': '+8.50%',
      'rightVolume': '45K',
    },
    {
      'leftVolume': '25K',
      'callPrice': '₹1,900.00',
      'callPercent': '+0.10%',
      'strikePrice': '23,300',
      'putPrice': '₹1,260.00',
      'putPercent': '+9.00%',
      'rightVolume': '40K',
    },
    {
      'leftVolume': '28K',
      'callPrice': '₹1,940.60',
      'callPercent': '-0.30%',
      'strikePrice': '23,250',
      'putPrice': '₹1,220.60',
      'putPercent': '+9.50%',
      'rightVolume': '35K',
    },
    {
      'leftVolume': '30K',
      'callPrice': '₹1,980.20',
      'callPercent': '-0.70%',
      'strikePrice': '23,200',
      'putPrice': '₹1,180.20',
      'putPercent': '+10.00%',
      'rightVolume': '30K',
    },
    {
      'leftVolume': '32K',
      'callPrice': '₹2,020.00',
      'callPercent': '-1.10%',
      'strikePrice': '23,150',
      'putPrice': '₹1,140.00',
      'putPercent': '+9.80%',
      'rightVolume': '28K',
    },
    {
      'leftVolume': '35K',
      'callPrice': '₹2,060.50',
      'callPercent': '-1.50%',
      'strikePrice': '23,100',
      'putPrice': '₹1,100.50',
      'putPercent': '+9.60%',
      'rightVolume': '25K',
    },
    {
      'leftVolume': '38K',
      'callPrice': '₹2,100.00',
      'callPercent': '-1.90%',
      'strikePrice': '23,050',
      'putPrice': '₹1,060.00',
      'putPercent': '+9.40%',
      'rightVolume': '22K',
    },
    {
      'leftVolume': '40K',
      'callPrice': '₹2,140.60',
      'callPercent': '-2.30%',
      'strikePrice': '23,000',
      'putPrice': '₹1,020.60',
      'putPercent': '+9.20%',
      'rightVolume': '20K',
    },
    {
      'leftVolume': '42K',
      'callPrice': '₹2,180.20',
      'callPercent': '-2.70%',
      'strikePrice': '22,950',
      'putPrice': '₹980.20',
      'putPercent': '+9.00%',
      'rightVolume': '18K',
    },
    {
      'leftVolume': '45K',
      'callPrice': '₹2,220.00',
      'callPercent': '-3.10%',
      'strikePrice': '22,900',
      'putPrice': '₹940.00',
      'putPercent': '+8.80%',
      'rightVolume': '16K',
    },
    {
      'leftVolume': '48K',
      'callPrice': '₹2,260.50',
      'callPercent': '-3.50%',
      'strikePrice': '22,850',
      'putPrice': '₹900.50',
      'putPercent': '+8.60%',
      'rightVolume': '14K',
    },
    {
      'leftVolume': '50K',
      'callPrice': '₹2,300.00',
      'callPercent': '-3.90%',
      'strikePrice': '22,800',
      'putPrice': '₹860.00',
      'putPercent': '+8.40%',
      'rightVolume': '12K',
    },
    {
      'leftVolume': '52K',
      'callPrice': '₹2,340.60',
      'callPercent': '-4.30%',
      'strikePrice': '22,750',
      'putPrice': '₹81,580.00',
      'putPercent': '+8.20%',
      'rightVolume': '10K',
    },
    {
      'leftVolume': '55K',
      'callPrice': '₹2,380.20',
      'callPercent': '-4.70%',
      'strikePrice': '22,700',
      'putPrice': '₹780.20',
      'putPercent': '+8.00%',
      'rightVolume': '8K',
    },
    {
      'leftVolume': '58K',
      'callPrice': '₹2,420.00',
      'callPercent': '-5.10%',
      'strikePrice': '22,650',
      'putPrice': '₹740.00',
      'putPercent': '+7.80%',
      'rightVolume': '6K',
    },
    {
      'leftVolume': '60K',
      'callPrice': '₹2,460.50',
      'callPercent': '-5.50%',
      'strikePrice': '22,600',
      'putPrice': '₹700.50',
      'putPercent': '+7.60%',
      'rightVolume': '5K',
    },
    {
      'leftVolume': '62K',
      'callPrice': '₹2,500.00',
      'callPercent': '-5.90%',
      'strikePrice': '22,550',
      'putPrice': '₹660.00',
      'putPercent': '+7.40%',
      'rightVolume': '4K',
    },
    {
      'leftVolume': '65K',
      'callPrice': '₹2,540.60',
      'callPercent': '-6.30%',
      'strikePrice': '22,500',
      'putPrice': '₹620.60',
      'putPercent': '+7.20%',
      'rightVolume': '3K',
    },
    {
      'leftVolume': '68K',
      'callPrice': '₹2,580.20',
      'callPercent': '-6.70%',
      'strikePrice': '22,450',
      'putPrice': '₹580.20',
      'putPercent': '+7.00%',
      'rightVolume': '2K',
    },
  ];

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
      'leftVolume': '15K',
      'callPrice': '₹1,540.20',
      'callPercent': '+5.10%',
      'strikePrice': '24,300',
      'putPrice': '₹1,620.30',
      'putPercent': '+3.80%',
      'rightVolume': '40L',
    },
    {
      'leftVolume': '10K',
      'callPrice': '₹1,500.00',
      'callPercent': '+5.75%',
      'strikePrice': '24,350',
      'putPrice': '₹1,660.00',
      'putPercent': '+3.20%',
      'rightVolume': '30L',
    },
    {
      'leftVolume': '8K',
      'callPrice': '₹1,460.80',
      'callPercent': '+6.30%',
      'strikePrice': '24,400',
      'putPrice': '₹1,700.50',
      'putPercent': '+2.65%',
      'rightVolume': '20L',
    },
    {
      'leftVolume': '5K',
      'callPrice': '₹1,420.40',
      'callPercent': '+6.90%',
      'strikePrice': '24,450',
      'putPrice': '₹1,740.20',
      'putPercent': '+2.10%',
      'rightVolume': '15L',
    },
    {
      'leftVolume': '2K',
      'callPrice': '₹1,380.60',
      'callPercent': '+7.45%',
      'strikePrice': '24,500',
      'putPrice': '₹1,780.60',
      'putPercent': '+1.55%',
      'rightVolume': '10L',
    },
    {
      'leftVolume': '1.5K',
      'callPrice': '₹1,340.00',
      'callPercent': '+8.00%',
      'strikePrice': '24,550',
      'putPrice': '₹1,820.00',
      'putPercent': '+1.00%',
      'rightVolume': '8L',
    },
    {
      'leftVolume': '1.2K',
      'callPrice': '₹1,300.50',
      'callPercent': '+8.50%',
      'strikePrice': '24,600',
      'putPrice': '₹1,860.50',
      'putPercent': '+0.50%',
      'rightVolume': '6L',
    },
    {
      'leftVolume': '1K',
      'callPrice': '₹1,260.00',
      'callPercent': '+9.00%',
      'strikePrice': '24,650',
      'putPrice': '₹1,900.00',
      'putPercent': '+0.10%',
      'rightVolume': '5L',
    },
    {
      'leftVolume': '900',
      'callPrice': '₹1,220.60',
      'callPercent': '+9.50%',
      'strikePrice': '24,700',
      'putPrice': '₹1,940.60',
      'putPercent': '-0.30%',
      'rightVolume': '4L',
    },
    {
      'leftVolume': '800',
      'callPrice': '₹1,180.20',
      'callPercent': '+10.00%',
      'strikePrice': "24,750",
      'putPrice': '₹1,980.20',
      'putPercent': '-0.70%',
      'rightVolume': '3L',
    },
    {
      'leftVolume': '700',
      'callPrice': '₹1,140.00',
      'callPercent': '+9.80%',
      'strikePrice': '24,800',
      'putPrice': '₹2,020.00',
      'putPercent': '-1.10%',
      'rightVolume': '2.5L',
    },
    {
      'leftVolume': '600',
      'callPrice': '₹1,100.50',
      'callPercent': '+9.60%',
      'strikePrice': '24,850',
      'putPrice': '₹2,060.50',
      'putPercent': '-1.50%',
      'rightVolume': '2L',
    },
    {
      'leftVolume': '500',
      'callPrice': '₹1,060.00',
      'callPercent': '+9.40%',
      'strikePrice': '24,900',
      'putPrice': '₹2,100.00',
      'putPercent': '-1.90%',
      'rightVolume': '1.8L',
    },
    {
      'leftVolume': '400',
      'callPrice': '₹1,020.60',
      'callPercent': '+9.20%',
      'strikePrice': '24,950',
      'putPrice': '₹2,140.60',
      'putPercent': '-2.30%',
      'rightVolume': '1.5L',
    },
    {
      'leftVolume': '300',
      'callPrice': '₹980.20',
      'callPercent': '+9.00%',
      'strikePrice': '25,000',
      'putPrice': '₹2,180.20',
      'putPercent': '-2.70%',
      'rightVolume': '1.2L',
    },
    {
      'leftVolume': '200',
      'callPrice': '₹940.00',
      'callPercent': '+8.80%',
      'strikePrice': '25,050',
      'putPrice': '₹2,220.00',
      'putPercent': '-3.10%',
      'rightVolume': '1L',
    },
    {
      'leftVolume': '150',
      'callPrice': '₹900.50',
      'callPercent': '+8.60%',
      'strikePrice': '25,100',
      'putPrice': '₹2,260.50',
      'putPercent': '-3.50%',
      'rightVolume': '900K',
    },
    {
      'leftVolume': '100',
      'callPrice': '₹860.00',
      'callPercent': '+8.40%',
      'strikePrice': '25,150',
      'putPrice': '₹2,300.00',
      'putPercent': '-3.90%',
      'rightVolume': '800K',
    },
    {
      'leftVolume': '80',
      'callPrice': '₹820.60',
      'callPercent': '+8.20%',
      'strikePrice': '25,200',
      'putPrice': '₹2,340.60',
      'putPercent': '-4.30%',
      'rightVolume': '700K',
    },
    {
      'leftVolume': '60',
      'callPrice': '₹780.20',
      'callPercent': '+8.00%',
      'strikePrice': '25,250',
      'putPrice': '₹2,380.20',
      'putPercent': '-4.70%',
      'rightVolume': '600K',
    },
    {
      'leftVolume': '50',
      'callPrice': '₹740.00',
      'callPercent': '+7.80%',
      'strikePrice': '25,300',
      'putPrice': '₹2,420.00',
      'putPercent': '-5.10%',
      'rightVolume': '500K',
    },
    {
      'leftVolume': '40',
      'callPrice': '₹700.50',
      'callPercent': '+7.60%',
      'strikePrice': '25,350',
      'putPrice': '₹2,460.50',
      'putPercent': '-5.50%',
      'rightVolume': '400K',
    },
    {
      'leftVolume': '30',
      'callPrice': '₹660.00',
      'callPercent': '+7.40%',
      'strikePrice': '25,400',
      'putPrice': '₹2,500.00',
      'putPercent': '-5.90%',
      'rightVolume': '300K',
    },
    {
      'leftVolume': '20',
      'callPrice': '₹620.60',
      'callPercent': '+7.20%',
      'strikePrice': '25,450',
      'putPrice': '₹2,540.60',
      'putPercent': '-6.30%',
      'rightVolume': '200K',
    },
    {
      'leftVolume': '10',
      'callPrice': '₹580.20',
      'callPercent': '+7.00%',
      'strikePrice': '25,500',
      'putPrice': '₹2,580.20',
      'putPercent': '-6.70%',
      'rightVolume': '100K',
    },
  ];

  double _headerHeight = 0.0;
  double _capsuleHeight = 0.0;
  double _rowHeight = 0.0;
  bool _isCapsuleAtBottom = false;
  bool _isCapsuleAtTop = false;

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

        final headerRenderBox = _headerKey.currentContext?.findRenderObject() as RenderBox?;
        if (headerRenderBox != null) {
          _headerHeight = headerRenderBox.size.height;
        }

        final capsuleRenderBox = _capsuleKey.currentContext?.findRenderObject() as RenderBox?;
        if (capsuleRenderBox != null) {
          _capsuleHeight = capsuleRenderBox.size.height;
        }

        final rowRenderBox = _firstRowKey.currentContext?.findRenderObject() as RenderBox?;
        if (rowRenderBox != null) {
          _rowHeight = rowRenderBox.size.height;
        }

        final totalItems = optionChainDataAbove.length + 1 + optionChainDataBelow.length;
        final capsuleIndex = optionChainDataAbove.length;
        const visibleItemCount = 7;
        final itemsAboveCapsule = (visibleItemCount - 1) ~/ 2;
        final topItemIndex = capsuleIndex - itemsAboveCapsule;
        final offset = topItemIndex * _rowHeight;

        if (offset >= 0) {
          _scrollController.jumpTo(offset);
        }

        _scrollController.addListener(_updateCapsulePosition);
      });
    });
  }

  void _updateCapsulePosition() {
    final screenHeight = MediaQuery.of(context).size.height;
    final scrollOffset = _scrollController.offset;
    final capsuleNaturalTop = _headerHeight + (optionChainDataAbove.length * _rowHeight) - scrollOffset;
    final capsuleBottom = capsuleNaturalTop + _capsuleHeight;

    final bool newIsCapsuleAtTop = capsuleNaturalTop <= _headerHeight;
    final bool newIsCapsuleAtBottom = capsuleNaturalTop >= screenHeight - _capsuleHeight - _headerHeight;

    if (newIsCapsuleAtTop != _isCapsuleAtTop || newIsCapsuleAtBottom != _isCapsuleAtBottom) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _isCapsuleAtTop = newIsCapsuleAtTop;
          _isCapsuleAtBottom = newIsCapsuleAtBottom;
        });
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateCapsulePosition);
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> rowsAbove = optionChainDataAbove.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      return _buildOptionRow(
        data['leftVolume'],
        data['callPrice'],
        data['callPercent'],
        data['strikePrice'],
        data['putPrice'],
        data['putPercent'],
        data['rightVolume'],
        key: index == 0 ? _firstRowKey : null,
      );
    }).toList();

    final List<Widget> rowsBelow = optionChainDataBelow.map((data) => _buildOptionRow(
          data['leftVolume'],
          data['callPrice'],
          data['callPercent'],
          data['strikePrice'],
          data['putPrice'],
          data['putPercent'],
          data['rightVolume'],
        )).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: _buildHeaderRow(key: _headerKey),
              ),
              SliverList(
                delegate: SliverChildListDelegate(rowsAbove),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _HighlightedRowDelegate(
                  child: _buildHighlightedRow(key: _capsuleKey),
                  isAtBottom: _isCapsuleAtBottom,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(rowsBelow),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: MediaQuery.of(context).size.height * 2),
              ),
            ],
          ),
          if (_isCapsuleAtBottom)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildHighlightedRow(),
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
                      "Volume",
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
                      "Volume",
                      style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Divider(color: const Color(0xff2f2f2f)),
      ],
    );
  }

  Widget _buildOptionRow(
      String leftVolume,
      String callPrice,
      String callPercent,
      String strikePrice,
      String putPrice,
      String putPercent,
      String rightVolume,
      {Key? key}) {
    return Container(
      key: key,
      color: const Color(0xff000000),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                leftVolume,
                style: TextStyle(color: Colors.white, fontSize: 11.sp),
              ),
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
                  callPercent,
                  style: TextStyle(
                      color: callPercent.startsWith('-')
                          ? Colors.red
                          : const Color(0xff1DB954),
                      fontSize: 11.sp),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Text(
                    strikePrice,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 25.w,
                        height: 1.h,
                        color: Colors.red,
                      ),
                      SizedBox(width: 4.w),
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
                  putPercent,
                  style: TextStyle(
                      color: putPercent.startsWith('-')
                          ? Colors.red
                          : const Color(0xff1DB954),
                      fontSize: 11.sp),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                rightVolume,
                style: TextStyle(color: Colors.white, fontSize: 11.sp),
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
              color: const Color(0xff1D1D1A),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              "81,580.00 (-0.46%)",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HighlightedRowDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final bool isAtBottom;

  _HighlightedRowDelegate({required this.child, required this.isAtBottom});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Opacity(
      opacity: isAtBottom ? 0.0 : 1.0,
      child: child,
    );
  }

  @override
  double get maxExtent => 45.h;

  @override
  double get minExtent => 45.h;

  @override
  bool shouldRebuild(covariant _HighlightedRowDelegate oldDelegate) {
    return oldDelegate.isAtBottom != isAtBottom;
  }
}