// File: news.dart
// Description: News tab for the stock detail view in the Sapphire Trading application.
// This widget displays a list of news items related to a stock with source, time and content details.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling

/// newsTab - Widget that displays stock-related news
/// Shows a scrollable list of news items from various sources
class newsTab extends StatefulWidget {
  final bool isDark; // Current theme mode (dark/light)

  /// Constructor to initialize the news tab with theme mode
  const newsTab({Key? key, required this.isDark}) : super(key: key);

  @override
  State<newsTab> createState() => _newsTabState();
}

/// State class for the newsTab widget
/// Manages the display of news items
class _newsTabState extends State<newsTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // News items - Each item contains source, time, and content details

            // First news item - Hindustan Times
            _buildNewsItem(
              'Hindustan Times', // News source
              '12 hours', // Time since publication
              'Hero MotoCorp reported a Q4 FY25 net profit of ₹1081 crore, up 6% YoY, driven by demand in premium motorcycles, scooters, and EVs. The company retained market leadership for the 24th year. Revenue rose 4% YoY to ₹9939 crore in Q4 FY25. Annual revenue reached ₹40923 crore, an 8% increase, with PAT up 17% to ₹4376 crore, aided by strong exports and new model introductions.',
            ),

            // Second news item - ScoutQuest (product mix and projections)
            _buildNewsItem(
              'ScoutQuest', // News source
              'a day', // Time since publication
              'Hero MotoCorp\'s higher realizations are due to a better product mix. The wedding season in May and June is expected to boost two-wheeler sales.\nMargins are projected to remain between 14-16%. The electric vehicle business is anticipated to break even within two years.',
            ),

            // Third news item - ScoutQuest (profit margins)
            _buildNewsItem(
              'ScoutQuest', // News source
              'a day', // Time since publication
              'Hero MotoCorp aims to maintain profit margins between 14-16%.',
            ),

            // Fourth news item - BSE (investor day cancellation)
            _buildNewsItem(
              'BSE', // News source
              '2 days', // Time since publication
              'Hero MotoCorp Ltd. cancels its Investor Day 2025 scheduled for May 19 in Mumbai.',
            ),

            // Fifth news item - ScoutQuest (investor day details)
            _buildNewsItem(
              'ScoutQuest', // News source
              '2 days', // Time since publication
              'Hero MotoCorp Ltd\'s Investor Day on May 19, 2025, in Mumbai is cancelled. Initially announced on May 5, 2025.',
            ),
          ],
        ),
      ),
    );
  }

  /// Builds an individual news item widget
  /// @param source - Source of the news (publication name)
  /// @param time - Time since publication (e.g., "12 hours", "a day")
  /// @param content - Main content text of the news item
  /// @return Widget - Container with formatted news item
  Widget _buildNewsItem(String source, String time, String content) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
      ),
      // Bottom border for visual separation between news items
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: widget.isDark
                ? const Color(0xFF2F2F2F) // Dark theme border color
                : const Color(0xFFE5E7EB), // Light theme border color
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Source and time row (e.g., "Hindustan Times · 12 hours")
          Row(
            children: [
              // News source name with bold styling
              Text(
                source,
                style: TextStyle(
                  color: widget.isDark ? Colors.white : Colors.black87,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Time indicator with dot separator
              Text(
                ' · $time',
                style: TextStyle(
                  color: widget.isDark ? Colors.white70 : Colors.black54,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          // News content with appropriate text styling
          Text(
            content,
            style: TextStyle(
              color: widget.isDark ? Colors.white : Colors.black87,
              fontSize: 11.sp,
              height: 1.5, // Line height for better readability
            ),
          ),
        ],
      ),
    );
  }
}