import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventsTab extends StatefulWidget {
  final bool isDark;
  
  const EventsTab({Key? key, required this.isDark}) : super(key: key);

  @override
  State<EventsTab> createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEventItem(
            'Earnings Call',
            'May 20, 2025',
            'Q4 FY25 Earnings Conference Call',
          ),
          SizedBox(height: 16.h),
          _buildEventItem(
            'Annual General Meeting',
            'July 15, 2025',
            'Annual General Meeting for FY25',
          ),
          SizedBox(height: 16.h),
          _buildEventItem(
            'Product Launch',
            'June 5, 2025',
            'New Electric Scooter Launch Event',
          ),
          SizedBox(height: 16.h),
          _buildEventItem(
            'Dividend Payment',
            'August 10, 2025',
            'Final Dividend Payment for FY25',
          ),
          SizedBox(height: 16.h),
          _buildEventItem(
            'Investor Day',
            'September 22, 2025',
            'Annual Investor Day with Management Presentations',
          ),
        ],
      ),
    );
  }

  // Event item widget
  Widget _buildEventItem(String type, String date, String description) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: widget.isDark ? const Color(0xff242424) : const Color(0xffF9FAFB),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: widget.isDark ? const Color(0xFF2F2F2F) : const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                type,
                style: TextStyle(
                  color: const Color(0xff1DB954),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  color: widget.isDark ? Colors.white70 : Colors.black54,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            description,
            style: TextStyle(
              color: widget.isDark ? Colors.white : Colors.black87,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
