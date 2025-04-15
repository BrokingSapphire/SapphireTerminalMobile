import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/home/homeWarpper.dart';

class MpinScreen extends StatefulWidget {
  const MpinScreen({super.key});

  @override
  State<MpinScreen> createState() => _MpinScreenState();
}

class _MpinScreenState extends State<MpinScreen> {
  final TextEditingController _pinController = TextEditingController();
  String enteredPin = "";

  void _onKeyPressed(String value) {
    if (value == "back" && enteredPin.isNotEmpty) {
      setState(() {
        enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      });
    } else if (value == "submit") {
      // Handle PIN submission
      navi(HomeWrapper(), context);
    } else if (enteredPin.length < 4) {
      setState(() {
        enteredPin += value;
      });
    }
    _pinController.text = enteredPin;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black, // Dark mode UI
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 35.h,
            ),

            Image.asset(
              "assets/images/whiteLogo.png",
              scale: 0.7,
            ),
            SizedBox(height: 20.h),

            // User Name
            Text(
              "Nakul Pratap Thakur",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 21.sp,
                color: Colors.white,
              ),
            ),

            // Client Code
            Text(
              "J098WE",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15.sp,
                color: Colors.green,
              ),
            ),

            SizedBox(height: 30.h),

            // PIN Input Field
            Pinput(
              length: 4,
              controller: _pinController,
              obscureText: true,
              enabled: false,
              separatorBuilder: (index) =>
                  SizedBox(width: 12.w), // Adds spacing
              defaultPinTheme: PinTheme(
                width: 50.w,
                height: 50.h,
                textStyle: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey, width: 1), // Default border is gray
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              focusedPinTheme: PinTheme(
                width: 50.w,
                height: 50.h,
                textStyle: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white,
                      width: 2), // White border when selected
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // Face ID Authentication
            GestureDetector(
              onTap: () {
                print("Face ID Auth Triggered!");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Use FaceID",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(width: 5.w),
                  Icon(Icons.tag_faces, color: Colors.green, size: 20),
                ],
              ),
            ),

            Spacer(),
            // Numeric Keypad
            buildKeypad(),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  /// Custom Numeric Keypad
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
