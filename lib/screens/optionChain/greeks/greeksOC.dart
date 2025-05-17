// File: greeksOC.dart
// Description: Greeks view component for the option chain in the Sapphire Trading application.
// This screen displays option chain data with Greek metrics (IV, Delta, Theta, Vega) in a list format
// with the ability to toggle between call and put options.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling

/// optionChainGreek - Widget that displays option chain Greek metrics
/// Shows a list of options with their associated Greek values
class optionChainGreek extends StatefulWidget {
  final String symbol; // Stock symbol for which option chain is displayed

  /// Constructor to initialize the option chain Greeks view
  const optionChainGreek({super.key, required this.symbol});

  @override
  State<optionChainGreek> createState() => _optionChainGreekState();
}

/// State class for the optionChainGreek widget
/// Manages the display of option chain Greek metrics and toggle state
class _optionChainGreekState extends State<optionChainGreek> {
  // Toggle state for Call column visibility
  bool _showCallData = true;

  // Toggle state for Call/Put selection 
  bool isCall = false; // false: Put, true: Call

  // Mock data for the option chain with Greek metrics
  // Contains option data with price and Greeks (IV, Delta, Theta, Vega)
  final List<Map<String, dynamic>> optionChainData = [
    {
      'call': '310',
      'put': '310',
      'price': '₹1,580.60',
      'percentChange': '+4.55%',
      'iv': '64.7',          // Implied Volatility percentage
      'delta': '1.000',      // Delta value (sensitivity to underlying price)
      'theta': '-0.070',     // Theta value (time decay)
      'vega': '0.000',       // Vega value (sensitivity to volatility)
    },
    // Additional data entries...
    {
      'call': '310',
      'put': '310',
      'price': '₹1,580.60',
      'percentChange': '+4.55%',
      'iv': '64.7',
      'delta': '1.000',
      'theta': '-0.070',
      'vega': '0.000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          SizedBox(
            height: 16.h,
          ),
          // Header row with column titles
          _buildHeaderRow(),
          // Generate option rows from data
          ...optionChainData
              .map((data) => _buildOptionRow(
            data['call'],
            data['price'],
            data['percentChange'],
            data['iv'],
            data['delta'],
            data['theta'],
            data['vega'],
          ))
              .toList(),
        ],
      ),
    );
  }

  /// Builds the header row with column titles and Call/Put toggle
  /// @return Widget - Header row with column labels and toggle control
  Widget _buildHeaderRow() {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                // Call/Put toggle switch
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(),
                      decoration: BoxDecoration(
                        color: Color(0xff2F2F2F),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Call toggle button
                          GestureDetector(
                            onTap: () => setState(() => isCall = true),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                              height: 15.h,
                              width: 22.w,
                              decoration: BoxDecoration(
                                // Green background when selected, transparent when not
                                color: isCall
                                    ? Color(0xff1db954)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(2.r),
                              ),
                              child: Center(
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 2.w),
                                  child: Text(
                                    'Call',
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                        color: isCall
                                            ? Colors.white
                                            : Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          // Put toggle button
                          GestureDetector(
                            onTap: () => setState(() => isCall = false),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                              height: 18.h,
                              width: 22.w,
                              decoration: BoxDecoration(
                                // Green background when selected, transparent when not
                                color: !isCall
                                    ? Color(0xff1db954)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(2.r),
                              ),
                              child: Center(
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 2.w),
                                  child: Text(
                                    'Put',
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                        color: !isCall
                                            ? Colors.white
                                            : Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Price column header
                Expanded(
                  flex: 2,
                  child: Text(
                    "Price",
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
                // IV (Implied Volatility) column header
                Expanded(
                  flex: 1,
                  child: Text(
                    "IV",
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Delta column header
                Expanded(
                  flex: 1,
                  child: Text(
                    "Delta",
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Theta column header
                Expanded(
                  flex: 1,
                  child: Text(
                    "Theta",
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Vega column header
                Expanded(
                  flex: 1,
                  child: Text(
                    "Vega",
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                    textAlign: TextAlign.center,
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
      ),
    );
  }

  /// Builds a regular option chain row with Greek metrics
  /// @param call - Call option identifier
  /// @param price - Option price
  /// @param percentChange - Price change percentage
  /// @param iv - Implied Volatility value
  /// @param delta - Delta value (sensitivity to underlying price)
  /// @param theta - Theta value (time decay)
  /// @param vega - Vega value (sensitivity to volatility)
  /// @return Widget - Complete option row with all Greek metrics
  Widget _buildOptionRow(
      String call,
      String price,
      String percentChange,
      String iv,
      String delta,
      String theta,
      String vega,
      ) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      child: Row(
        children: [
          // Call/Put identifier column
          Expanded(
            flex: 1,
            child: Text(
              _showCallData ? call : "-", // Show dash if call data is hidden
              style: TextStyle(color: Colors.white, fontSize: 11.sp),
              textAlign: TextAlign.center,
            ),
          ),
          // Commented out code for Put column that was replaced by toggle
          // Expanded(
          //   flex: 1,
          //   child: Text(
          //     put,
          //     style: TextStyle(color: Colors.white, fontSize: 14.sp),
          //     textAlign: TextAlign.center,
          //   ),
          // ),

          // Price column with percentage change
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Current price
                Text(
                  price,
                  style: TextStyle(color: Colors.white, fontSize: 11.sp),
                ),
                // Price change percentage (shown in green)
                Text(
                  percentChange,
                  style: TextStyle(
                      color: const Color(0xff1DB954), fontSize: 11.sp),
                ),
              ],
            ),
          ),
          // IV (Implied Volatility) column
          Expanded(
            flex: 1,
            child: Text(
              iv,
              style: TextStyle(color: Colors.white, fontSize: 11.sp),
              textAlign: TextAlign.center,
            ),
          ),
          // Delta column (sensitivity to underlying price)
          Expanded(
            flex: 1,
            child: Text(
              delta,
              style: TextStyle(color: Colors.white, fontSize: 11.sp),
              textAlign: TextAlign.center,
            ),
          ),
          // Theta column (time decay)
          Expanded(
            flex: 1,
            child: Text(
              theta,
              style: TextStyle(color: Colors.white, fontSize: 11.sp),
              textAlign: TextAlign.center,
            ),
          ),
          // Vega column (sensitivity to volatility)
          Expanded(
            flex: 1,
            child: Text(
              vega,
              style: TextStyle(color: Colors.white, fontSize: 11.sp),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}