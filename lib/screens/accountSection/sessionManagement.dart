import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SessionManagement extends StatefulWidget {
  const SessionManagement({super.key});

  @override
  State<SessionManagement> createState() => _SessionManagementState();
}

class _SessionManagementState extends State<SessionManagement> {
  void showLogoutDialog(BuildContext context, String deviceName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              Color(0xff121413), // Matches the background in your image
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Center(
            child: Text(
              'Log out of $deviceName',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 21.sp),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'You will lose any saved credentials on that device, and your access to your Sapphire account will be removed.',
                style: TextStyle(color: Color(0xffc9cacc)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              Text(
                'Please note that logging out may take a few minutes.',
                style: TextStyle(color: Color(0xffc9cacc)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss dialog
                // Add logout logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                minimumSize: Size(double.infinity, 40), // Full-width button
              ),
              child: Text("OK",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            SizedBox(height: 8.h),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Just close dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff121413),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  side: BorderSide(
                      color: Color(0xff2f2f2f), width: 1), // Border color
                ),
                minimumSize: Size(double.infinity, 40),
                foregroundColor: Colors.white, // Text color
              ),
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // or your desired color
        elevation: 0,
        scrolledUnderElevation: 0, // prevent shadow when scrolling
        surfaceTintColor: Colors.transparent,
                leadingWidth: 32.w,

        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Session Management",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
      ),
      body: Column(
        children: [
          Divider(
            color: Color(0xff2F2F2F),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Text(
                  "Application session",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10.h),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: Color(0xff121413)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 16.w, right: 16.w, top: 8.h, bottom: 4.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "iPhone 15 Pro Max · your current session",
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Text(
                              "Nagpur, Maharashtra",
                              style: TextStyle(
                                  fontSize: 11.sp, color: Color(0xffc9cacc)),
                            ),
                            SizedBox(width: 18.w), // Space between elements
                            Text(
                              "152.58.87.144",
                              style: TextStyle(
                                  fontSize: 11.sp, color: Color(0xffc9cacc)),
                            ),
                            SizedBox(width: 18.w), // Space between elements
                            Text(
                              "38m ago",
                              style: TextStyle(
                                  fontSize: 11.sp, color: Color(0xffc9cacc)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "iPhone 14 Pro Max",
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  "5d ago",
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Color(0xffc9cacc)),
                                ),
                              ],
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                size: 24.sp,
                              ),
                              onPressed: () {
                                showLogoutDialog(context, 'iphone 15');
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
