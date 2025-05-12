import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CustomDateRangePickerBottomSheet extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTimeRange? initialDateRange;

  const CustomDateRangePickerBottomSheet({
    Key? key,
    required this.firstDate,
    required this.lastDate,
    this.initialDateRange,
  }) : super(key: key);

  @override
  _CustomDateRangePickerBottomSheetState createState() =>
      _CustomDateRangePickerBottomSheetState();
}

class _CustomDateRangePickerBottomSheetState
    extends State<CustomDateRangePickerBottomSheet> {
  late DateTime _startDate;
  late DateTime _endDate;
  late int _selectedDayIndex;
  late int _selectedMonthIndex;
  late int _selectedYearIndex;
  bool _isSelectingStartDate =
      true; // Flag to track which date is being selected

  late List<int> _days;
  late List<String> _months;
  late List<int> _years;
  late DateTime _effectiveLastDate;

  @override
  void initState() {
    super.initState();

    // Restrict lastDate to current date if it's in the future
    _effectiveLastDate = widget.lastDate.isAfter(DateTime.now())
        ? DateTime.now()
        : widget.lastDate;

    // Calculate default financial year dates if initialDateRange is null
    DateTime defaultStart;
    DateTime defaultEnd;
    if (widget.initialDateRange == null) {
      DateTime currentDate = DateTime.now();
      int currentYear = currentDate.year;

      if (currentDate.isBefore(DateTime(currentYear, 4, 1))) {
        currentYear -= 1;
      }

      defaultStart = DateTime(currentYear, 4, 1);
      defaultEnd = DateTime(currentYear + 1, 3, 31);

      // Ensure default dates are within firstDate and effectiveLastDate
      defaultStart = defaultStart.isBefore(widget.firstDate)
          ? widget.firstDate
          : defaultStart;
      defaultEnd = defaultEnd.isAfter(_effectiveLastDate)
          ? _effectiveLastDate
          : defaultEnd;
    } else {
      defaultStart = widget.initialDateRange!.start;
      defaultEnd = widget.initialDateRange!.end;
    }

    // Initialize dates
    _startDate = defaultStart;
    _endDate = defaultEnd;

    // Initialize years
    _years = List.generate(
      _effectiveLastDate.year - widget.firstDate.year + 1,
      (index) => widget.firstDate.year + index,
    );

    // Set initial selected indices based on the start date
    _selectedYearIndex = _startDate.year - widget.firstDate.year;
    _selectedMonthIndex = _startDate.month - 1;
    _selectedDayIndex = _startDate.day - 1;

    // Initialize days and months
    _months = []; // Initialize empty, will be set in _updateDays
    _updateDays();
  }

  // Check if a year is a leap year
  bool _isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  // Get the number of days in a given month
  int _getDaysInMonth(int year, int month) {
    if (month == 2) {
      return _isLeapYear(year) ? 29 : 28;
    }
    if ([4, 6, 9, 11].contains(month)) {
      return 30;
    }
    return 31;
  }

  void _updateDays() {
    final selectedYear = _years[_selectedYearIndex];
    final selectedMonth = _selectedMonthIndex + 1;
    final daysInMonth = _getDaysInMonth(selectedYear, selectedMonth);

    // Adjust days based on effectiveLastDate if the selected year and month match
    int maxDay = daysInMonth;
    if (selectedYear == _effectiveLastDate.year &&
        selectedMonth == _effectiveLastDate.month) {
      maxDay = _effectiveLastDate.day;
    }

    // Update months list based on the selected year
    final currentYear = DateTime.now().year;
    final currentMonth = DateTime.now().month;
    setState(() {
      if (selectedYear == currentYear) {
        // Only show months up to the current month for the current year
        _months = List.generate(
          currentMonth,
          (index) => DateFormat('MMMM').format(DateTime(2020, index + 1, 1)),
        );
      } else {
        // Show all months for other years
        _months = List.generate(
          12,
          (index) => DateFormat('MMMM').format(DateTime(2020, index + 1, 1)),
        );
      }

      // Adjust selected month index if it's out of range
      if (_selectedMonthIndex >= _months.length) {
        _selectedMonthIndex = _months.length - 1;
      }

      _days = List.generate(maxDay, (index) => index + 1);

      // Adjust selected day if it's out of range
      if (_selectedDayIndex >= maxDay) {
        _selectedDayIndex = maxDay - 1;
      }
    });
  }

  void _updateDates() {
    final selectedYear = _years[_selectedYearIndex];
    final selectedMonth = _selectedMonthIndex + 1;
    final selectedDay = _days[_selectedDayIndex];

    DateTime selectedDate = DateTime(selectedYear, selectedMonth, selectedDay);

    // Ensure the selected date is within bounds
    if (selectedDate.isBefore(widget.firstDate)) {
      selectedDate = widget.firstDate;
      _selectedYearIndex = selectedDate.year - widget.firstDate.year;
      _selectedMonthIndex = selectedDate.month - 1;
      _selectedDayIndex = selectedDate.day - 1;
      _updateDays();
    } else if (selectedDate.isAfter(_effectiveLastDate)) {
      selectedDate = _effectiveLastDate;
      _selectedYearIndex = selectedDate.year - widget.firstDate.year;
      _selectedMonthIndex = selectedDate.month - 1;
      _selectedDayIndex = selectedDate.day - 1;
      _updateDays();
    }

    setState(() {
      if (_isSelectingStartDate) {
        _startDate = selectedDate;
      } else {
        if (selectedDate.isBefore(_startDate)) {
          _endDate = _startDate;
          _startDate = selectedDate;
          _isSelectingStartDate = true; // Switch back to selecting Start date
        } else {
          _endDate = selectedDate;
        }
      }
    });
  }

  void _resetDates() {
    setState(() {
      DateTime currentDate = DateTime.now();
      int currentYear = currentDate.year;

      if (currentDate.isBefore(DateTime(currentYear, 4, 1))) {
        currentYear -= 1;
      }

      _startDate = DateTime(currentYear, 4, 1);
      _endDate = DateTime(currentYear + 1, 3, 31);

      // Ensure reset dates are within bounds
      _startDate =
          _startDate.isBefore(widget.firstDate) ? widget.firstDate : _startDate;
      _endDate =
          _endDate.isAfter(_effectiveLastDate) ? _effectiveLastDate : _endDate;

      _selectedYearIndex = _startDate.year - widget.firstDate.year;
      _selectedMonthIndex = _startDate.month - 1;
      _selectedDayIndex = _startDate.day - 1;
      _isSelectingStartDate = true;
      _updateDays();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.5,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2F2F2F), // Background color: #2F2F2F
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(26.r), // Rounded top-left corner
          topRight: Radius.circular(26.r), // Rounded top-right corner
        ),
      ),
      child: Column(
        children: [
          // Indicate which date is being selected
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Select Date Range',
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white, // White text
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          // Independent scrolling columns for day, month, and year
          Expanded(
            child: Row(
              children: [
                // Day Column
                Expanded(
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 50,
                    diameterRatio: 1.5,
                    physics: FixedExtentScrollPhysics(),
                    controller: FixedExtentScrollController(
                        initialItem: _selectedDayIndex),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedDayIndex = index;
                        _updateDates();
                      });
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: _days.length,
                      builder: (context, index) {
                        final isSelected = _selectedDayIndex == index;
                        return Center(
                          child: Text(
                            '${_days[index]}',
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected
                                  ? Colors.green
                                  : Colors.white.withOpacity(
                                      0.5), // Green for selected, faded white for unselected
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Month Column
                Expanded(
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 50,
                    diameterRatio: 1.5,
                    physics: FixedExtentScrollPhysics(),
                    controller: FixedExtentScrollController(
                        initialItem: _selectedMonthIndex),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedMonthIndex = index;
                        _updateDays(); // Update days for the new month
                        _updateDates();
                      });
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: _months.length,
                      builder: (context, index) {
                        final isSelected = _selectedMonthIndex == index;
                        return Center(
                          child: Text(
                            _months[index],
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected
                                  ? Colors.green
                                  : Colors.white.withOpacity(
                                      0.5), // Green for selected, faded white for unselected
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Year Column
                Expanded(
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 50,
                    diameterRatio: 1.5,
                    physics: FixedExtentScrollPhysics(),
                    controller: FixedExtentScrollController(
                        initialItem: _selectedYearIndex),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedYearIndex = index;
                        _updateDays(); // Update days for the new year/month
                        _updateDates();
                      });
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: _years.length,
                      builder: (context, index) {
                        final isSelected = _selectedYearIndex == index;
                        return Center(
                          child: Text(
                            '${_years[index]}',
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected
                                  ? Colors.green
                                  : Colors.white.withOpacity(
                                      0.5), // Green for selected, faded white for unselected
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Start and End date display
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _isSelectingStartDate
                        ? Colors.green.withOpacity(
                            0.1) // Light green background when selecting
                        : Color(
                            0xFF2F2F2F), // Default background when not selecting
                    border: Border.all(
                      color: _isSelectingStartDate
                          ? Colors.green
                          : Colors
                              .white, // Highlight Start date box when selecting
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Start date\n${DateFormat('dd/MM/yyyy').format(_startDate)}',
                    style: TextStyle(
                        fontSize: 14, color: Colors.white), // White text
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text('TO',
                  style: TextStyle(
                      fontSize: 14, color: Colors.white)), // White text
              SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: !_isSelectingStartDate
                        ? Colors.green.withOpacity(
                            0.1) // Light green background when selecting
                        : Color(
                            0xFF2F2F2F), // Default background when not selecting
                    border: Border.all(
                      color: !_isSelectingStartDate
                          ? Colors.green
                          : Colors
                              .white, // Highlight End date box when selecting
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'End date\n${DateFormat('dd/MM/yyyy').format(_endDate)}',
                    style: TextStyle(
                        fontSize: 14, color: Colors.white), // White text
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: _resetDates,
                child: Text(
                  'RESET',
                  style: TextStyle(
                    color: Colors.green, // Green for RESET button
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  if (_isSelectingStartDate)
                    Container(
                      width: 120.w,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isSelectingStartDate = false;
                            // Set the scrollers to the end date
                            _selectedYearIndex =
                                _endDate.year - widget.firstDate.year;
                            _selectedMonthIndex = _endDate.month - 1;
                            _updateDays();
                            _selectedDayIndex = _endDate.day - 1;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Green button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          'NEXT',
                          style: TextStyle(
                            color: Colors.white, // White text
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  if (!_isSelectingStartDate)
                    Container(
                      width: 120.w,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            DateTimeRange(start: _startDate, end: _endDate),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Green button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'APPLY',
                              style: TextStyle(
                                color: Colors.white, // White text
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
