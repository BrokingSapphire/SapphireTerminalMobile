import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/auth/login/troubleLoggingIn/otpVerificatin.dart';
import 'package:sapphire/utils/constWidgets.dart';

class panInput extends StatefulWidget {
  const panInput({super.key});

  @override
  State<panInput> createState() => _panInputState();
}

class _panInputState extends State<panInput> {
  final TextEditingController panNumber = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool isButtonDisabled = true;
  TextInputType _keyboardType = TextInputType.text;
  String _hintText = 'ABCDE1111F';
  String _labelText = 'PAN Number';
  // String? _recaptchaError;
  // bool _isRecaptchaVerified = false;
  // late WebViewController _webViewController;
  // int _verificationAttempts = 0;

  // // reCAPTCHA v3 Keys (WARNING: Embedding secret key in app is insecure)
  // static const String _apiKey = '6LcpFD8rAAAAAHsSNJCDUz90LBVi9W2jTIwHLL3L'; // v3 site key
  // static const String _apiSecret = '6LcpFD8rAAAAAOynv23wt1KfW4dXhOMyn2gRthDc'; // WARNING: Exposed in client
  // static const double _scoreThreshold = 0.5; // Minimum score to pass (0.0–1.0)

  @override
  void initState() {
    super.initState();
    panNumber.addListener(_onTextChanged);
    // _initializeWebView();
  }

  @override
  void dispose() {
    panNumber.removeListener(_onTextChanged);
    panNumber.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // // Initialize WebView for reCAPTCHA v3
  // void _initializeWebView() {
  //   _webViewController = WebViewController()
  //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //     ..setUserAgent(
  //         'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36')
  //     ..addJavaScriptChannel(
  //       'RecaptchaChannel',
  //       onMessageReceived: (JavaScriptMessage message) {
  //         _verifyRecaptchaToken(message.message);
  //       },
  //     )
  //     ..setNavigationDelegate(NavigationDelegate(
  //       onWebResourceError: (error) {
  //         print('WebView error: ${error.description}');
  //         setState(() {
  //           _recaptchaError = 'Failed to load reCAPTCHA. Please check your connection.';
  //           _isRecaptchaVerified = false;
  //           // isButtonDisabled = true;
  //         });
  //       },
  //     ))
  //     ..loadHtmlString('''
  //       <!DOCTYPE html>
  //       <html>
  //       <head>
  //         <meta name="viewport" content="width=device-width, initial-scale=1.0">
  //         <script src="https://www.google.com/recaptcha/api.js?render=$_apiKey" async defer></script>
  //         <script>
  //           function verifyRecaptcha() {
  //             try {
  //               grecaptcha.ready(function() {
  //                 grecaptcha.execute('$_apiKey', {action: 'verify_pan'})
  //                   .then(function(token) {
  //                     RecaptchaChannel.postMessage(token);
  //                   })
  //                   .catch(function(error) {
  //                     RecaptchaChannel.postMessage('Error: ' + (error || 'Unknown error'));
  //                   });
  //               });
  //             } catch (e) {
  //               RecaptchaChannel.postMessage('Error: ' + e);
  //             }
  //           }
  //           // Call immediately and allow retries
  //           verifyRecaptcha();
  //         </script>
  //       </head>
  //       <body></body>
  //       </html>
  //     ''');
  // }

  // Handle PAN text changes and trigger reCAPTCHA
  void _onTextChanged() {
    final pan = panNumber.text.toUpperCase();
    final panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
    TextInputType newKeyboardType = _keyboardType;
    String newHintText = _hintText;

    if (pan.length < 5) {
      newKeyboardType = TextInputType.text;
      newHintText = 'ABCDE1111F';
    } else if (pan.length < 9) {
      newKeyboardType = TextInputType.number;
      newHintText = 'ABCDE1111F';
    } else {
      newKeyboardType = TextInputType.text;
      newHintText = 'ABCDE1111F';
    }

    setState(() {
      isButtonDisabled =
          !panRegex.hasMatch(pan); // Removed _isRecaptchaVerified check
      if (newKeyboardType != _keyboardType) {
        _keyboardType = newKeyboardType;
        _hintText = newHintText;
        FocusScope.of(context).unfocus();
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) {
            FocusScope.of(context).requestFocus(_focusNode);
          }
        });
      } else {
        _hintText = newHintText;
      }
    });

    // // Trigger reCAPTCHA when PAN is valid and not yet verified
    // if (panRegex.hasMatch(pan) && !_isRecaptchaVerified && _verificationAttempts < 5) {
    //   _webViewController.runJavaScript('verifyRecaptcha();');
    // }
  }

  // // Verify reCAPTCHA v3 token client-side (WARNING: Insecure)
  // Future<void> _verifyRecaptchaToken(String message) async {
  //   if (_verificationAttempts >= 5) {
  //     setState(() {
  //       _recaptchaError = 'Too many attempts. Please try again later.';
  //       _isRecaptchaVerified = false;
  //       // isButtonDisabled = true;
  //     });
  //     return;
  //   }
  //   _verificationAttempts++;
  //
  //   if (message.startsWith('Error')) {
  //     setState(() {
  //       _isRecaptchaVerified = false;
  //       isButtonDisabled = true;
  //       _recaptchaError = 'reCAPTCHA error: ${message.substring(6)}. Please try again.';
  //     });
  //     return;
  //   }
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse('https://www.google.com/recaptcha/api/siteverify'),
  //       body: {
  //         'secret': _apiSecret, // WARNING: Exposed in client
  //         'response': message,
  //       },
  //     );
  //     final jsonResponse = json.decode(response.body);
  //     print('reCAPTCHA v3 verify response: $jsonResponse'); // Debug log
  //     if (jsonResponse['success'] == true && jsonResponse['score'] >= _scoreThreshold) {
  //       setState(() {
  //         _isRecaptchaVerified = true;
  //         _recaptchaError = 'reCAPTCHA verified successfully!';
  //         isButtonDisabled = !RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$').hasMatch(panNumber.text.toUpperCase()) ||
  //             !_isRecaptchaVerified;
  //         _verificationAttempts = 0; // Reset attempts on success
  //       });
  //       // Clear success message after 3 seconds
  //       Future.delayed(const Duration(seconds: 3), () {
  //         if (mounted) {
  //           setState(() {
  //             _recaptchaError = null;
  //           });
  //         }
  //       });
  //     } else {
  //       setState(() {
  //         _isRecaptchaVerified = false;
  //         isButtonDisabled = true;
  //         _recaptchaError = jsonResponse['error-codes']?.contains('browser-error')
  //             ? 'Browser error in reCAPTCHA. Please ensure a stable connection and try again.'
  //             : jsonResponse['error-codes']?.contains('invalid-input-secret')
  //                 ? 'Invalid reCAPTCHA key. Please contact support.'
  //                 : 'reCAPTCHA verification failed: Low score (${jsonResponse['score'] ?? 'N/A'}). Try again.';
  //       });
  //     }
  //   } catch (e) {
  //     print('reCAPTCHA verification error: $e');
  //     setState(() {
  //       _isRecaptchaVerified = false;
  //       isButtonDisabled = true;
  //       _recaptchaError = 'Network error. Please check your connection and try again.';
  //     });
  //   }
  // }

  // Custom input formatter for PAN
  TextInputFormatter _panInputFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      final text = newValue.text.toUpperCase();
      if (text.length > 10) return oldValue;
      if (text.isNotEmpty) {
        for (int i = 0; i < text.length; i++) {
          if (i < 5 || i == 9) {
            if (!RegExp(r'[A-Z]').hasMatch(text[i])) return oldValue;
          } else {
            if (!RegExp(r'[0-9]').hasMatch(text[i])) return oldValue;
          }
        }
      }
      return newValue.copyWith(
        text: text,
        selection: newValue.selection,
        composing: newValue.composing,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 46.w,
        leading: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: IconButton(
            icon: Icon(Icons.arrow_back,
                size: 28.sp, color: isDark ? Colors.white : Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        backgroundColor: isDark ? Colors.black : Colors.white,
      ),
      backgroundColor: isDark ? Colors.black : Colors.white,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Trouble Logging In?",
                style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black),
              ),
              SizedBox(height: 16.h),
              Text(
                "To complete the verification process, we need your PAN to confirm your identity.",
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: isDark ? Colors.white70 : Colors.black54),
              ),
              SizedBox(height: 24.h),
              // PAN TextField
              TextField(
                key: ValueKey(_keyboardType),
                controller: panNumber,
                focusNode: _focusNode,
                textCapitalization: TextCapitalization.characters,
                keyboardType: _keyboardType,
                inputFormatters: [
                  _panInputFormatter(),
                  LengthLimitingTextInputFormatter(10),
                ],
                style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 15.sp),
                decoration: InputDecoration(
                  label: Text(_labelText),
                  labelStyle: TextStyle(color: Colors.white, fontSize: 15.sp),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  filled: false,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide(
                        color: isDark ? Colors.white54 : Color(0xffD1D5DB)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide:
                        BorderSide(color: Color(0xFF1DB954), width: 2.w),
                  ),
                  hintText: _hintText,
                  hintStyle: TextStyle(
                      color: isDark ? Color(0xFFC9CACC) : Color(0xff6B7280),
                      fontSize: 15.sp),
                ),
              ),
              // // reCAPTCHA v3 Section (Invisible)
              // Text(
              //   'Verifying You Are Not a Robot',
              //   style: TextStyle(
              //       fontSize: 15.sp,
              //       fontWeight: FontWeight.w500,
              //       color: isDark ? Colors.white : Colors.black),
              // ),
              // SizedBox(height: 8.h),
              // // Invisible WebView for reCAPTCHA v3
              // SizedBox(
              //   height: 0, // Invisible
              //   child: WebViewWidget(controller: _webViewController),
              // ),
              // if (_recaptchaError != null) ...[
              //   SizedBox(height: 8.h),
              //   Text(
              //     _recaptchaError!,
              //     style: TextStyle(
              //       color: _recaptchaError!.contains('successfully') ? Colors.green : Colors.red,
              //       fontSize: 12.sp,
              //     ),
              //   ),
              // ],
              // if (_recaptchaError != null && _recaptchaError!.contains('Browser error')) ...[
              //   SizedBox(height: 8.h),
              //   TextButton(
              //     onPressed: () {
              //       _verificationAttempts = 0;
              //       setState(() {
              //         _recaptchaError = null;
              //         _isRecaptchaVerified = false;
              //         isButtonDisabled = true;
              //       });
              //       _webViewController.reload();
              //     },
              //     child: Text(
              //       'Retry Verification',
              //       style: TextStyle(
              //         color: Color(0xFF1DB954),
              //         fontSize: 12.sp,
              //         decoration: TextDecoration.underline,
              //       ),
              //     ),
              //   ),
              // ],
              Spacer(),
              // Continue button
              constWidgets.greenButton(
                "Continue",
                onTap: isButtonDisabled
                    ? null
                    : () {
                        navi(otpVerification(), context);
                      },
                isDisabled: isButtonDisabled,
              ),
              SizedBox(height: 10.h),
              Center(child: constWidgets.needHelpButton(context)),
            ],
          ),
        ),
      ),
    );
  }

  void showFindPanBottomSheet(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.h,
            right: 16.h,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "How to find your PAN number?",
                style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.h),
              Text(
                "Your PAN number will be on your PAN Card as shown below",
                style: TextStyle(
                    color: isDark ? Colors.white54 : Colors.black54,
                    fontSize: 13.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15.h),
              Image.asset(
                "assets/images/pan.png",
                width: 380.w,
              ),
              Padding(
                padding: EdgeInsets.only(left: 190.w),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white : Colors.black,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Text(
                    "Your PAN Number",
                    style: TextStyle(
                        color: isDark ? Colors.black : Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Text(
                    "Don't have a PAN?",
                    style: TextStyle(
                        color: isDark ? Colors.white54 : Colors.black54,
                        fontSize: 12.sp),
                  ),
                  SizedBox(width: 5.w),
                  GestureDetector(
                    onTap: () {
                      // TODO: Add navigation to ePAN application website
                    },
                    child: Text(
                      "Apply for an ePAN",
                      style: TextStyle(
                          color: Color(0xFF1DB954),
                          fontSize: 12.sp,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Center(
                child: SizedBox(
                  width: 100.w,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1DB954),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      "Got It",
                      style: TextStyle(
                          fontSize: 17.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }
}
