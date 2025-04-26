import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/utils/constWidgets.dart';
import 'package:sapphire/utils/toogle.dart';

class VerifiedPnL extends StatefulWidget {
  const VerifiedPnL({super.key});

  @override
  State<VerifiedPnL> createState() => _VerifiedPnLState();
}

class _VerifiedPnLState extends State<VerifiedPnL> {
  String selectedOption = "Full Name";
  List<String> options = ["Full Name", "Short Name", "Masked"];

  // For segment to share selection
  String selectedSegment = "Cash";
  // Optionally, you can use this for maintainability:
  // final List<String> segmentOptions = ["Cash", "Futures", "Options", "Commodity"];
  bool livePnL = false;
  bool displayTrades = false;

  // Dropdown options for days
  final List<String> dayOptions = ["7 days", "30 days", "90 days"];
  String selectedDayOption = "30 days";

  // Date range (auto-updated based on dropdown)
  DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime endDate = DateTime.now();

  // Helper to format date as yyyy-MM-dd
  String formatDate(DateTime date) {
    // Returns yyyy-MM-dd
    return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Verified P&L",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Unfocus when tapping outside
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Divider(
                color: const Color(0xFF2F2F2F),
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: const Color(0xff121413),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xff021814),
                            radius: 35.r,
                            child: Text(
                              "NK",
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff22A06B),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (selectedOption == "Full Name")
                                Text(
                                  "Nakul Pratap Thakur",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                )
                              else if (selectedOption == "Short Name")
                                Text(
                                  "Nakul",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                )
                              else if (selectedOption == "Masked")
                                Text(
                                  "Nakul ****",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                )
                              else
                                Text(
                                  "Nakul Pratap Thakur",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              SizedBox(height: 4.h),
                            ],
                          ),
                          const Spacer(),
                          SizedBox(width: 12.w),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: 370.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: const Color(0xff121413),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 18.h),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Personal Information",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: options.map((option) {
                                  final bool isSelected =
                                      selectedOption == option;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedOption = option;
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 12.w),
                                      child: Row(
                                        children: [
                                          CustomRadioButton(
                                              isSelected: isSelected,
                                              onTap: () {
                                                setState(() {
                                                  selectedOption = option;
                                                });
                                              }),
                                          SizedBox(width: 5.w),
                                          Text(
                                            option,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: const Color(0xFFEBEEF5),
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: 370.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: const Color(0xff121413),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 18.h),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Description or Profile (Optional)",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: SizedBox(
                                height: 105.h,
                                child: TextField(
                                  autofocus: false,
                                  maxLines: null,
                                  expands: true,
                                  textAlignVertical: TextAlignVertical.top,
                                  decoration: InputDecoration(
                                    hintText: "Description",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.r),
                                      borderSide: BorderSide(
                                        color: const Color(0xff121413),
                                        width: 1.w,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xff121413),
                                  ),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    // --- Segment to share ---
                    Container(
                      width: 370.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: const Color(0xff121413),
                      ),
                      padding: EdgeInsets.only(
                          left: 12.w, top: 18.h, right: 12.w, bottom: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 8.w,
                            ),
                            child: Text(
                              "Segment to share",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            childAspectRatio: 3.5,
                            crossAxisSpacing: 14.w,
                            mainAxisSpacing: 14.h,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              ...["Cash", "Futures", "Options", "Commodity"]
                                  .map((segment) {
                                final bool isSelected =
                                    selectedSegment == segment;
                                return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedSegment = segment;
                                      });
                                    },
                                    child: constWidgets.choiceChipiWithCheckbox(
                                        segment, isSelected, context));
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: 370.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: const Color(0xff121413),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 18.h),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Timeline to Share",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.h, horizontal: 20.w),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Live P&L (updates everyday)",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CustomToggleSwitch(onChanged: (value) {
                                    setState(() {
                                      livePnL = value;
                                    });
                                  })
                                ],
                              ),
                            ),
                            // --- Dropdown for days ---
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 12.w),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFF434343), width: 1.2),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedDayOption,
                                    isExpanded: true,
                                    icon: Padding(
                                      padding: EdgeInsets.only(right: 12.w),
                                      child: Icon(Icons.keyboard_arrow_down,
                                          color: Colors.white, size: 28),
                                    ),
                                    dropdownColor: Color(0xff121413),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18.sp),
                                    items: dayOptions.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 14.w, vertical: 10.h),
                                          child: Text(value),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedDayOption = newValue!;
                                        // Parse the number of days from the selected option
                                        int days = int.tryParse(
                                                selectedDayOption
                                                    .split(' ')[0]) ??
                                            30;
                                        endDate = DateTime.now();
                                        startDate = endDate
                                            .subtract(Duration(days: days));
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            // --- Date range display ---
                            Padding(
                              padding: EdgeInsets.only(left: 18.w, top: 8.h),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  // Format the dates as yyyy-MM-dd ~ yyyy-MM-dd
                                  "${formatDate(startDate)} ~ ${formatDate(endDate)}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.w),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    displayTrades = !displayTrades;
                                  });
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Row(
                                  children: [
                                    Container(
                                      width:
                                          20, // Checkbox size (improved for visibility)
                                      height: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            4), // Rounded rectangle corners
                                        border: Border.all(
                                          color: displayTrades
                                              ? Color(
                                                  0xFF1DB954) // Green border when selected
                                              : Color(
                                                  0xFF434343), // Grey border otherwise
                                          width: 2.0,
                                        ),
                                        color: displayTrades
                                            ? Color(
                                                0xFF2A3C2E) // Slight green background if selected
                                            : Colors
                                                .transparent, // No background if not selected
                                      ),
                                      child: displayTrades
                                          ? Center(
                                              child: Icon(
                                                Icons
                                                    .check, // Minimal checkmark icon
                                                color: Color(
                                                    0xFF1DB954), // Green check
                                                size:
                                                    16, // Balanced size for the box
                                              ),
                                            )
                                          : null, // No icon if not selected
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: Text("Display Trades",
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
