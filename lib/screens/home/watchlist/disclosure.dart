import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/home/homeWarpper.dart';
import 'package:sapphire/screens/home/watchlist/watchlistScreen.dart';
import 'package:sapphire/utils/naviWithoutAnimation.dart';
import 'package:url_launcher/url_launcher.dart';

class Disclosure extends StatefulWidget {
  const Disclosure({super.key});

  @override
  State<Disclosure> createState() => _DisclosureState();
}

class _DisclosureState extends State<Disclosure> {
  bool isButtonEnabled = false; // Track button state
  int countdown = 1; // Timer countdown
  int maxCountdown = 1;
  late Timer _buttonTimer;

  @override
  void initState() {
    super.initState();
    _startButtonTimer();
  }

  // Timer to enable the button after 3 seconds and show countdown on button
  void _startButtonTimer() {
    _buttonTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        setState(() {
          isButtonEnabled = true;
        });
        _buttonTimer.cancel();
      }
    });
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    double progress = (maxCountdown - countdown) / maxCountdown;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: isDark ? Colors.black : Colors.white,
        title: Text(
          "Risk Disclosure on Derivatives",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Column(
        children: [
          // Centered content
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 170.h, horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildBulletPoint(
                          "9 out of 10 individual traders in the equity Futures and Options Segment incurred net losses.",
                          isDark),
                      _buildBulletPoint(
                          "On average, loss-makers registered a net trading loss close to ₹50,000.",
                          isDark),
                      _buildBulletPoint(
                          "Over and above the net trading losses incurred, loss-makers expended an additional 28% of net trading losses as transaction costs.",
                          isDark),
                      _buildBulletPoint(
                          "Those making net trading profits incurred between 15% to 50% of such profits as transaction costs.",
                          isDark),
                      SizedBox(height: 15.h),
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: "Source: ",
                          style: TextStyle(
                            color: isDark ? Colors.white54 : Colors.black54,
                            fontSize: 12.sp,
                          ),
                          children: [
                            TextSpan(
                              text: "SEBI study",
                              style: TextStyle(
                                  color: Color(0xFF1DB954),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                  fontFamily: 'Asfro'),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _launchURL(
                                      'https://www.sebi.gov.in/reports-and-statistics/research/jan-2023/study-analysis-of-profit-and-loss-of-individual-traders-dealing-in-equity-fando-segment_67525.html');
                                },
                            ),
                            TextSpan(
                              text:
                                  " dated January 25, 2023, on \"Analysis of Profit and Loss of Individual Traders dealing in equity Futures and Options (F&O) Segment\", wherein Aggregate Level findings are based on annual Profit/Loss incurred by individual traders in equity F&O during FY 2021-22.",
                              style: TextStyle(
                                color: isDark ? Colors.white54 : Colors.black54,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Animated button at the bottom
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Stack(
              children: [
                // Animated green background progress
                Container(
                  width: 350.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: Colors.grey[800],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.r),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            naviWithoutAnimation(context, HomeWrapper());
                          },
                          child: Container(
                            width: 350.w,
                            height: 45.h,
                            color: Color(0xFF1DB954),
                            child: Center(
                                child: Text(
                              "UNDERSTOOD",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.sp),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Button with transparent style to show progress behind
                // Container(
                //   width: 350.w,
                //   height: 45.h,
                //   child: ElevatedButton(
                //     onPressed: isButtonEnabled
                //         ? () {
                //             navi(HomeWrapper(), context);
                //           }
                //         : null,
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.transparent,
                //       shadowColor: Colors.transparent,
                //       disabledBackgroundColor: Colors.transparent,
                //       surfaceTintColor: Colors.transparent,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(5.r),
                //       ),
                //     ),
                //     child: Text(
                //       // isButtonEnabled ? "UNDERSTOOD" : "UNDERSTOOD",
                //       "UNDERSTOOD",
                //       style: GoogleFonts.poppins(
                //         color: Colors.white,
                //         fontSize: 16.sp,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text, bool isDark) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Icon(
                Icons.fiber_manual_record,
                color: isDark ? Colors.white : Colors.black,
                size: 8.sp,
              ),
            ),
            SizedBox(width: 8.w),
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 14.sp,
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
