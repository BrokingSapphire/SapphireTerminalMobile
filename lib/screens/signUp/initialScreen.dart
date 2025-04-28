import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/signUp/emailScreen.dart';
import 'package:sapphire/screens/signUp/loginScreen.dart';
import 'package:sapphire/utils/constWidgets.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/whiteLogo.png',
                  color: isDark ? Colors.white : Colors.black,
                  scale: 1,
                ),
                // SvgPicture.asset("assets/svgs/Logo.svg",
                //     color: isDark ? Colors.white : Colors.black),
                SizedBox(width: 10.w),
                Text(
                  "Sapphire",
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Text(
              "Welcome to Sapphire Terminal",
              style: TextStyle(
                fontSize: 21.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 300.h),
            constWidgets.greenButton("LOG IN", onTap: () {
              navi(const LoginScreen(), context);
            }),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: isDark
                        ? const Color(0xFF2F2F2F)
                        : const Color(0xFFD1D5DB),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    "OR",
                    style: TextStyle(
                      color:
                          isDark ? Colors.grey[400] : const Color(0xFFC9CACC),
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: isDark
                        ? const Color(0xFF2F2F2F)
                        : const Color(0xFFD1D5DB),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            constWidgets.greenButton("SIGN UP", onTap: () {
              navi(const EmailScreen(), context);
            }),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                "© 2025 Sapphire Broking. SEBI Registered Stock Broker | Member: NSE, BSE, MCX, NCDEX. Investments are subject to market risks. Read all documents carefully. Disputes subject to Nagpur jurisdiction.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: isDark ? Colors.grey[500] : const Color(0xFF9B9B9B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
