import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/utils/constWidgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'constWidgets.dart'; // Import flutter_svg

/// 🧩 Model for each filter option
class FilterOption {
  final String label;
  final List<String> sortDirections;
  final String? svgPath; // Optional SVG path for the filter icon

  FilterOption({
    required this.label,
    required this.sortDirections,
    this.svgPath, // Add the optional SVG path
  });
}

/// 📦 Filter configuration for all pages
final Map<String, List<FilterOption>> filterConfig = {
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
        label: 'Unrealized P&L (%)',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/percent.svg'),
    FilterOption(
        label: 'Quantity Held',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/box.svg'),
    FilterOption(
        label: 'Average Buy Price',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/tag.svg'),
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
    FilterOption(
        label: 'Sector',
        sortDirections: ['A–Z', 'Z–A'],
        svgPath: 'assets/svgs/grid-2x2.svg'),
  ],
  'positions': [
    FilterOption(
        label: 'Net P&L (₹)',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/trending-up.svg'),
    FilterOption(
        label: 'Net P&L (%)',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/percent.svg'),
    FilterOption(
        label: 'Quantity',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/box.svg'),
    FilterOption(
        label: 'Average Price',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/tag.svg'),
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
    FilterOption(
        label: 'Exchange',
        sortDirections: ['A–Z', 'Z–A'],
        svgPath: 'assets/svgs/globe.svg'),
  ],
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
        label: 'SIP Date (Start Date)',
        sortDirections: ['Ascending', 'Descending'],
        svgPath: 'assets/svgs/calendar.svg'),
    FilterOption(
        label: 'Fund Name',
        sortDirections: ['A–Z', 'Z–A'],
        svgPath: 'assets/svgs/text.svg'),
    FilterOption(
        label: 'Category (Equity / Debt / Hybrid / etc.)',
        sortDirections: ['A–Z', 'Z–A'],
        svgPath: 'assets/svgs/layers.svg'),
  ],
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

void showFilterBottomSheet({
  required BuildContext context,
  required String pageKey,
  required Function(List<Map<String, String>>) onApply,
}) {
  final options = filterConfig[pageKey] ?? [];

  // Variable to track the selected filter option globally (only one can be selected)
  String? selectedFilterLabel;
  String? selectedDirection;

  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF121413),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    isScrollControlled: true, // Keep scroll control to ensure correct size
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 24.h,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height *
                  0.7, // Set height to 70% of the screen height
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Container(
                        height: 4.h,
                        width: 40.w,
                        margin: EdgeInsets.only(bottom: 16.h),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade700,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    Text(
                      "Sort By",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontSize: 18.sp,
                          ),
                    ),
                    SizedBox(height: 24.h),
                    ...options.map((option) {
                      // Determine if this filter is the one currently selected
                      final isSelected = selectedFilterLabel == option.label;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // If an SVG is provided, show it; otherwise, show default icon
                              if (option.svgPath != null)
                                SvgPicture.asset(
                                  option.svgPath!, // Load the SVG from the path
                                  height: 20
                                      .h, // You can adjust the size as per your requirement
                                  width: 20.w,
                                  color: Colors.white,
                                )
                              else
                                Text(""), // Fallback if no SVG
                              SizedBox(width: 8.w),
                              Text(
                                option.label,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: option.sortDirections.map((dir) {
                              // If this filter is selected, then this direction can be chosen
                              final isDirectionSelected =
                                  isSelected && selectedDirection == dir;

                              return Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 6.w),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        // If this filter is selected, update the direction
                                        if (!isSelected) {
                                          selectedFilterLabel = option.label;
                                        }
                                        selectedDirection = dir;
                                      });
                                    },
                                    child: constWidgets.choiceChip(
                                      dir, // The direction being displayed ("Ascending" or "Descending")
                                      isDirectionSelected, // Highlight the selected option
                                      context,
                                      130.w,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 20.h),
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
