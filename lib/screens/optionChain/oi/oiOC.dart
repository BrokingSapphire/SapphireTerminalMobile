// File: oiOC.dart
// Description: Open Interest (OI) view component for the option chain in the Sapphire Trading application.
// This screen displays option chain data with Open Interest information in a scrollable format with 
// a highlighted current price row in the center of the screen.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling

/// optionChainOI - Widget that displays option chain Open Interest data
/// Shows a scrollable list of option strikes with call and put OI information
class optionChainOI extends StatefulWidget {
  final String symbol; // Stock symbol for which option chain is displayed

  /// Constructor to initialize the option chain OI view
  const optionChainOI({super.key, required this.symbol});

  @override
  State<optionChainOI> createState() => _optionChainOIState();
}

/// State class for the optionChainOI widget
/// Manages the display of option chain OI data and maintains scroll position
class _optionChainOIState extends State<optionChainOI>
    with SingleTickerProviderStateMixin {
  late TabController _tabController; // Controller for tab navigation
  late ScrollController _scrollController; // Controller for scrolling the option chain
  final GlobalKey _capsuleKey = GlobalKey(); // Key for the highlighted price row
  final GlobalKey _headerKey = GlobalKey(); // Key for the header row

  // Mock data for the option chain above the highlighted row
  // Contains option data for strikes below the current price
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
    // Additional data entries...
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

  // Mock data for the option chain below the highlighted row
  // Contains option data for strikes above the current price
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
    // Additional data entries...
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
    // Initialize controllers
    _scrollController = ScrollController();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });

    // Center the highlighted price row on initial load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!mounted || !_scrollController.hasClients) return;

        // Calculate positioning parameters to center the highlighted row
        final totalItems =
            optionChainDataAbove.length + 1 + optionChainDataBelow.length;
        final capsuleIndex = optionChainDataAbove.length;
        final visibleItemCount = 7; // Approximate number of visible items
        final itemsAboveCapsule = (visibleItemCount - 1) ~/ 2;
        final topItemIndex = capsuleIndex - itemsAboveCapsule;
        final estimatedRowHeight = 50.h;
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

    // Generate option rows below the highlighted row from data
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

                    // Calculate the capsule's natural position in the scrollable area
                    final capsuleNaturalOffset = totalHeightAbove -
                        (screenHeight / 2) +
                        (capsuleHeight / 2);

                    // Note: This calculation is prepared but not currently used
                    // to adjust the position of the highlighted row during scrolling
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

  /// Builds the header row with column titles for OI view
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
              // Call OI column header
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
                  ],
                ),
              ),
              // Put OI column header
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
        // Horizontal divider below header
        Divider(
          color: Color(0xff2f2f2f),
        )
      ],
    );
  }

  /// Builds a regular option chain row with OI data columns
  /// @param callOI - Call option open interest
  /// @param callOiPercentage - Call OI percentage change
  /// @param callPrice - Call option price
  /// @param callPricePercentage - Call price percentage change
  /// @param strikePrice - Option strike price
  /// @param putPrice - Put option price
  /// @param putPricePercentage - Put price percentage change
  /// @param putOI - Put option open interest
  /// @param putOiPercentage - Put OI percentage change
  /// @return Widget - Complete option row with all data cells
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
          // Call option OI with percentage change
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Call OI value
                Text(
                  callOI,
                  style: TextStyle(color: Colors.white, fontSize: 11.sp),
                ),
                // Call OI percentage change (green for positive, red for negative)
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
          // Call option price with percentage change
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Call price value
                Text(
                  callPrice,
                  style: TextStyle(color: Colors.white, fontSize: 11.sp),
                ),
                // Call price percentage change (green for positive, red for negative)
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
          // Strike price (center column) with call/put indicator bars
          Expanded(
            child: Center(
              child: Column(
                children: [
                  // Strike price value
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
                // Put price value
                Text(
                  putPrice,
                  style: TextStyle(color: Colors.white, fontSize: 11.sp),
                ),
                // Put price percentage change (green for positive, red for negative)
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
          // Put option OI with percentage change
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Put OI value
                Text(
                  putOI,
                  style: TextStyle(color: Colors.white, fontSize: 11.sp),
                ),
                // Put OI percentage change (green for positive, red for negative)
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
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}