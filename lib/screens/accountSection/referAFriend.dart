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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Refer a friend",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const Divider(
            color: Color(0xFF2F2F2F),
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
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  SizedBox(height: 38.h),

                  // Main Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      'Invite your friends and family to join and earn 300 reward points on every referral!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
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
                        color: Color(0xFFC9CACC),
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
                            color: Color(0xffEBEEF5)),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(3.r),
                      color: Colors.white,
                      dashPattern: [12, 4],
                      strokeWidth: 1.5,
                      child: Container(
                        height: 53.h,
                        decoration: BoxDecoration(
                          color: Color(0xff121413),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'JH04-HBJ6-WL2A-YJ7F',
                              style: TextStyle(
                                color: Colors.white,
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
                                  SnackBar(
                                      content: Text('Invite code copied!')),
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
