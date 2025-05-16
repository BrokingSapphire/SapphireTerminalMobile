// File: filters.dart
// Description: Filter configuration and UI for the Sapphire: Terminal Trading application.
// This file implements the filtering system used across different sections of the app.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components
import 'package:flutter_svg/flutter_svg.dart'; // For SVG image rendering

/// FilterOption - Model class for each filter option configuration
/// Contains the filter label, available sort directions, and associated icon
class FilterOption {
  final String label; // Display name of the filter option
  final List<String>
      sortDirections; // Available sort directions (Ascending/Descending/etc.)
  final String? svgPath; // Optional SVG path for the filter icon

  FilterOption({
    required this.label,
    required this.sortDirections,
    this.svgPath, // Optional SVG path
  });
}

/// Filter configuration map for all pages in the application
/// Each page key maps to a list of available filter options for that section
final Map<String, List<FilterOption>> filterConfig = {
  // Watchlist screen filter options
  'watchlist': [
    FilterOption(
        label: 'Price',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/price.svg'),
    FilterOption(
        label: 'Change (1 Day)',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/percentChange.svg'),
    FilterOption(
        label: 'Volume',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/volume.svg'),
    FilterOption(
        label: 'Market Cap',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/marketCap.svg'),
    FilterOption(
        label: 'P/E Ratio',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/peRatio.svg'),
    FilterOption(
        label: 'Alphabetical',
        sortDirections: ['A–Z', 'Z–A'],
        svgPath: 'assets/svgs/alphabetical.svg'),
  ],

  // Equity holdings screen filter options
  'equity': [
    FilterOption(
        label: 'Current Value',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/price.svg'),
    FilterOption(
        label: 'Unrealized P&L (₹)',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/trending-up.svg'),
    FilterOption(
        label: 'Quantity Held',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/box.svg'),
    FilterOption(
        label: 'Market Price',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/chart-candlestick.svg'),
    FilterOption(
        label: 'Holding Period',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/calendar.svg'),
    FilterOption(
        label: 'Alphabetical',
        sortDirections: ['A–Z', 'Z–A'],
        svgPath: 'assets/svgs/alphabetical.svg'),
  ],

  // Open positions screen filter options
  'positions': [
    FilterOption(
        label: 'Net P&L (₹)',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/trending-up.svg'),
    FilterOption(
        label: 'Quantity',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/box.svg'),
    FilterOption(
        label: 'Current Market Price',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/chart-candlestick.svg'),
    FilterOption(
        label: 'Last Traded Price Change (%)',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/activity.svg'),
    FilterOption(
        label: 'Exposure Value (Margin Used)',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/banknote.svg'),
    FilterOption(
        label: 'Symbol',
        sortDirections: ['A–Z', 'Z–A'],
        svgPath: 'assets/svgs/barcode.svg'),
  ],

  // Mutual funds screen filter options
  'mutual_funds': [
    FilterOption(
        label: 'Current Value',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/price.svg'),
    FilterOption(
        label: 'Invested Amount',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/banknote.svg'),
    FilterOption(
        label: 'Absolute Gain/Loss (₹)',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/trending-up.svg'),
    FilterOption(
        label: 'XIRR / Annualized Return (%)',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/percent.svg'),
    FilterOption(
        label: 'NAV (Latest)',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/receipt-indian-rupee.svg'),
    FilterOption(
        label: 'Fund Name',
        sortDirections: ['A–Z', 'Z–A'],
        svgPath: 'assets/svgs/text.svg'),
  ],

  // Closed trades screen filter options
  'closed_trades': [
    FilterOption(
        label: 'Date Posted',
        sortDirections: ['Oldest First', 'Newest First'],
        svgPath: 'assets/svgs/date_posted.svg'),
    FilterOption(
        label: 'Trade Type',
        sortDirections: ['Buy First', 'Sell First'],
        svgPath: 'assets/svgs/trade_type.svg'),
    FilterOption(
        label: 'Target Achieved (%)',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/target_achieved.svg'),
    FilterOption(
        label: 'Entry Price',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/entry_price.svg'),
    FilterOption(
        label: 'Exit Price',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/exit_price.svg'),
    FilterOption(
        label: 'Result (Hit / SL / Open)',
        sortDirections: ['SL First', 'Target First', 'Open First'],
        svgPath: 'assets/svgs/result.svg'),
    FilterOption(
        label: 'Symbol',
        sortDirections: ['A–Z', 'Z–A'],
        svgPath: 'assets/svgs/symbol.svg'),
    FilterOption(
        label: 'Segment',
        sortDirections: ['A–Z', 'Z–A'],
        svgPath: 'assets/svgs/segment.svg'),
  ],

  // Orders screen filter options
  'orders': [
    FilterOption(
      label: 'Time Placed',
      sortDirections: ['Oldest First', 'Newest First'],
      svgPath: 'assets/svgs/clock.svg',
    ),
    FilterOption(
        label: "Quantity",
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/box.svg'),
    FilterOption(
        label: "Order Price",
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/price.svg'),
    FilterOption(
        label: "Symbol",
        sortDirections: ['A–Z', 'Z–A'],
        svgPath: 'assets/svgs/barcode.svg'),
    FilterOption(
        label: "Segment",
        sortDirections: ['A-Z', 'Z-A'],
        svgPath: 'assets/svgs/segment.svg'),
    FilterOption(
        label: "Trade Side",
        sortDirections: ['Buy', 'Sell'],
        svgPath: 'assets/svgs/tradeSide.svg'),
  ]
};

/// Shows a modal bottom sheet with filter options for the specified page
/// Allows users to select a sort option and direction for data display
///
/// Parameters:
/// - context: The BuildContext for showing the bottom sheet
/// - pageKey: The key to access the appropriate filters from filterConfig
/// - onApply: Callback function to handle the selected filters
/// - isDark: Flag for dark/light theme rendering
void showFilterBottomSheet({
  required BuildContext context,
  required String pageKey,
  required Function(List<Map<String, String>>) onApply,
  required bool isDark,
}) {
  // Get the filter options for the current page
  final options = filterConfig[pageKey] ?? [];

  // Variables to track the selected filter option and direction
  String? selectedFilterLabel;
  String? selectedDirection;

  showModalBottomSheet(
    context: context,
    backgroundColor: isDark ? const Color(0xFF121413) : const Color(0xFFF4F4F9),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
    ),
    isScrollControlled: true, // Allow the sheet to be scrollable and resizable
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 24.h,
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  24.h, // Adjust for keyboard
            ),
            child: Container(
              // height: MediaQuery.of(context).size.height *
              //     0.6, // Set height to 70% of the screen height

              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Drag handle at the top of the sheet
                    Center(
                      child: Container(
                        height: 4.h,
                        width: 40.w,
                        margin: EdgeInsets.only(bottom: 16.h),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey.shade700 : Colors.black,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    // Header text
                    Text(
                      "Sort By",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 18.sp,
                          ),
                    ),
                    SizedBox(height: 24.h),
                    // Filter options list
                    ...options.map((option) {
                      // Determine if this filter is the one currently selected
                      final isSelected = selectedFilterLabel == option.label;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Filter option label with icon
                          Row(
                            children: [
                              // Display SVG icon if available
                              if (option.svgPath != null)
                                SvgPicture.asset(
                                  option.svgPath!,
                                  height: 16.h,
                                  width: 16.w,
                                  color: isDark ? Colors.white : Colors.black,
                                )
                              else
                                Text(""), // Fallback if no SVG
                              SizedBox(width: 8.w),
                              Text(
                                option.label,
                                style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          // Sort direction options (Ascending/Descending/etc.)
                          Row(
                            children: option.sortDirections.map((dir) {
                              // Check if this direction is selected for this filter
                              final isDirectionSelected =
                                  isSelected && selectedDirection == dir;

                              return Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      // left: 6.w,
                                      right: 6.w), // Adds 6.w gap on both sides
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        // Update selection state
                                        if (!isSelected) {
                                          selectedFilterLabel = option.label;
                                        }
                                        selectedDirection = dir;
                                      });
                                    },
                                    // Display choice chip with selection state
                                    child: constWidgets.choiceChip(
                                      dir, // Direction label (Ascending/Descending)
                                      isDirectionSelected, // Whether this direction is selected
                                      context,
                                      130.w, // Width of the chip
                                      isDark, // Theme mode
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          SizedBox(height: 16.h),
                        ],
                      );
                    }).toList(),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
