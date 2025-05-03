import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:sapphire/main.dart';
import 'selfieConfirmation.dart';

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
  Color _borderColor = Colors.red;
  bool _captureEnabled = false;
  bool _processing = false;

  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableClassification: true,
      enableTracking: true,
      enableContours: false,
      enableLandmarks: true,
      minFaceSize: 0.15,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
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
      _processing = true;

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
            rotation: InputImageRotation.rotation270deg,
            format: InputImageFormat.nv21,
            bytesPerRow: image.planes[0].bytesPerRow,
          ),
        );

        final List<Face> faces = await _faceDetector.processImage(inputImage);

        if (faces.isNotEmpty) {
          Face face = faces.first;
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

      _processing = false;
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[500],
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
          Center(
            child: Container(
              width: 236.w,
              height: 312.h,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.elliptical(236.w, 312.h)),
                border: Border.all(
                  color: _borderColor,
                  width: 7.w,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.elliptical(236.w, 312.h)),
                child: _cameraController == null ||
                        !_cameraController!.value.isInitialized
                    ? Center(child: CircularProgressIndicator())
                    : Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                        child: Transform.scale(
                          scale: 1.5,
                          child: AspectRatio(
                            aspectRatio: 236 / 312,
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: CameraPreview(_cameraController!),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ),
          SizedBox(height: 40.h),
          Container(
            width: 260.w,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.grey[400],
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              _faceDetected
                  ? "Face detected! Tap to capture."
                  : "Ensure your face is visible & eyes open",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 40.h),
          GestureDetector(
            onTap: _captureEnabled ? _captureSelfie : null,
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
                    ? (isDark ? Colors.white70 : Color(0xffD9D9D9))
                    : Colors.transparent,
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
