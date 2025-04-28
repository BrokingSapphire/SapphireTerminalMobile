// File: selfieCameraScreen.dart
// Description: Selfie capture screen with ML-based face detection for verification.
// This screen uses the device camera and Google ML Kit to detect a face, validate
// proper positioning, and capture a selfie for identity verification purposes.

import 'dart:io'; // For file operations
import 'package:camera/camera.dart'; // Camera plugin for accessing device camera
import 'package:flutter/foundation.dart'; // For low-level utilities like WriteBuffer
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'; // For accessing device file system
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart'; // ML Kit for face detection
import 'package:sapphire/main.dart'; // App-wide navigation utilities

import 'selfieConfirmationScreen.dart'; // Next screen after selfie capture

/// SelfieVerificationScreen - Camera screen with real-time face detection
/// Uses the front camera and Google ML Kit to detect and validate a face
/// before allowing the user to capture a selfie for KYC verification
class SelfieVerificationScreen extends StatefulWidget {
  @override
  _SelfieVerificationScreenState createState() =>
      _SelfieVerificationScreenState();
}

/// State class for the SelfieVerificationScreen widget
/// Manages camera initialization, face detection, and selfie capture
class _SelfieVerificationScreenState extends State<SelfieVerificationScreen> {
  // Camera controller for accessing and controlling the device camera
  CameraController? _cameraController;

  // File instance for the captured image
  File? _image;

  // List of available cameras on the device
  late List<CameraDescription> _cameras;

  // State variables for UI feedback
  bool _isCapturing = false; // Whether a capture is in progress
  bool _faceDetected = false; // Whether a valid face is detected
  Color _borderColor = Colors.red; // Border color based on face detection status
  bool _captureEnabled = false; // Whether selfie capture is allowed
  bool _processing = false; // Flag to prevent multiple simultaneous detections

  // ML Kit face detector instance with configuration options
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableClassification: true, // Detect facial expressions (smile, eyes open)
      enableTracking: true, // Enable face ID tracking for better performance
      enableContours: false, // Disable detailed facial contours for performance
      enableLandmarks: true, // Enable facial landmark detection (eyes, nose, etc.)
      minFaceSize: 0.15, // Minimum face size as proportion of image (ignores small faces)
      performanceMode: FaceDetectorMode.accurate, // Prioritize accuracy over speed
    ),
  );

  @override
  void initState() {
    super.initState();
    _initializeCamera(); // Initialize camera when screen is created
  }

  /// Initializes the camera and starts face detection
  /// Sets up the front camera with high resolution and begins the detection stream
  Future<void> _initializeCamera() async {
    // Get list of available cameras on the device
    _cameras = await availableCameras();

    // Initialize camera controller with front camera
    _cameraController = CameraController(
      _cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.front),
      ResolutionPreset.high, // High resolution for better face detection
      enableAudio: false, // Audio not needed for selfie capture
    );

    // Initialize the camera controller
    await _cameraController!.initialize();

    // Start the face detection process once camera is ready
    _startFaceDetection();

    // Update UI to show camera preview
    setState(() {});
  }

  /// Starts continuous face detection using camera image stream
  /// Processes camera frames to detect faces and update UI accordingly
  void _startFaceDetection() {
    _cameraController!.startImageStream((CameraImage image) async {
      // Skip processing if already capturing or processing a frame
      if (_isCapturing || _processing) return;
      _processing = true; // Lock processing to prevent parallel execution

      try {
        // Convert camera image format to bytes for ML Kit processing
        final WriteBuffer allBytes = WriteBuffer();
        for (final Plane plane in image.planes) {
          allBytes.putUint8List(plane.bytes);
        }
        final bytes = allBytes.done().buffer.asUint8List();

        // Create input image with proper metadata for ML Kit
        final InputImage inputImage = InputImage.fromBytes(
          bytes: bytes,
          metadata: InputImageMetadata(
            size: Size(image.width.toDouble(), image.height.toDouble()),
            rotation: InputImageRotation.rotation270deg, // Adjust orientation for front camera
            format: InputImageFormat.nv21, // YUV format from camera
            bytesPerRow: image.planes[0].bytesPerRow,
          ),
        );

        // Process the image with ML Kit face detector
        final List<Face> faces = await _faceDetector.processImage(inputImage);

        // Update UI based on face detection results
        if (faces.isNotEmpty) {
          Face face = faces.first; // Use the first detected face

          // Validate face attributes for quality verification
          bool smiling =
              face.smilingProbability != null && face.smilingProbability! > 0.3;
          bool eyesOpen = (face.leftEyeOpenProbability != null &&
              face.leftEyeOpenProbability! > 0.4) && // Left eye open
              (face.rightEyeOpenProbability != null &&
                  face.rightEyeOpenProbability! > 0.4); // Right eye open

          // Update UI if face with open eyes is detected
          if (!_faceDetected && eyesOpen) {
            setState(() {
              _faceDetected = true; // Face detected flag
              _borderColor = Colors.green; // Change border to green
              _captureEnabled = true; // Enable capture button
            });
          }
        } else {
          // Reset UI if no face is detected but was previously detected
          if (_faceDetected) {
            setState(() {
              _faceDetected = false; // No face detected
              _borderColor = Colors.red; // Change border to red
              _captureEnabled = false; // Disable capture button
            });
          }
        }
      } catch (e) {
        // Log any errors during face detection
        print("Error processing face detection: $e");
      }

      _processing = false; // Unlock processing for next frame
    });
  }

  /// Captures a selfie when the capture button is tapped
  /// Saves the image to application documents directory and navigates to confirmation screen
  Future<void> _captureSelfie() async {
    // Validate capture is allowed and camera is ready
    if (!_captureEnabled ||
        _isCapturing ||
        !_cameraController!.value.isInitialized) return;

    // Update UI to show capture in progress
    setState(() {
      _isCapturing = true;
    });

    // Capture image from camera
    final XFile photo = await _cameraController!.takePicture();

    // Get application documents directory for storing the image
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = File('${directory.path}/selfie.jpg');

    // Save captured image to file
    await photo.saveTo(imagePath.path);

    // Update UI after capture complete
    setState(() {
      _isCapturing = false;
    });

    // Navigate to confirmation screen (currently commented out)
    // navi(SelfieConfirmationScreen(imagePath: imagePath.path), context);
  }

  @override
  void dispose() {
    // Clean up resources when screen is disposed
    _cameraController?.dispose(); // Release camera
    _faceDetector.close(); // Release ML Kit detector
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500], // Grey background for better contrast
      appBar: AppBar(
        backgroundColor: Colors.grey[500], // Matching app bar color
        title: Text(
          "Take a Quick Photo",
          style: TextStyle(fontSize: 16.sp),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Oval camera preview with colored border based on face detection
          Center(
            child: Container(
              width: 236.w, // Fixed width for oval
              height: 312.h, // Fixed height for oval
              decoration: BoxDecoration(
                shape: BoxShape.rectangle, // Rectangle base to apply border radius
                borderRadius: BorderRadius.all(
                    Radius.elliptical(236.w, 312.h)), // Oval-shaped border radius
                border: Border.all(
                  color: _borderColor, // Red (no face) or green (face detected)
                  width: 7.w, // Thick border for visibility
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                    Radius.elliptical(236.w, 312.h)), // Clip to oval shape
                child: _cameraController == null ||
                    !_cameraController!.value.isInitialized
                    ? Center(child: CircularProgressIndicator()) // Loading indicator while camera initializes
                    : Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..scale(-1.0, 1.0, 1.0), // Mirror horizontally for selfie view
                  child: Transform.scale(
                    scale: 1.5, // Scale up for better framing of face
                    child: AspectRatio(
                      aspectRatio: 236 / 312, // Match container aspect ratio
                      child: RotatedBox(
                        quarterTurns: 3, // Rotate for correct orientation
                        child: CameraPreview(_cameraController!),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 40.h),

          // Instruction text container - changes based on face detection status
          Container(
            width: 260.w,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              _faceDetected
                  ? "Face detected! Tap to capture." // Face detected message
                  : "Ensure your face is visible & eyes open", // Instructions when no face detected
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 40.h),

          // Capture button - styled as a camera shutter button
          GestureDetector(
            onTap: _captureEnabled ? _captureSelfie : null, // Only enabled when face detected
            child: Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xffD9D9D9), width: 4.w),
                color: _captureEnabled
                    ? Color(0xffD9D9D9) // Filled when enabled
                    : Colors.transparent, // Hollow when disabled
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