import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapphire/utils/constWidgets.dart';

class ReferAFriend extends StatefulWidget {
  const ReferAFriend({super.key});

  @override
  State<ReferAFriend> createState() => _ReferAFriendState();
}

class _ReferAFriendState extends State<ReferAFriend> {
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDark ? Colors.white : Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        leadingWidth: 24.w,
        title: Text(
          "Refer a friend",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Divider(
            color: isDark ? Color(0xFF2F2F2F) : Color(0xffD1D5DB),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 28.h),

                  SvgPicture.asset(
                    "assets/svgs/referFriend.svg",
                    width: 137.w,
                    height: 96.h,
                    colorFilter: ColorFilter.mode(
                        isDark ? Colors.white : Colors.black, BlendMode.srcIn),
                  ),
                  SizedBox(height: 38.h),

                  // Main Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      'Invite your friends and family to join and earn 300 reward points on every referral!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Sub Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      'Use your points to unlock premium features or enjoy free AMC.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark ? Color(0xFFC9CACC) : Colors.black54,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h),

                  // Invite Code Box with Dotted Border
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Your Invite Code",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: isDark ? Color(0xffEBEEF5) : Colors.black),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(3.r),
                      color: isDark
                          ? Color(0xffB8DBD94D).withOpacity(0.3)
                          : Colors.black87,
                      dashPattern: [12, 4],
                      strokeWidth: 1,
                      child: Container(
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: isDark ? Color(0xff121413) : Color(0xffF4F4F9),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'JH04-HBJ6-WL2A-YJ7F',
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontSize: 13.sp,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(
                                    ClipboardData(text: 'JH04-HBJ6-WL2A-YJ7F'));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('COPIED!')),
                                );
                              },
                              child: Text(
                                'COPY',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),

                  // Share Button (Using Expanded/Spacer)
                  const Spacer(),
                  // GestureDetector(
                  //   onTap: () {
                  //     // Handle Share Invite Link
                  //   },
                  //   child: Container(
                  //     width: double.infinity,
                  //     padding: EdgeInsets.symmetric(
                  //         vertical: 12.h, horizontal: 24.w),
                  //     decoration: BoxDecoration(
                  //       color: Colors.green,
                  //       borderRadius: BorderRadius.circular(6),
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         "Share Invite Link",
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 16.sp),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  constWidgets.greenButton(
                    "Share Invite Link",
                    onTap: () {},
                  ),

                  // Learn More Link
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: GestureDetector(
                      onTap: () {
                        // Implement learn more navigation
                      },
                      child: Text(
                        'Learn more',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
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
}

// CustomPainter for Dotted Border
