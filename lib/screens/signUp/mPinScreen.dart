import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/home/homeWarpper.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class MpinScreen extends StatefulWidget {
  const MpinScreen({super.key});

  @override
  State<MpinScreen> createState() => _MpinScreenState();
}

class _MpinScreenState extends State<MpinScreen> {
  final TextEditingController _pinController = TextEditingController();
  String enteredPin = "";
  final LocalAuthentication _auth = LocalAuthentication();

  void _onKeyPressed(String value) {
    if (value == "back" && enteredPin.isNotEmpty) {
      setState(() {
        enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      });
    } else if (value == "submit") {
      navi(HomeWrapper(), context);
    } else if (enteredPin.length < 4) {
      setState(() {
        enteredPin += value;
      });
    }
    _pinController.text = enteredPin;
  }

  Future<bool> _canAuthenticate() async {
    if (kIsWeb) return false;
    try {
      return await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
    } catch (e) {
      print("Error checking biometrics: $e");
      return false;
    }
  }

  Future<void> _authenticate() async {
    try {
      bool authenticated = await _auth.authenticate(
        localizedReason: Platform.isAndroid
            ? 'Scan your fingerprint to authenticate'
            : 'Scan your face to authenticate',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      if (authenticated) {
        navi(HomeWrapper(), context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Authentication failed',
              style: TextStyle(fontSize: 14.sp, color: Colors.white),
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      String errorMessage;
      if (e.toString().contains(auth_error.notEnrolled)) {
        errorMessage = 'Please set up biometrics in your device settings';
      } else if (e.toString().contains(auth_error.notAvailable)) {
        errorMessage = 'This device does not support biometric authentication';
      } else {
        errorMessage = 'An error occurred during authentication';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            style: TextStyle(fontSize: 14.sp, color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 35.h),
            Image.asset(
              "assets/images/whiteLogo.png",
              scale: 0.7,
            ),
            SizedBox(height: 20.h),
            Text(
              "Nakul Pratap Thakur",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 21.sp,
                color: Colors.white,
              ),
            ),
            Text(
              "J098WE",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15.sp,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 30.h),
            Pinput(
              length: 4,
              controller: _pinController,
              obscureText: true,
              enabled: false,
              separatorBuilder: (index) => SizedBox(width: 12.w),
              defaultPinTheme: PinTheme(
                width: 50.w,
                height: 50.h,
                textStyle: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              focusedPinTheme: PinTheme(
                width: 50.w,
                height: 50.h,
                textStyle: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            FutureBuilder<bool>(
              future: _canAuthenticate(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox.shrink();
                }
                bool canAuthenticate = snapshot.data ?? false;
                if (!canAuthenticate) {
                  return SizedBox.shrink();
                }
                return GestureDetector(
                  onTap: _authenticate,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Platform.isAndroid
                            ? "Use Fingerprint"
                            : Platform.isIOS
                                ? "Use Face ID"
                                : "Use Biometric",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 7.w),
                      SvgPicture.asset(
                        Platform.isAndroid
                            ? "assets/svgs/fingerprint.svg"
                            : Platform.isIOS
                                ? "assets/svgs/face.svg"
                                : "assets/svgs/face.svg",
                        width: 20.w,
                        colorFilter: ColorFilter.mode(
                          Colors.green,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Spacer(),
            buildKeypad(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget buildKeypad() {
    List<String> keys = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "back",
      "0",
      "submit"
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: keys.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 50,
          crossAxisCount: 3,
          crossAxisSpacing: 20.w,
          mainAxisSpacing: 15.h,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _onKeyPressed(keys[index]),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: keys[index] == "back"
                  ? Icon(Icons.backspace, color: Colors.green, size: 28)
                  : keys[index] == "submit"
                      ? InkWell(
                          onTap: () {
                            naviRep(HomeWrapper(), context);
                          },
                          child:
                              Icon(Icons.check, color: Colors.green, size: 30))
                      : Text(
                          keys[index],
                          style: TextStyle(
                            fontSize: 22.sp,
                            color: Colors.green,
                          ),
                        ),
            ),
          );
        },
      ),
    );
  }
}
