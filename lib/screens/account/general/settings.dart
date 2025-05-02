import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/account/general/2FA.dart';
import 'package:sapphire/screens/account/general/permission.dart';
import 'package:sapphire/screens/account/general/sessionManagement.dart';
import 'package:sapphire/screens/account/general/settingsOrderPreference.dart';
import 'package:sapphire/themeProvider.dart';
import 'package:sapphire/utils/toggle.dart';

import 'package:sapphire/utils/constWidgets.dart';

class settingsScreen extends StatefulWidget {
  const settingsScreen({super.key});

  @override
  State<settingsScreen> createState() => _settingsScreenState();
}

class _settingsScreenState extends State<settingsScreen> {
  bool biometricAuth = false;
  bool orderNotification = false;
  bool tradeNotification = false;
  bool tradeRecommendation = false;
  bool promotion = false;
  bool isDarkTheme = true;
  String selectedOption = "TradingView"; // Ensuring state persistence

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            isDark ? Colors.black : Colors.white, // or your desired color
        elevation: 0,
        scrolledUnderElevation: 0, // prevent shadow when scrolling
        leadingWidth: 32.w,
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Settings",
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
            icon: Icon(Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(15.h), // Height of the divider
          child: Divider(
            color: isDark
                ? const Color(0xff2F2F2F)
                : const Color(0xffD1D5DB), // Color for the divider
            // thickness: 1, // Divider thickness
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xff121413)
                            : const Color(0xffF4F4F9),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.w),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 34.h,
                                  width: 2.w,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 20.w),
                                Text(
                                  "Theme",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 20.w),

                                /// Light button wrapped with GestureDetector
                                GestureDetector(
                                  onTap: () {
                                    // Provider.of<ThemeProvider>(context,
                                    //         listen: false)
                                    //     .setTheme(ThemeMode.light);
                                  },
                                  child: constWidgets.choiceChip(
                                    "Light",
                                    !isDarkTheme,
                                    context,
                                    130.w,
                                    isDark,
                                  ),
                                ),

                                SizedBox(width: 15.w),

                                /// Dark button wrapped with GestureDetector
                                GestureDetector(
                                  onTap: () {
                                    // Provider.of<ThemeProvider>(context,
                                    //         listen: false)
                                    //     .setTheme(ThemeMode.dark);
                                  },
                                  child: constWidgets.choiceChip(
                                    "Dark",
                                    isDarkTheme,
                                    context,
                                    130.w,
                                    isDark,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    /// Biometric Authentication Switch
                    Container(
                      width: double.infinity,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xff121413)
                            : const Color(0xffF4F4F9),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: _buildSwitchTile(
                        title: "Biometric Authentication",
                        value: biometricAuth,
                        onChanged: (value) {
                          setState(() {
                            biometricAuth = value;
                          });
                        },
                        isDark: isDark,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    /// Other Settings
                    _buildListTile("Order preference",
                        "Set default order types and trading settings", () {
                      navi(SettingsOrderPreference(), context);
                    }, isDark),
                    SizedBox(height: 12.h),

                    _buildListTile("Two Factor Authentication (2FA)",
                        "Add extra security to your account", () {
                      navi(twoFAScreen(), context);
                    }, isDark),
                    SizedBox(height: 12.h),

                    _buildListTile(
                        "Session Management", "View and manage active sessions",
                        () {
                      navi(SessionManagement(), context);
                    }, isDark),
                    SizedBox(height: 12.h),

                    _buildListTile("Permissions",
                        "Control access and authorization settings", () {
                      navi(permissionScreen(), context);
                    }, isDark),
                    SizedBox(height: 12.h),

                    /// Charts Selection
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xff121413)
                              : const Color(0xffF4F4F9),
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.w),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 34.h,
                                  width: 2.w,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  "Charts",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          isDark ? Colors.white : Colors.black),
                                )
                              ],
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildOptionCard("TradingView",
                                    "assets/images/tradingview.png", isDark),
                                SizedBox(width: 16.w),
                                _buildOptionCard("ChartIQ",
                                    "assets/images/ChartIQ.png", isDark),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    /// Notifications Section
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xff121413)
                              : const Color(0xffF4F4F9),
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.w),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 34.h,
                                  width: 2.w,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  "Notification",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          isDark ? Colors.white : Colors.black),
                                )
                              ],
                            ),
                            _buildSwitchTile(
                              title: "Order Notification",
                              subtitle: "Get alerts on order placement",
                              value: orderNotification,
                              onChanged: (value) {
                                setState(() {
                                  orderNotification = value;
                                });
                              },
                              isDark: isDark,
                            ),
                            _buildSwitchTile(
                              title: "Trade Notifications",
                              subtitle: "Receive trade completion alerts",
                              value: tradeNotification,
                              onChanged: (value) {
                                setState(() {
                                  tradeNotification = value;
                                });
                              },
                              isDark: isDark,
                            ),
                            _buildSwitchTile(
                              title: "Trade Recommendations",
                              subtitle: "Get expert trade suggestions",
                              value: tradeRecommendation,
                              onChanged: (value) {
                                setState(() {
                                  tradeRecommendation = value;
                                });
                              },
                              isDark: isDark,
                            ),
                            _buildSwitchTile(
                                title: "Promotion",
                                subtitle: "Stay updated on offers and features",
                                value: promotion,
                                onChanged: (value) {
                                  setState(() {
                                    promotion = value;
                                  });
                                },
                                isDark: isDark),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    /// Delete Account
                    Container(
                      height: 60.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: isDark ? Color(0xff121413) : Color(0xffF4F4F9),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delete Account",
                            style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontSize: 15.sp),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded,
                              color: isDark ? Colors.white : Colors.black,
                              size: 16.sp),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper Methods for Switch Tile
  Widget _buildSwitchTile({
    required String title,
    String? subtitle,
    required bool value,
    required Function(bool) onChanged,
    required bool isDark,
  }) {
    return SizedBox(
      height: 60.h,
      child: Center(
        child: ListTile(
            tileColor: isDark ? Colors.black : Color(0xffF4F4F9),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            title: Text(title,
                style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 13.sp)),
            subtitle: subtitle != null
                ? Text(subtitle,
                    style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black,
                        fontSize: 11.sp))
                : null,
            trailing: CustomToggleSwitch(
              initialValue: false,
              onChanged: (value) {
                print('Toggle is now: $value');
              },
            )),
      ),
    );
  }

  /// Helper Method for List Tiles
  Widget _buildListTile(
      String title, String subtitle, VoidCallback onTap, bool isDark) {
    return Container(
      height: 60.h,
      child: Center(
        child: ListTile(
          tileColor: isDark ? Color(0xff121413) : Color(0xffF4F4F9),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Ensures no extra spacing
            children: [
              Text(title,
                  style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 13.sp)),
              SizedBox(height: 2.h), // Ensures they stick together
              Text(subtitle,
                  style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black,
                      fontSize: 11.sp)),
            ],
          ),
          trailing: Icon(Icons.arrow_forward_ios,
              color: isDark ? Colors.white : Colors.black, size: 16.sp),
          onTap: onTap,
        ),
      ),
    );
  }

  /// Helper Method for Radio Buttons
  Widget _buildOptionCard(String title, String logoPath, bool isDark) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = title;
        });
      },
      child: Container(
        width: 155.w,
        height: 80.h,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedOption == title
                ? Colors.green
                : isDark
                    ? Colors.grey
                    : const Color(0xFFD1D5DB),
            width: 2.w,
          ),
          borderRadius: BorderRadius.circular(8.r),
          color: isDark ? const Color(0xff121413) : const Color(0xffF4F4F9),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  logoPath, // ✅ Replaced Text with Image
                  height: 30.h, // Adjust height as needed
                  width: 30.w, // Adjust width as needed
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(title,
                    style:
                        TextStyle(color: isDark ? Colors.white : Colors.black)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selectedOption == title
                          ? Colors.green
                          : Colors.grey.shade500,
                      width: 2.5.w,
                    ),
                    color: selectedOption == title
                        ? Colors.green
                        : Colors.transparent, // Outer circle color
                  ),
                  child: selectedOption == title
                      ? Center(
                          child: Container(
                            width: 12.w,
                            height: 12.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDark
                                  ? const Color(0xff121413)
                                  : const Color(
                                      0xffF4F4F9), // Inner filled circle when selected
                            ),
                          ),
                        )
                      : null,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
