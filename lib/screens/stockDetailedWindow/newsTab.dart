import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class newsTab extends StatefulWidget {
  final bool isDark;

  const newsTab({Key? key, required this.isDark}) : super(key: key);

  @override
  State<newsTab> createState() => _newsTabState();
}

class _newsTabState extends State<newsTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // News items
            _buildNewsItem(
              'Hindustan Times',
              '12 hours',
              'Hero MotoCorp reported a Q4 FY25 net profit of ₹1081 crore, up 6% YoY, driven by demand in premium motorcycles, scooters, and EVs. The company retained market leadership for the 24th year. Revenue rose 4% YoY to ₹9939 crore in Q4 FY25. Annual revenue reached ₹40923 crore, an 8% increase, with PAT up 17% to ₹4376 crore, aided by strong exports and new model introductions.',
            ),
            // SizedBox(height: 12.h),
            _buildNewsItem(
              'ScoutQuest',
              'a day',
              'Hero MotoCorp\'s higher realizations are due to a better product mix. The wedding season in May and June is expected to boost two-wheeler sales.\nMargins are projected to remain between 14-16%. The electric vehicle business is anticipated to break even within two years.',
            ),
            // SizedBox(height: 16.h),
            _buildNewsItem(
              'ScoutQuest',
              'a day',
              'Hero MotoCorp aims to maintain profit margins between 14-16%.',
            ),
            // SizedBox(height: 16.h),
            _buildNewsItem(
              'BSE',
              '2 days',
              'Hero MotoCorp Ltd. cancels its Investor Day 2025 scheduled for May 19 in Mumbai.',
            ),
            // SizedBox(height: 16.h),
            _buildNewsItem(
              'ScoutQuest',
              '2 days',
              'Hero MotoCorp Ltd\'s Investor Day on May 19, 2025, in Mumbai is cancelled. Initially announced on May 5, 2025.',
            ),
          ],
        ),
      ),
    );
  }

  // News item widget
  Widget _buildNewsItem(String source, String time, String content) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: widget.isDark
                ? const Color(0xFF2F2F2F)
                : const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Source and time
          Row(
            children: [
              Text(
                source,
                style: TextStyle(
                  color: widget.isDark ? Colors.white : Colors.black87,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
          // News content
          Text(
            content,
            style: TextStyle(
              color: widget.isDark ? Colors.white : Colors.black87,
              fontSize: 11.sp,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
