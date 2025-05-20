// File: optionChain.dart
// Description: Option chain display wrapper for the Sapphire Trading application.
// This screen provides a tabbed interface to view option chain data with different metrics (Price, OI, Greeks)
// and allows users to select different expiry dates.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/svg.dart'; // For SVG image rendering
import 'package:sapphire/screens/optionChain/price/priceOC.dart'; // Price view for option chain
import 'package:sapphire/screens/optionChain/oi/oiOC.dart'; // Open Interest view for option chain
import 'package:sapphire/screens/optionChain/greeks/greeksOC.dart'; // Greeks view for option chain
import 'package:sapphire/utils/animatedToggles.dart'; // Custom animated toggle component

/// OptionChainWrapper - Widget that displays option chain data with multiple views
/// Shows option chain details with tabs for Price, Open Interest, and Greeks metrics
class OptionChainWrapper extends StatefulWidget {
  final String symbol; // The stock symbol for which option chain is displayed
  final String stockName; // Full name of the stock
  final String price; // Current price of the stock
  final String change; // Price change (positive or negative)
  final String exchange; // The exchange type (NSE or BSE)

  /// Constructor to initialize all option chain wrapper properties
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

/// State class for the OptionChainWrapper widget
/// Manages the display of option chain data and tab navigation
class _OptionChainWrapperState extends State<OptionChainWrapper> {
  late PageController
      _pageController; // PageController to manage the tab content
  int _selectedIndex = 0; // Selected tab index - 0: Price, 1: OI, 2: Greeks
  String expirySelectors = '20 May'; // Currently selected expiry date
  List<String> displayMonths = [
    '20 May',
    '27 May',
    '20 Jun'
  ]; // Available expiry dates

  // Colors for container styling - Defined for consistent UI theming
  final Color containerBackgroundColor =
      const Color(0xFF1A1A1A); // Darker background for containers
  final Color containerBorderColor =
      const Color(0xFF333333); // Subtle border color
  final Color dropdownBackgroundColor =
      const Color(0xFF121413); // Dropdown menu background color
  final Color textColor =
      const Color(0xFFFFFFFF); // Text color for most elements
  final Color iconColor = const Color(
      0xFF999999); // Icon color (slightly dimmed for visual hierarchy)

  /// Helper method to get month name from month number
  /// @param month - Month number (1-12)
  /// @return String - Three-letter abbreviation for the month name
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

  // Options for the tab toggle - Defines the available tabs
  final List<String> _options = ['Price', 'OI', 'Greeks'];

  @override
  void initState() {
    super.initState();
    // Initialize the page controller with the default selected tab
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    // Clean up resources when widget is disposed
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark; // Check for dark theme
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leadingWidth: 24.w,
        title: Column(
          children: [
            Row(
              children: [
                /// Stock Information Section - Displays stock details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Stock Name Row - Shows stock name and exchange
                    Row(
                      children: [
                        // Stock name with styling
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
                        // Exchange chip (NSE or BSE)
                        if (widget.exchange == "NSE")
                          _infoChip("NSE")
                        else
                          _infoChip("BSE"),
                      ],
                    ),
                    SizedBox(height: 4.h),

                    /// Price Row - Shows current price and change
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Current price display
                        Text(
                          widget.price,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(width: 4.h),
                        // Price change with color coding (green for positive, red for negative)
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

                /// Expiry Date Selector - Dropdown for selecting option expiry
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
                          width: 1), // Subtle border for depth
                    ),
                    child: Theme(
                      // Apply theme override for scrollbar styling
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
                          isDense: true, // Compact dropdown style
                          // Show more items with a larger height (50% of screen)
                          menuMaxHeight:
                              MediaQuery.of(context).size.height * 0.5,
                          // Generate dropdown items from available expiry dates
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
                            print(
                                'DEBUG: Dropdown changed to: $newValue'); // Debug log
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

                /// Search Icon - For searching within option chain
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
          /// Tab Toggle Bar - Switches between Price, OI, and Greeks views
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: AnimatedOptionToggle(
              options: _options,
              selectedIndex: _selectedIndex,
              onToggle: (index) {
                setState(() {
                  _selectedIndex = index;
                  // Animate to the selected page with smooth transition
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

          /// Page View Container - Shows content for selected tab
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                // Tab content views for different option chain metrics
                optionChainPrice(symbol: widget.symbol), // Price view
                optionChainOI(symbol: widget.symbol), // Open Interest view
                optionChainGreek(symbol: widget.symbol), // Greeks view
              ],
            ),
          ),
        ],
      ),
    );
  }

// No longer needed as we're using AnimatedOptionToggle
}

/// Creates an information chip widget for displaying exchange type
/// @param text - Text to display in the chip (typically NSE or BSE)
/// @return Widget - A styled chip container with the provided text
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
