// File: selfieConfirmation.dart
// Description: Selfie confirmation screen in the Sapphire Trading application.
// This screen displays the captured selfie image and allows users to either confirm
// and proceed or retake the selfie if needed.

import 'dart:io'; // For file operations to display captured image
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:sapphire/main.dart'; // App-wide navigation utilities
import 'package:sapphire/screens/auth/signUp/signature/signature.dart'; // Next screen in flow

/// SelfieConfirmationScreen - Screen for reviewing and confirming the captured selfie
/// Displays the captured image and provides options to proceed or retake the photo
class SelfieConfirmationScreen extends StatelessWidget {
  // Path to the captured selfie image file
  final String imagePath;

  /// Constructor requiring the path to the captured selfie image
  SelfieConfirmationScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      // App bar with confirmation instruction
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(left: 0),
          child: IconButton(
            icon: Icon(Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black),
            onPressed: () {
              Navigator.pop(context); // Navigate back to previous screen
            },
          ),
        ),
        title: Text("Click Continue to Confirm",
            style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 20.sp)),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min, // Commented out in original code
            children: [
              SizedBox(
                height: 50.h,
              ),
              // Instruction Text (placeholder comment from original code)
    
              SizedBox(height: 20.h),
    
              // Display the captured selfie image in a bordered container
              Center(
                child: Container(
                  width: 350.w,
                  height: 350.h, // Square shape for consistent display
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white,
                        width: 3.w), // White border for emphasis
                    borderRadius: BorderRadius.circular(
                        8.r), // Rounded corners for visual appeal
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        8.r), // Match container's rounded corners
                    child: Image.file(
                      File(imagePath), // Load image from file path
                      fit: BoxFit
                          .cover, // Scale image to fill container while maintaining aspect ratio
                    ),
                  ),
                ),
              ),
    
              // Push buttons to bottom of screen
              const Spacer(),
    
              // Action buttons row with Retake and Continue options
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Retake button - returns to camera screen
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(
                            context); // Go back to selfie capture screen
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color:
                                Colors.red, // Red for negative/cancel action
                            borderRadius: BorderRadius.circular(6.r)),
                        height: 46.h,
                        child: const Center(
                          child: Text('Retake',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w, // Spacing between buttons
                  ),
                  // Continue button - proceeds to signature verification
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        navi(signVerificationScreen(),
                            context); // Navigate to signature verification screen
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors
                                .green, // Green for positive/confirm action
                            borderRadius: BorderRadius.circular(6.r)),
                        height: 46.h,
                        child: const Center(
                          child: Text('Continue',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h, // Bottom padding
              )
            ],
          ),
        ),
      ),
    );
  }
}
