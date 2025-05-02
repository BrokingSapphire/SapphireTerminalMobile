import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapphire/utils/toggle.dart';

class ActiveSegments extends StatefulWidget {
  const ActiveSegments({super.key});

  @override
  State<ActiveSegments> createState() => _ActiveSegmentsState();
}

class _ActiveSegmentsState extends State<ActiveSegments> {
  bool internet = false;
  bool storage = false;
  bool location = false;
  bool smsreading = false;
  bool notification = false;
  bool biometric = false;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            isDark ? Colors.black : Colors.white, // or your desired color
        elevation: 0,
        scrolledUnderElevation: 0, // prevent shadow when scrolling
        surfaceTintColor: Colors.transparent,
        leadingWidth: 32.w,

        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Active Segments",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
                color: isDark ? Colors.white : Colors.black),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black,
              )),
        ),
      ),
      body: Column(
        children: [
          Divider(color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 15.h),
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? Color(0xff121413) : Color(0xffF4F4F9),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildSwitchTile(
                          title: "Cash/Mutual Funds",
                          subtitle: "Get access to derivative trading",
                          value: internet,
                          onChanged: (value) {
                            setState(() {
                              internet = value;
                            });
                          },
                          isDark: isDark,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        _buildSwitchTile(
                          title: "Future and Options",
                          subtitle: "Get access to derivative trading",
                          value: storage,
                          onChanged: (value) {
                            setState(() {
                              storage = value;
                            });
                          },
                          isDark: isDark,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        _buildSwitchTile(
                          title: "Commodity Derivatives",
                          subtitle: "Get access to derivative trading",
                          value: location,
                          onChanged: (value) {
                            setState(() {
                              location = value;
                            });
                          },
                          isDark: isDark,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        _buildSwitchTile(
                          title: "Debt",
                          subtitle: "Get access to derivative trading",
                          value: smsreading,
                          onChanged: (value) {
                            setState(() {
                              smsreading = value;
                            });
                          },
                          isDark: isDark,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        _buildSwitchTile(
                          title: "Currency",
                          subtitle: "Get access to derivative trading",
                          value: notification,
                          onChanged: (value) {
                            setState(() {
                              notification = value;
                            });
                          },
                          isDark: isDark,
                        ),
                        SizedBox(height: 15.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
      {required String title,
      required String subtitle,
      required bool value,
      required Function(bool) onChanged,
      required bool isDark}) {
    return SizedBox(
      height: 55.h,
      child: ListTile(
        tileColor: isDark ? Color(0xff121413) : Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        title: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                  color: isDark ? Colors.white : Colors.black, fontSize: 13.sp),
            ),
            SizedBox(
              width: 2.w,
            ),
            Visibility(
                visible: value,
                child: SvgPicture.asset(
                  'assets/svgs/verified.svg',
                ))
          ],
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black.withOpacity(0.7),
              fontSize: 11.sp),
        ),
        trailing: CustomToggleSwitch(
          initialValue: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
