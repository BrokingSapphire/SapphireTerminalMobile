// File: selfieCamera.dart
// Description: Camera screen for capturing a selfie in the Sapphire Trading application.
// This screen provides real-time face detection, ensures proper facial positioning,
// and validates that the user's eyes are open before enabling capture.

import 'dart:io';
import 'package:camera/camera.dart'; // For camera access and control
import 'package:flutter/foundation.dart'; // For low-level utilities like WriteBuffer
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'; // For file system access
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart'; // ML Kit for face detection
import 'package:sapphire/main.dart'; // App-wide navigation utilities
import 'selfieConfirmation.dart'; // Next screen in selfie verification flow

/// SelfieVerificationScreen - Camera interface for capturing user selfie
/// Uses ML Kit to detect faces and validate proper positioning
/// Part of the KYC verification process
class SelfieVerificationScreen extends StatefulWidget {
  @override
  _SelfieVerificationScreenState createState() =>
      _SelfieVerificationScreenState();
}

/// State class for the SelfieVerificationScreen widget
/// Manages camera, face detection, and selfie capture process
class _SelfieVerificationScreenState extends State<SelfieVerificationScreen> {
  CameraController? _cameraController; // Controls the camera device
  File? _image; // Stores the captured image file
  late List<CameraDescription> _cameras; // Available device cameras
  bool _isCapturing = false; // Prevents multiple simultaneous captures
  bool _faceDetected = false; // Tracks if a valid face is currently detected
  Color _borderColor = Colors.red; // Visual indicator of face detection status
  bool _captureEnabled = false; // Controls when capture button is active
  bool _processing = false; // Prevents processing multiple frames simultaneously

  // Face detector with configuration for accurate facial feature detection
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableClassification: true, // For smile detection
      enableTracking: true, // To track face across frames
      enableContours: false, // Detailed facial contours not needed
      enableLandmarks: true, // For eye position detection
      minFaceSize: 0.15, // Minimum face size relative to image
      performanceMode: FaceDetectorMode.accurate, // Prioritize accuracy over speed
    ),
  );

  @override
  void initState() {
    super.initState();
    _initializeCamera(); // Set up camera when screen loads
  }

  /// Initialize camera with front-facing lens and high resolution
  /// Also starts face detection stream processing
  Future<void> _initializeCamera() async {
    _cameras = await availableCameras(); // Get all available cameras
    _cameraController = CameraController(
      _cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.front), // Select front camera
      ResolutionPreset.high, // Use high resolution
      enableAudio: false, // No audio needed for selfie
    );
    await _cameraController!.initialize(); // Initialize camera
    _startFaceDetection(); // Begin face detection on camera stream
    setState(() {}); // Update UI after camera is ready
  }

  /// Process camera image stream for face detection
  /// Updates UI based on face detection results
  void _startFaceDetection() {
    _cameraController!.startImageStream((CameraImage image) async {
      if (_isCapturing || _processing) return; // Skip processing if already in progress
      _processing = true;

      try {
        // Convert camera image format to bytes for ML Kit processing
        final WriteBuffer allBytes = WriteBuffer();
        for (final Plane plane in image.planes) {
          allBytes.putUint8List(plane.bytes);
        }
        final bytes = allBytes.done().buffer.asUint8List();

        // Create input image with correct metadata for face detection
        final InputImage inputImage = InputImage.fromBytes(
          bytes: bytes,
          metadata: InputImageMetadata(
            size: Size(image.width.toDouble(), image.height.toDouble()),
            rotation: InputImageRotation.rotation270deg, // Adjust for camera orientation
            format: InputImageFormat.nv21, // Standard camera format
            bytesPerRow: image.planes[0].bytesPerRow,
          ),
        );

        // Process image with face detector
        final List<Face> faces = await _faceDetector.processImage(inputImage);

        if (faces.isNotEmpty) {
          Face face = faces.first; // Focus on the first detected face

          // Check for required facial conditions (eyes open)
          bool smiling =
              face.smilingProbability != null && face.smilingProbability! > 0.3;
          bool eyesOpen = (face.leftEyeOpenProbability != null &&
              face.leftEyeOpenProbability! > 0.4) && // Left eye sufficiently open
              (face.rightEyeOpenProbability != null &&
                  face.rightEyeOpenProbability! > 0.4); // Right eye sufficiently open

          // Update UI when valid face detected (eyes open)
          if (!_faceDetected && eyesOpen) {
            setState(() {
              _faceDetected = true;
              _borderColor = Colors.green; // Green border indicates valid face
              _captureEnabled = true; // Enable capture button
            });
          }
        } else {
          // Update UI when face is no longer detected
          if (_faceDetected) {
            setState(() {
              _faceDetected = false;
              _borderColor = Colors.red; // Red border indicates no valid face
              _captureEnabled = false; // Disable capture button
            });
          }
        }
      } catch (e) {
        print("Error processing face detection: $e");
      }

      _processing = false; // Mark processing as complete
    });
  }

  /// Captures selfie when conditions are met and navigates to confirmation screen
  /// Creates image file in app documents directory
  Future<void> _captureSelfie() async {
    // Only proceed if capture is enabled and camera is ready
    if (!_captureEnabled ||
        _isCapturing ||
        !_cameraController!.value.isInitialized) return;

    setState(() {
      _isCapturing = true; // Prevent multiple captures
    });

    // Capture image from camera
    final XFile photo = await _cameraController!.takePicture();

    // Save image to application documents directory
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = File('${directory.path}/selfie.jpg');
    await photo.saveTo(imagePath.path);

    setState(() {
      _isCapturing = false; // Reset capture flag
    });

    // Navigate to confirmation screen with captured image
    navi(SelfieConfirmationScreen(imagePath: imagePath.path), context);
  }

  @override
  void dispose() {
    _cameraController?.dispose(); // Clean up camera controller
    _faceDetector.close(); // Release ML resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[500],
      // App bar with back button and title
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Take a Quick Photo",
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Oval camera preview with colored border indicating detection status
          Center(
            child: Container(
              width: 236.w,
              height: 312.h,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.elliptical(236.w, 312.h)),
                border: Border.all(
                  color: _borderColor, // Red when no face, green when face detected
                  width: 7.w,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.elliptical(236.w, 312.h)),
                child: _cameraController == null ||
                    !_cameraController!.value.isInitialized
                    ? Center(child: CircularProgressIndicator()) // Loading indicator while camera initializes
                    : Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0), // Mirror horizontally for selfie
                  child: Transform.scale(
                    scale: 1.5, // Scale up to fill oval
                    child: AspectRatio(
                      aspectRatio: 236 / 312, // Match oval aspect ratio
                      child: RotatedBox(
                        quarterTurns: 3, // Rotate to correct orientation
                        child: CameraPreview(_cameraController!),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 40.h),
          // Status message container
          Container(
            width: 260.w,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.grey[400],
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              _faceDetected
                  ? "Face detected! Tap to capture." // Prompt when face detected
                  : "Ensure your face is visible & eyes open", // Instructions otherwise
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 40.h),
          // Capture button - only enabled when face properly detected
          GestureDetector(
            onTap: _captureEnabled ? _captureSelfie : null, // Only active when face detected
            child: Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark ? Colors.white70 : Color(0xffD9D9D9),
                  width: 4.w,
                ),
                color: _captureEnabled
                    ? (isDark ? Colors.white70 : Color(0xffD9D9D9)) // Filled when enabled
                    : Colors.transparent, // Transparent when disabled
              ),
              child: Center(
                child: CircleAvatar(
                  radius: 35.r,
                  backgroundColor: isDark ? Colors.white70 : Color(0xffD9D9D9),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}