import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/signUp/emailScreen.dart';
import 'package:sapphire/screens/signUp/loginScreen.dart';
import 'package:sapphire/screens/signUp/mobileOtp.dart';
import 'package:sapphire/utils/constWidgets.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/whiteLogo.png',
                  scale: 1,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  "Sapphire",
                  style:
                      TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w600),
                )
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "Welcome to Sapphire Terminal",
              style: TextStyle(fontSize: 21.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 300.h,
            ),
            constWidgets.greenButton("LOG IN", onTap: () {
              navi(LoginScreen(), context);
            }),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    "OR",
                    style: TextStyle(color: Color(0xFFC9CACC)),
                  ),
                ),
                Expanded(child: Divider())
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            constWidgets.greenButton("SIGN UP", onTap: () {
              navi(EmailScreen(), context);
            }),
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                "© 2025 Sapphire Broking. SEBI Registered Stock Broker | Member: NSE, BSE, MCX, NCDEX. Investments are subject to market risks. Read all documents carefully. Disputes subject to Nagpur jurisdiction.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11.sp, color: Color(0xFF9B9B9B)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
