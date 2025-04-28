import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:confetti/confetti.dart'; // Import the confetti package
import 'package:sapphire/screens/home/homeWarpper.dart';
import 'package:sapphire/utils/constWidgets.dart';

import '../../main.dart';
import 'mPinScreen.dart';

class CongratulationsScreen extends StatefulWidget {
  const CongratulationsScreen({super.key});

  @override
  State<CongratulationsScreen> createState() => _CongratulationsScreenState();
}

class _CongratulationsScreenState extends State<CongratulationsScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    _confettiController
        .play(); // Automatically play confetti animation on screen load
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 46,
        leading: Padding(
          padding: EdgeInsets.only(left: 0),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "Congratulations {user.Name} 🎉 !",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "Your Sapphire account is now set up and ready to go. Time to start your investment journey!",
                    style: TextStyle(
                        color: Color(0xFFC9CACC),
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                      width: 130.w,
                      height: 15.h,
                      child: Image.asset("assets/images/line.png")),
                  SizedBox(height: 32.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff121413),
                              borderRadius: BorderRadius.circular(12.r)),
                          height: 271.h,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 65.h,
                                width: 65.w,
                                child: Image.asset("assets/images/profile.png"),
                              ),
                              SizedBox(height: 30.h),
                              RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(text: "Your Client Code is"),
                                      TextSpan(
                                          text: " J08596",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400)),
                              ),
                              Text(
                                "Get started and make your money\nwork for you!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  constWidgets.greenButton("Login to Terminal", onTap: () {
                    navi(MpinScreen(), context);
                  }),
                  SizedBox(height: 25.h),
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality:
                    BlastDirectionality.explosive, // Ensures uniform spread
                emissionFrequency: 0.0001, // Set very low to fire all at once
                numberOfParticles: 100, // Fixed number of confetti pieces
                gravity: 0.2, // Light gravity for slow fall
                maxBlastForce: 11, // Adjust for explosion strength
                minBlastForce: 10,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.yellow,
                  Colors.red,
                  Colors.orange,
                  Colors.purple,
                  Colors.teal
                ],
              )),
        ],
      ),
    );
  }
}
