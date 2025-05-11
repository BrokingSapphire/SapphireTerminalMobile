import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/account/general/settings/deleteAccount/confirmDeleteAccount.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 32.w,
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Delete Account",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
                color: isDark ? Colors.white : Colors.black),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black,
              )),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  // Delete icon with circle
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: const Color(0xffF37E7E).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        CupertinoIcons.delete,
                        color: Colors.red,
                        size: 24.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // Delete Account title
                  Text(
                    "Delete Account",
                    style: TextStyle(
                      color: isDark ? Color(0xffEBEEF5) : Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  // Warning text
                  Text(
                    "Are you sure you want to permanently delete your account? Once you delete it, you won't be able to get it back, and all your data and settings will be gone forever.",
                    style: TextStyle(
                      color: const Color(0xffC9CACC),
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(height: 18.h),
                  // Note section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Note:",
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        "Once your account is successfully deleted, you will not be able to create a new account using the same details for the next 180 days.",
                        style: TextStyle(
                          color: const Color(0xffC9CACC),
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  // Checkbox
                  Row(
                    children: [
                      SizedBox(
                        width: 24.w,
                        height: 24.h,
                        child: Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          "I understand that I won't be able to recover my account",
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  // Bottom buttons
                  Row(
                    children: [
                      // Delete button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isChecked
                              ? () {
                                  // Handle delete action
                                 navi(ConfirmDeleteScreen(), context);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            disabledBackgroundColor:
                                Colors.red.withOpacity(0.5),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          child: Text(
                            "Delete",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      // Cancel button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff1E1E1E),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              side: const BorderSide(
                                color: Color(0xff2f2f2f), // Border color
                                width: 1, // Border width
                              ),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
