// File: signatureCanvas.dart
// Description: Digital signature capture screen in the Sapphire Trading application.
// This screen provides a canvas for users to draw their signature using touch input,
// which will be used for account documents and trading authorization.

import 'dart:typed_data'; // For handling binary data (signature image)
import 'package:flutter/material.dart';
import 'package:sapphire/main.dart'; // App-wide navigation utilities
import 'package:scribble/scribble.dart'; // Package for handling drawing canvas functionality
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling

import 'signatureConfirmation.dart'; // Next screen for signature confirmation

/// SignCanvasScreen - Screen for capturing user's handwritten signature
/// Provides a drawing canvas and controls for creating a digital signature
class SignCanvasScreen extends StatefulWidget {
  @override
  _SignCanvasScreenState createState() => _SignCanvasScreenState();
}

/// State class for the SignCanvasScreen widget
/// Manages the drawing canvas and signature conversion
class _SignCanvasScreenState extends State<SignCanvasScreen> {
  // Scribble notifier for managing the drawing canvas state
  late ScribbleNotifier _scribbleNotifier;

  @override
  void initState() {
    super.initState();
    // Initialize the drawing controller
    _scribbleNotifier = ScribbleNotifier();
  }

  /// Converts the drawn signature to an image and navigates to confirmation screen
  /// Renders the canvas content as a byte array for storage and display
  Future<void> _saveSignature() async {
    try {
      // Render the signature from the canvas as image data
      ByteData? byteData = await _scribbleNotifier.renderImage();
      // Convert ByteData to Uint8List (raw image bytes)
      Uint8List signatureBytes = byteData.buffer.asUint8List();
      // Navigate to confirmation screen with signature data
      navi(SignConfirmationScreen(signatureBytes: signatureBytes), context);
    } catch (e) {
      // Log any errors during signature conversion
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      // App bar with back button
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 46,
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            // Signature drawing canvas - white background for contrast
            Container(
              width: double.infinity,
              height: 620.h,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white
                    : Color(0xFFE3E6EB), // #E3E6EB pad background in light mode
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.white24),
              ),
              child: Scribble(
                notifier: _scribbleNotifier,
                drawPen: true, // Enable pen mode for drawing
              ),
            ),
            SizedBox(height: 20.h),

            // Action buttons for clearing canvas or saving signature
            // Uses ValueListenableBuilder to update button states based on canvas content
            ValueListenableBuilder(
              valueListenable: _scribbleNotifier,
              builder: (context, state, _) {
                // Check if canvas is empty to enable/disable buttons
                final isCanvasEmpty = state.lines.isEmpty;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Clear button - resets the canvas
                    Expanded(
                      child: OutlinedButton(
                        onPressed: isCanvasEmpty
                            ? null
                            : _scribbleNotifier
                                .clear, // Disabled if canvas is empty
                        style: OutlinedButton.styleFrom(
                          backgroundColor:
                              isDark ? Color(0xFF26382F) : Color(0xFFF5F7FA),
                          side: BorderSide(
                              color: isDark ? Colors.green : Color(0xff6B7280)),
                          foregroundColor: isDark ? Colors.white : Colors.black,
                          disabledForegroundColor: Color(0xff6B7280),
                          disabledBackgroundColor:
                              isDark ? Color(0xFF26382F) : Color(0xFFF5F7FA),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          textStyle: TextStyle(fontSize: 16.sp),
                        ),
                        child: Text("Clear"),
                      ),
                    ),
                    SizedBox(width: 30.w),

                    // Save & Continue button - processes the signature and navigates forward
                    Expanded(
                      child: ElevatedButton(
                        onPressed: isCanvasEmpty
                            ? null
                            : _saveSignature, // Disabled if canvas is empty
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Color(0xff2f2f2f),
                          disabledForegroundColor: Color(0xffc9cacc),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          textStyle: TextStyle(fontSize: 16.sp),
                        ),
                        child: Text("Save & Continue"),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
