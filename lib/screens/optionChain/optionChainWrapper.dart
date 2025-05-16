import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/screens/optionChain/optionChainPrice.dart';
import 'package:sapphire/screens/optionChain/optionChainOI.dart';
import 'package:sapphire/screens/optionChain/optionChainGreeks.dart';
import 'package:sapphire/utils/animatedToggles.dart';

class OptionChainWrapper extends StatefulWidget {
  final String symbol; // The stock symbol for which option chain is displayed
  final String exchange; // The exchange type (NSE or BSE)

  const OptionChainWrapper(
      {super.key, required this.symbol, required this.exchange});

  @override
  State<OptionChainWrapper> createState() => _OptionChainWrapperState();
}

class _OptionChainWrapperState extends State<OptionChainWrapper> {
  // PageController to manage the tab content
  late PageController _pageController;
  int _selectedIndex = 0; // 0: Price, 1: OI, 2: Greeks

  // Options for the toggle
  final List<String> _options = ['Price', 'OI', 'Greeks'];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.symbol,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.exchange,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            // const Spacer(),
            SizedBox(width: 16.w),
            Row(
              children: [
                Text(
                  '20 May',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down,
                    color: Colors.white, size: 18.sp),
              ],
            ),
            Spacer(),
            SvgPicture.asset("assets/svgs/search.svg"),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Tab toggle bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: AnimatedOptionToggle(
              options: _options,
              selectedIndex: _selectedIndex,
              onToggle: (index) {
                setState(() {
                  _selectedIndex = index;
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
              selectedTextColor: const Color(0xff1DB954),
              unselectedTextColor: const Color(0xffC9CACC),
              backgroundColor: const Color(0xff121413),
              selectedBackgroundColor: const Color(0xff2f2f2f),
              height: 40,
              borderRadius: 30,
            ),
          ),
          // Page view for tab content
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                optionChainPrice(symbol: widget.symbol),
                optionChainOI(symbol: widget.symbol),
                optionChainGreek(symbol: widget.symbol),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // No longer needed as we're using AnimatedOptionToggle
}
