// File: events.dart
// Description: Events tab for the stock detail view in the Sapphire Trading application.
// This widget displays a list of upcoming corporate events like earnings calls, meetings, 
// product launches, and dividend payments related to a stock.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling

/// EventsTab - Widget that displays stock-related corporate events
/// Shows a scrollable list of upcoming events with type, date, and description
class EventsTab extends StatefulWidget {
  final bool isDark; // Current theme mode (dark/light)

  /// Constructor to initialize the events tab with theme mode
  const EventsTab({Key? key, required this.isDark}) : super(key: key);

  @override
  State<EventsTab> createState() => _EventsTabState();
}

/// State class for the EventsTab widget
/// Manages the display of upcoming corporate events
class _EventsTabState extends State<EventsTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // List of upcoming corporate events

          // Earnings Call event
          _buildEventItem(
            'Earnings Call', // Event type
            'May 20, 2025', // Event date
            'Q4 FY25 Earnings Conference Call', // Event description
          ),
          SizedBox(height: 6.h),

          // Annual General Meeting event
          _buildEventItem(
            'Annual General Meeting', // Event type
            'July 15, 2025', // Event date
            'Annual General Meeting for FY25', // Event description
          ),
          SizedBox(height: 6.h),

          // Product Launch event
          _buildEventItem(
            'Product Launch', // Event type
            'June 5, 2025', // Event date
            'New Electric Scooter Launch Event', // Event description
          ),
          SizedBox(height: 6.h),

          // Dividend Payment event
          _buildEventItem(
            'Dividend Payment', // Event type
            'August 10, 2025', // Event date
            'Final Dividend Payment for FY25', // Event description
          ),
          SizedBox(height: 6.h),

          // Investor Day event
          _buildEventItem(
            'Investor Day', // Event type
            'September 22, 2025', // Event date
            'Annual Investor Day with Management Presentations', // Event description
          ),
        ],
      ),
    );
  }

  /// Builds an individual event item widget
  /// @param type - Type of the corporate event (e.g., "Earnings Call", "Product Launch")
  /// @param date - Date when the event is scheduled (e.g., "May 20, 2025")
  /// @param description - Brief description of the event
  /// @return Widget - Column with formatted event information and a divider
  Widget _buildEventItem(String type, String date, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Event type and date row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Event type (left side)
            Text(
              type,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Event date (right side)
            Text(
              date,
              style: TextStyle(
                color: widget.isDark ? Colors.white : Colors.black54,
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        // Event description with lighter text color
        Text(
          description,
          style: TextStyle(
            color: widget.isDark ? Colors.white70 : Colors.black26,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 6.h),
        // Divider for visual separation between events
        Divider(
          color: Color(0xff2f2f2f),
        )
      ],
    );
  }
}