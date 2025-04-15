import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:sapphire/main.dart';

import 'SelfieConfirmationScreen.dart';

class SelfieVerificationScreen extends StatefulWidget {
  @override
  _SelfieVerificationScreenState createState() =>
      _SelfieVerificationScreenState();
}

class _SelfieVerificationScreenState extends State<SelfieVerificationScreen> {
  CameraController? _cameraController;
  File? _image;
  late List<CameraDescription> _cameras;
  bool _isCapturing = false;
  bool _faceDetected = false;
  Color _borderColor = Colors.red; // Default border color (Red)
  bool _captureEnabled = false; // Capture button state
  bool _processing = false; // To avoid multiple detections at once

  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableClassification: true, // Detect smiling, eyes open
      enableTracking: true, // Track faces for better accuracy
      enableContours: false,
      enableLandmarks: true, // Detect facial landmarks (nose, eyes, etc.)
      minFaceSize: 0.15, // Minimum face size required (smaller faces ignored)
      performanceMode: FaceDetectorMode.accurate, // High accuracy mode
    ),
  );

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();

    // Ensuring FRONT CAMERA is selected
    _cameraController = CameraController(
      _cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front),
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _cameraController!.initialize();
    _startFaceDetection();

    setState(() {});
  }

  void _startFaceDetection() {
    _cameraController!.startImageStream((CameraImage image) async {
      if (_isCapturing || _processing) return;
      _processing = true; // Lock processing

      try {
        final WriteBuffer allBytes = WriteBuffer();
        for (final Plane plane in image.planes) {
          allBytes.putUint8List(plane.bytes);
        }
        final bytes = allBytes.done().buffer.asUint8List();

        final InputImage inputImage = InputImage.fromBytes(
          bytes: bytes,
          metadata: InputImageMetadata(
            size: Size(image.width.toDouble(), image.height.toDouble()),
            rotation: InputImageRotation.rotation270deg, // Adjust for front cam
            format: InputImageFormat.nv21,
            bytesPerRow: image.planes[0].bytesPerRow,
          ),
        );

        final List<Face> faces = await _faceDetector.processImage(inputImage);

        if (faces.isNotEmpty) {
          Face face = faces.first; // Process the first detected face

          // Additional validation for better accuracy
          bool smiling =
              face.smilingProbability != null && face.smilingProbability! > 0.3;
          bool eyesOpen = (face.leftEyeOpenProbability != null &&
                  face.leftEyeOpenProbability! > 0.4) &&
              (face.rightEyeOpenProbability != null &&
                  face.rightEyeOpenProbability! > 0.4);

          if (!_faceDetected && eyesOpen) {
            setState(() {
              _faceDetected = true;
              _borderColor = Colors.green;
              _captureEnabled = true;
            });
          }
        } else {
          if (_faceDetected) {
            setState(() {
              _faceDetected = false;
              _borderColor = Colors.red;
              _captureEnabled = false;
            });
          }
        }
      } catch (e) {
        print("Error processing face detection: $e");
      }

      _processing = false; // Unlock processing for the next frame
    });
  }

  Future<void> _captureSelfie() async {
    if (!_captureEnabled ||
        _isCapturing ||
        !_cameraController!.value.isInitialized) return;

    setState(() {
      _isCapturing = true;
    });

    final XFile photo = await _cameraController!.takePicture();
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = File('${directory.path}/selfie.jpg');
    await photo.saveTo(imagePath.path);

    setState(() {
      _isCapturing = false;
    });

    navi(SelfieConfirmationScreen(imagePath: imagePath.path), context);
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[500], // FIX: Keep background as earlier (Grey)
      appBar: AppBar(
        backgroundColor: Colors.grey[500], // FIX: Grey AppBar as earlier
        title: Text("Take a Quick Photo"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 236.w, // Exact width as per reference
              height: 312.h, // Exact height as per reference
              decoration: BoxDecoration(
                shape: BoxShape
                    .rectangle, // Base is a rectangle to apply border radius
                borderRadius: BorderRadius.all(
                    Radius.elliptical(236.w, 312.h)), // Oval border
                border: Border.all(
                  color:
                      _borderColor, // Red or Green border based on face detection
                  width: 7.w, // Border thickness
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                    Radius.elliptical(236.w, 312.h)), // Ensures proper clipping
                child: _cameraController == null ||
                        !_cameraController!.value.isInitialized
                    ? Center(child: CircularProgressIndicator())
                    : Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..scale(-1.0, 1.0, 1.0), // MIRROR FIX
                        child: Transform.scale(
                          scale: 1.5, // Ensures proper framing within the oval
                          child: AspectRatio(
                            aspectRatio:
                                236 / 312, // Matches the oval's aspect ratio
                            child: RotatedBox(
                              quarterTurns:
                                  3, // Ensures correct orientation for front camera
                              child: CameraPreview(_cameraController!),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ),

          SizedBox(height: 40.h),

          // Instruction Text
          Container(
            height: 90.h,
            width: 260.w,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              _faceDetected
                  ? "Face detected! Tap to capture."
                  : "Ensure your face is visible & eyes open",
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 40.h),

          // Capture Button (Enabled/Disabled based on face detection)
          GestureDetector(
            onTap: _captureEnabled ? _captureSelfie : null,
            child: Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xffD9D9D9), width: 4.w),
                color: _captureEnabled
                    ? Color(0xffD9D9D9)
                    : Colors.transparent, // Grey when disabled
              ),
              child: Center(
                  child: CircleAvatar(
                radius: 35.r,
                backgroundColor: Color(0xffD9D9D9),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
