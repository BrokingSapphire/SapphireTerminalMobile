import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:sapphire/main.dart';
import 'package:scribble/scribble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'SignConfirmationScreen.dart';

class SignCanvasScreen extends StatefulWidget {
  @override
  _SignCanvasScreenState createState() => _SignCanvasScreenState();
}

class _SignCanvasScreenState extends State<SignCanvasScreen> {
  late ScribbleNotifier _scribbleNotifier;

  @override
  void initState() {
    super.initState();
    _scribbleNotifier = ScribbleNotifier();
  }

  Future<void> _saveSignature() async {
    try {
      ByteData? byteData = await _scribbleNotifier.renderImage();
      if (byteData != null) {
        Uint8List signatureBytes = byteData.buffer.asUint8List();
        navi(SignConfirmationScreen(signatureBytes: signatureBytes), context);
      }
    } catch (e) {
      print("Error saving signature: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leadingWidth: 46,
        leading: Padding(
          padding: EdgeInsets.only(left: 0),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 620.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.white24),
              ),
              child: Scribble(
                notifier: _scribbleNotifier,
                drawPen: true,
              ),
            ),
            SizedBox(height: 20.h),
            ValueListenableBuilder(
              valueListenable: _scribbleNotifier,
              builder: (context, state, _) {
                final isCanvasEmpty = state.lines.isEmpty;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed:
                            isCanvasEmpty ? null : _scribbleNotifier.clear,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Color(0xFF26382F),
                          side: BorderSide(color: Colors.green),
                          foregroundColor: Colors.white,
                          disabledForegroundColor: Colors.grey,
                          disabledBackgroundColor:
                              Color(0xFF26382F).withOpacity(0.5),
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
                    Expanded(
                      child: ElevatedButton(
                        onPressed: isCanvasEmpty ? null : _saveSignature,
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
