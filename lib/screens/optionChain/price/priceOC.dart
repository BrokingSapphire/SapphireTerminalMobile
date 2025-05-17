// File: priceOC.dart
// Description: Price view component for the option chain in the Sapphire Trading application.
// This screen displays option chain data with price information in a scrollable format with a highlighted
// current price row in the center of the screen.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling

/// optionChainPrice - Widget that displays option chain price data
/// Shows a scrollable list of option strikes with call and put price information
class optionChainPrice extends StatefulWidget {
  final String symbol; // Stock symbol for which option chain is displayed

  /// Constructor to initialize the option chain price view
  const optionChainPrice({super.key, required this.symbol});

  @override
  State<optionChainPrice> createState() => _optionChainPriceState();
}

/// State class for the optionChainPrice widget
/// Manages the display of option chain price data and maintains scroll position
class _optionChainPriceState extends State<optionChainPrice>
    with SingleTickerProviderStateMixin {
  late TabController _tabController; // Controller for tab navigation
  late ScrollController _scrollController; // Controller for scrolling the option chain
  final GlobalKey _capsuleKey = GlobalKey(); // Key for the highlighted price row
  final GlobalKey _headerKey = GlobalKey(); // Key for the header row

  // Mock data for the option chain above the highlighted row
  // Contains option data for strikes below the current price
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
    // Additional data entries...
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
  // Contains option data for strikes above the current price
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
    // Additional data entries...
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
    // Initialize controllers
    _scrollController = ScrollController();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });

    // Center the highlighted price row on initial load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Use a longer delay to ensure the UI is fully rendered
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!mounted || !_scrollController.hasClients) return;

        // Get the total number of items in the list
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

        // Apply the scroll offset to center the highlighted row
        if (offset >= 0) {
          _scrollController.jumpTo(offset);
        }
      });
    });
  }

  @override
  void dispose() {
    // Clean up resources when widget is disposed
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Generate option rows above the highlighted row from data
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

    // Generate option rows below the highlighted row from data
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
          // Header row with column titles
          _buildHeaderRow(key: _headerKey),
          // Option chain list with highlighted current price
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo is ScrollUpdateNotification) {
                  setState(() {
                    // Calculations for tracking scroll position relative to the capsule
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
                  // Option rows for strikes below current price
                  SliverList(
                    delegate: SliverChildListDelegate(rowsAbove),
                  ),
                  // Highlighted row showing current price
                  SliverToBoxAdapter(
                    child: _buildHighlightedRow(key: _capsuleKey),
                  ),
                  // Option rows for strikes above current price
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

  /// Builds the header row with column titles
  /// @param key - Optional key for the header widget
  /// @return Widget - Header row with column labels
  Widget _buildHeaderRow({Key? key}) {
    return Column(
      children: [
        Container(
          key: key,
          color: Colors.black,
          padding: EdgeInsets.only(top: 8.h),
          child: Row(
            children: [
              // Volume column header (left side)
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      "Volume",
                      style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      textAlign: TextAlign.center,
                    ),
                    // Commented divider code
                    // SizedBox(height: 16.h),
                    // Container(
                    //   width: double.infinity,
                    //   height: 1.h,
                    //   color: Colors.white10,
                    // ),
                  ],
                ),
              ),
              // Call Price column header
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      "Call Price",
                      style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      textAlign: TextAlign.center,
                    ),
                    // Commented divider code
                    // SizedBox(height: 16.h),
                    // Container(
                    //   width: double.infinity,
                    //   height: 1.h,
                    //   color: Colors.white10,
                    // ),
                  ],
                ),
              ),
              // Strike Price column header (center)
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
              // Put Price column header
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      "Put Price",
                      style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      textAlign: TextAlign.center,
                    ),
                    // Commented divider code
                    // SizedBox(height: 8.h),
                    // Container(
                    //   width: double.infinity,
                    //   height: 1.h,
                    //   color: Colors.white10,
                    // ),
                  ],
                ),
              ),
              // Volume column header (right side)
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      "Volume",
                      style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      textAlign: TextAlign.center,
                    ),
                    // Commented divider code
                    // SizedBox(height: 8.h),
                    // Container(
                    //   width: double.infinity,
                    //   height: 1.h,
                    //   color: Colors.white10,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        // Horizontal divider below header
        Divider(
          color: Color(0xff2f2f2f),
        )
      ],
    );
  }

  /// Builds a regular option chain row with all data columns
  /// @param leftVolume - Call option volume
  /// @param callPrice - Call option price
  /// @param callPercent - Call option price change percentage
  /// @param strikePrice - Option strike price
  /// @param putPrice - Put option price
  /// @param putPercent - Put option price change percentage
  /// @param rightVolume - Put option volume
  /// @return Widget - Complete option row with all data cells
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
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          // Call option volume (left column)
          Expanded(
            child: Center(
              child: Text(
                leftVolume,
                style: TextStyle(color: Colors.white, fontSize: 11.sp),
              ),
            ),
          ),
          // Call option price with percentage change
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
                      color: const Color(0xff1DB954), fontSize: 11.sp),
                ),
              ],
            ),
          ),
          // Strike price (center column) with call/put indicator bars
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
                  SizedBox(
                    height: 4.h,
                  ),
                  // Red/Green indicator bars for call/put strength
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
          // Put option price with percentage change
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
                      color: const Color(0xff1DB954), fontSize: 11.sp),
                ),
              ],
            ),
          ),
          // Put option volume (right column)
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

  /// Builds the highlighted row showing current price
  /// This row appears between the strike prices and indicates the current market price
  /// @param key - Optional key for the highlighted row widget
  /// @return Widget - Highlighted current price row
  Widget _buildHighlightedRow({Key? key}) {
    return Container(
      key: key,
      color: Colors.black,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Horizontal line extending across the row
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
          // Capsule containing current price and change percentage
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
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}