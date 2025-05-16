import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/screens/optionChain/price/priceOC.dart';
import 'package:sapphire/screens/optionChain/oi/oiOC.dart';
import 'package:sapphire/screens/optionChain/greeks/greeksOC.dart';
import 'package:sapphire/utils/animatedToggles.dart';

class OptionChainWrapper extends StatefulWidget {
  final String symbol;
  final String stockName;
  final String price;
  final String change;
  // The stock symbol for which option chain is displayed
  final String exchange; // The exchange type (NSE or BSE)

  const OptionChainWrapper(
      {super.key,
      required this.symbol,
      required this.exchange,
      required this.stockName,
      required this.price,
      required this.change});

  @override
  State<OptionChainWrapper> createState() => _OptionChainWrapperState();
}

class _OptionChainWrapperState extends State<OptionChainWrapper> {
  // PageController to manage the tab content
  late PageController _pageController;
  int _selectedIndex = 0; // 0: Price, 1: OI, 2: Greeks
  String expirySelectors = '20 May';
  List<String> displayMonths = ['20 May', '27 May', '20 Jun'];

  // Colors for container styling
  final Color containerBackgroundColor =
      const Color(0xFF1A1A1A); // Darker background
  final Color containerBorderColor = const Color(0xFF333333); // Subtle border
  final Color dropdownBackgroundColor =
      const Color(0xFF121413); // Dropdown menu background
  final Color textColor = const Color(0xFFFFFFFF); // Text color
  final Color iconColor =
      const Color(0xFF999999); // Icon color (slightly dimmed)

  // Helper method to get month name
  String _monthName(int month) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthNames[month - 1];
  }

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leadingWidth: 24.w,
        title: Column(
          children: [
            Row(
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.stockName,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        if (widget.exchange == "NSE")
                          _infoChip("NSE")
                        else
                          _infoChip("BSE"),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.price,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(width: 4.h),
                        Text(
                          widget.change,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: widget.change.contains('+')
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const Spacer(),
                // SizedBox(width: 16.w),
                Center(
                  child: Container(
                    height: 32.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color:
                          containerBackgroundColor, // Custom background color
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(
                          color: containerBorderColor,
                          width: 1), // Subtle border
                    ),
                    child: Theme(
                      // Apply a theme to try to influence scrollbar color
                      data: Theme.of(context).copyWith(
                        scrollbarTheme: ScrollbarThemeData(
                          thumbColor:
                              WidgetStateProperty.all(const Color(0xFF2F2F2F)),
                          trackColor:
                              WidgetStateProperty.all(const Color(0xFF2F2F2F)),
                          thickness: WidgetStateProperty.all(4.0),
                          radius: const Radius.circular(10.0),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: expirySelectors,
                          dropdownColor:
                              dropdownBackgroundColor, // Custom dropdown background
                          style: TextStyle(
                            color: textColor, // Custom text color
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: iconColor, // Custom icon color
                            size: 16.sp,
                          ),
                          // Match the compact look in the image
                          isDense: true,
                          // Show more items with a larger height
                          menuMaxHeight: MediaQuery.of(context).size.height *
                              0.5, // 50% of screen height
                          // Use our fallback list
                          items: displayMonths.map((String month) {
                            return DropdownMenuItem<String>(
                              value: month,
                              child: Text(
                                month,
                                style: TextStyle(
                                  color:
                                      textColor, // Custom text color for items
                                  fontSize: 11.sp,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            print('DEBUG: Dropdown changed to: $newValue');
                            setState(() {
                              expirySelectors = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                // Spacer(),
                SvgPicture.asset(
                  "assets/svgs/search-svgrepo-com (1).svg",
                  color: Colors.white,
                ),
                SizedBox(
                  width: 6.w,
                )
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Tab toggle bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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

Widget _infoChip(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
    decoration: BoxDecoration(
      color: Color(0xff303030),
      borderRadius: BorderRadius.circular(4.r),
    ),
    child: Text(
      text,
      style: TextStyle(
          fontSize: 10.sp, fontWeight: FontWeight.w500, color: Colors.white),
    ),
  );
}
