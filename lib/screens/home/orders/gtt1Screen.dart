import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/home/orders/gtt2Screen.dart';

class gtt1Screen extends StatefulWidget {
  const gtt1Screen({super.key});

  @override
  _gtt1ScreenState createState() => _gtt1ScreenState();
}

class _gtt1ScreenState extends State<gtt1Screen> {
  bool isPlacedOrderSelected = true; // Track selected button

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leadingWidth: 38,
        title:
            Text("GTT", style: TextStyle(color: Colors.white, fontSize: 15.sp)),
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(1.h), // Controls the height of the divider
          child: Divider(
            color: Colors.grey.shade800, // Light grey divider for contrast
            thickness: 1, // Divider thickness
            height: 1, // Ensures it sticks to the bottom of the AppBar
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "You currently have no active GTT orders",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.center, // Aligns the text to the center
                child: Text(
                  "GTT orders remain active for one year until your \n specified conditions are met, eliminating the need for constant monitoring or adjustments.",
                  style: TextStyle(color: Color(0xffc9cacc), fontSize: 13.sp),
                  textAlign:
                      TextAlign.center, // Ensures text content is centered
                ),
              ),

              SizedBox(height: 20.h),

              // Selectable Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSelectableButton(
                    title: "Placed GTT Order",
                    isSelected: isPlacedOrderSelected,
                    onTap: () {
                      setState(() {
                        isPlacedOrderSelected = true;
                      });
                    },
                  ),
                  SizedBox(width: 15.w),
                  _buildSelectableButton(
                    title: "GTT History",
                    isSelected: !isPlacedOrderSelected,
                    onTap: () {
                      setState(() {
                        isPlacedOrderSelected = false;
                      });
                      navi(gtt2Screen(), context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectableButton(
      {required String title,
      required bool isSelected,
      required VoidCallback onTap}) {
    return SizedBox(
      height: 42.h,
      width: 160.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? Color(0xff1db954)
              : Colors.black, // Change color based on selection
          side: BorderSide(color: Colors.green, width: 2), // Green border
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: TextStyle(
              color: isSelected ? Colors.white : Colors.green, fontSize: 14.sp),
        ),
      ),
    );
  }
}
