import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/utils/toogle.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // or your desired color
        elevation: 0,
        scrolledUnderElevation: 0, // prevent shadow when scrolling
        surfaceTintColor: Colors.transparent,
        leadingWidth: 32.w,

        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Active Segments",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
      ),
      body: Column(
        children: [
          Divider(color: Color(0xff2F2F2F)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 15.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff121413), // Card background color
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

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SizedBox(
      height: 55.h,
      child: ListTile(
        tileColor: Color(0xff121413),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 13.sp),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.white70, fontSize: 11.sp),
        ),
        trailing: CustomToggleSwitch(
          initialValue: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
