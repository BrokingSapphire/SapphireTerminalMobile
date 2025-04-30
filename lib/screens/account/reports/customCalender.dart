import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CustomDateRangePicker extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTimeRange? initialDateRange;

  const CustomDateRangePicker({
    super.key,
    required this.firstDate,
    required this.lastDate,
    this.initialDateRange,
  });

  @override
  _CustomDateRangePickerState createState() => _CustomDateRangePickerState();
}

class _CustomDateRangePickerState extends State<CustomDateRangePicker> {
  late DateTime _firstMonth;
  DateTime? _startDate;
  DateTime? _endDate;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _firstMonth = widget.initialDateRange?.start ?? DateTime.now();
    _firstMonth = DateTime(_firstMonth.year, _firstMonth.month, 1);
    _startDate = widget.initialDateRange?.start;
    _endDate = widget.initialDateRange?.end;
    // Initialize PageController with the initial month
    _pageController = PageController(initialPage: _calculateInitialPage());
  }

  int _calculateInitialPage() {
    // Calculate months between firstDate and initial _firstMonth
    final initialDate = _firstMonth;
    final firstDate = widget.firstDate;
    return (initialDate.year - firstDate.year) * 12 +
        initialDate.month -
        firstDate.month;
  }

  DateTime _getMonthForPage(int pageIndex) {
    // Calculate the month for the given page index
    final firstDate = widget.firstDate;
    return DateTime(
      firstDate.year + (pageIndex ~/ 12),
      firstDate.month + (pageIndex % 12),
      1,
    );
  }

  void _selectDate(DateTime date) {
    setState(() {
      if (_startDate == null || (_startDate != null && _endDate != null)) {
        _startDate = date;
        _endDate = null;
      } else if (_startDate != null && date.isAfter(_startDate!)) {
        _endDate = date;
      } else {
        _endDate = _startDate;
        _startDate = date;
      }
    });
  }

  Widget _buildMonth(DateTime month) {
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final weekdayOfFirstDay = firstDayOfMonth.weekday;
    final List<Widget> dayWidgets = [];

    // Weekday labels
    dayWidgets.addAll(
      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map(
        (day) => Center(
          child: Text(
            day,
            style: TextStyle(color: Colors.white70, fontSize: 12.sp),
          ),
        ),
      ),
    );

    // Empty cells before the first day
    for (int i = 1; i < weekdayOfFirstDay; i++) {
      dayWidgets.add(SizedBox.shrink());
    }

    // Days of the month
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(month.year, month.month, day);
      final isSelected =
          (_startDate != null && date.isAtSameMomentAs(_startDate!)) ||
              (_endDate != null && date.isAtSameMomentAs(_endDate!));
      final isInRange = _startDate != null &&
          _endDate != null &&
          date.isAfter(_startDate!) &&
          date.isBefore(_endDate!);

      dayWidgets.add(
        GestureDetector(
          onTap: () => _selectDate(date),
          child: Container(
            margin: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.green
                  : isInRange
                      ? Colors.green.withOpacity(0.2)
                      : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$day',
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white70,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Text(
          DateFormat('MMMM yyyy').format(month),
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: 180.w,
          height: 180.h,
          child: GridView.count(
            crossAxisCount: 7,
            childAspectRatio: 1,
            children: dayWidgets,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 230.h, // For month title, grid, and spacing
          child: PageView.builder(
            controller: _pageController,
            itemCount: // Number of months between firstDate and lastDate
                (widget.lastDate.year - widget.firstDate.year) * 12 +
                    widget.lastDate.month -
                    widget.firstDate.month +
                    1,
            itemBuilder: (context, index) {
              final month = _getMonthForPage(index);
              return Center(child: _buildMonth(month));
            },
            onPageChanged: (index) {
              setState(() {
                _firstMonth = _getMonthForPage(index);
              });
            },
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
              ),
            ),
            SizedBox(width: 8.w),
            TextButton(
              onPressed: () {
                if (_startDate != null && _endDate != null) {
                  Navigator.pop(context,
                      DateTimeRange(start: _startDate!, end: _endDate!));
                }
              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.green, fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
