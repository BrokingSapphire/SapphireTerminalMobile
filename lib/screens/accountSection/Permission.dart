import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/utils/toogle.dart';

class permissionScreen extends StatefulWidget {
  const permissionScreen({super.key});

  @override
  State<permissionScreen> createState() => _permissionScreenState();
}

class _permissionScreenState extends State<permissionScreen> {
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
            "Permissions",
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
                    height: 435.h,
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                    decoration: BoxDecoration(
                      color: Color(0xff121413), // Card background color
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildSwitchTile(
                          title: "Internet",
                          subtitle:
                              "Enables live market data, trade execution, and portfolio updates.",
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
                          title: "Storage",
                          subtitle:
                              "Saves trade reports, account statements, and contract notes.",
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
                          title: "Location",
                          subtitle:
                              "Ensures secure login by verifying user location as per SEBI regulations.",
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
                          title: "SMS Reading",
                          subtitle:
                              "Auto-fetches OTPs for secure logins and transactions.",
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
                          title: "Notification",
                          subtitle:
                              "Sends real-time trade alerts and order execution updates.",
                          value: notification,
                          onChanged: (value) {
                            setState(() {
                              notification = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        _buildSwitchTile(
                          title: "Biometric",
                          subtitle:
                              "Provides secure logins using fingerprint or Face ID.",
                          value: biometric,
                          onChanged: (value) {
                            setState(() {
                              biometric = value;
                            });
                          },
                        ),
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
