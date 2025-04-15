import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/home/watchlist/disclosure.dart';
import 'package:sapphire/utils/constWidgets.dart';
import 'package:sapphire/utils/naviWithoutAnimation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController clientId = TextEditingController();
  TextEditingController password = TextEditingController();
  bool rememberMe = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Center(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0.w),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 40.h),
                          Image.asset("assets/images/whiteLogo.png",
                              scale: 0.7),
                          SizedBox(height: 30.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome",
                                  style: TextStyle(
                                      fontSize: 34.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 17.h),
                                Text(
                                  "Login to your account",
                                  style: TextStyle(
                                      fontSize: 21.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 42.h),

                          /// Client ID Field
                          TextFormField(
                            controller: clientId,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              labelText: "Client ID",
                              labelStyle: TextStyle(color: Color(0xffC9CACC)),
                              hintStyle: TextStyle(
                                  color: Color(0xFFC9CACC), fontSize: 15.sp),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.r)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.r)),
                                borderSide:
                                    BorderSide(color: Color(0XFF2F2F2F)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.r)),
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2.0),
                              ),
                              prefixIcon: Padding(
                                padding:
                                    EdgeInsets.only(left: 16.w, right: 12.w),
                                child: SvgPicture.asset(
                                  'assets/svgs/user.svg',
                                  height: 20.h,
                                  width: 20.w,
                                  color: Color(0xffC9CACC),
                                ),
                              ),
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 40.w),
                            ),
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.sp),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Client ID';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 24.h),

                          /// Password Field
                          // constWidgets.textField("Password", password),
                          TextFormField(
                            controller: password,
                            obscureText: !isPasswordVisible,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              labelText: "Password",
                              labelStyle: TextStyle(color: Color(0xffC9CACC)),
                              hintStyle: TextStyle(
                                  color: Color(0xFFC9CACC), fontSize: 15.sp),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.r)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.r)),
                                borderSide:
                                    BorderSide(color: Color(0XFF2F2F2F)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.r)),
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2.0),
                              ),
                              prefixIcon: Padding(
                                padding:
                                    EdgeInsets.only(left: 16.w, right: 12.w),
                                child: SvgPicture.asset(
                                  'assets/svgs/key.svg',
                                  height: 20.h,
                                  width: 20.w,
                                  color: Color(0xffC9CACC),
                                ),
                              ),
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 40.w),

                              /// 👁️ Eye Toggle Button
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 16.w),
                                  child: SvgPicture.asset(
                                    isPasswordVisible
                                        ? 'assets/svgs/eye-off.svg' // 👁️ closed
                                        : 'assets/svgs/eye.svg', // 👁️ open
                                    height: 20.h,
                                    width: 20.w,
                                    color: Color(0xffC9CACC),
                                  ),
                                ),
                              ),
                              suffixIconConstraints:
                                  BoxConstraints(minWidth: 40.w),
                            ),
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.sp),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),

                          /// Remember Me
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Align(
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        rememberMe = !rememberMe;
                                      });
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomCheckbox(
                                          size: 17,
                                          value: rememberMe,
                                          onChanged: (val) {
                                            setState(() {
                                              rememberMe = !rememberMe;
                                            });
                                          },
                                        ),
                                        SizedBox(width: 12.w),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15.h),
                                          child: Text(
                                            "Remember Me",
                                            style: TextStyle(fontSize: 11.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(child: SizedBox()),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),

                          /// Continue Button
                          constWidgets.greenButton("Continue", onTap: () {
                            naviWithoutAnimation(context, Disclosure());
                          }),
                          SizedBox(height: 24.h),

                          /// Trouble logging in
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.green,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.green,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 110.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25.0),
                            child: Text(
                              "© 2025 Sapphire Broking. SEBI Registered Stock Broker | Member: NSE, BSE, MCX, NCDEX. Investments are subject to market risks. Read all documents carefully. Disputes subject to Nagpur jurisdiction.",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 13.sp, color: Color(0xFF9B9B9B)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Bottom Spacer & Disclaimer (unchanged)
                  // Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
