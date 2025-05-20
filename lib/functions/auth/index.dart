import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:sapphire/main.dart';
import 'package:sapphire/utils/constWidgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthFunctions {
  /// Verifies PAN using POST request (step: pan)

  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  String baseUrl = 'http://13.202.238.76:3000';
  Future<void> emailVerification(String email, BuildContext context) async {
    String url = '$baseUrl/api/v1/auth/signup/request-otp';
    String type = 'email';
    final http.Response response = await http
        .post(Uri.parse(url), body: {'type': type, 'email': email.toString()});
    if (response.statusCode == 200) {
      print("Otp sent");
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: const Text(
      //       'OTP sent successfully',
      //       style: TextStyle(color: Colors.white),
      //     ),
      //     backgroundColor: Colors.green,

      //     behavior:
      //         SnackBarBehavior.floating, // Makes it float above the bottom
      //     margin: EdgeInsets.all(16), // Only works with floating behavior
      //   ),
      // );
      constWidgets.snackbar(
          "OTP sent successfully", Colors.green, navigatorKey.currentContext!);
      // IconSnackBar.show(context,
      //     label: "OTP sent successfully", snackBarType: SnackBarType.success);
    } else {
      print(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Failed to sent OTP',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,

          behavior:
              SnackBarBehavior.floating, // Makes it float above the bottom
          margin: EdgeInsets.all(16), // Only works with floating behavior
        ),
      );
      // IconSnackBar.show(context,
      //     label: "Failed to send OTP", snackBarType: SnackBarType.fail);
    }
  }

  Future<void> mobileVerification(
      String number, String email, BuildContext context) async {
    String url = '$baseUrl/api/v1/auth/signup/request-otp';
    String type = 'phone';
    final http.Response response = await http.post(Uri.parse(url), body: {
      'type': type,
      'phone': number.toString(),
      'email': email.toString()
    });
    if (response.statusCode == 200) {
      print("Otp sent");
      // SnackBar(content: Text('OTP sent successfully'));
      constWidgets.snackbar("OTP sent successfully", Colors.green, context);
    } else {
      print(response.body);
      // print(" phone mdhe");
      // SnackBar(content: Text('Failed to send OTP'));
      constWidgets.snackbar("Failed to send OTP", Colors.red, context);
    }
  }

  Future<bool> emailOtpVerification(String email, String otp) async {
    String type = "email";
    String url = '${baseUrl}/api/v1/auth/signup/verify-otp';
    final http.Response response = await http.post(Uri.parse(url),
        body: {'type': type, 'email': email.toString(), 'otp': otp.toString()});
    print("before" + response.body);
    if (response.statusCode == 200) {
      print("Otp verified");
      constWidgets.snackbar("OTP verified successfully", Colors.green,
          navigatorKey.currentContext!);
      return true;
    } else {
      print("after" + response.body);
      print("Failed to verify OTP from inside function");
      constWidgets.snackbar(
          "Failed to verify OTP", Colors.red, navigatorKey.currentContext!);
      return false;
    }
  }

  Future<bool> mobileOtpVerification(
      String number, String otp, String email) async {
    String type = "phone";
    String url = '${baseUrl}/api/v1/auth/signup/verify-otp';
    final http.Response response = await http.post(Uri.parse(url), body: {
      'type': type,
      'phone': number.toString(),
      'otp': otp.toString(),
      'email': email.toString()
    });
    print("before" + response.body);
    if (response.statusCode == 200) {
      print("Otp verified");
      print(response.body);
      final data = jsonDecode(response.body);
      final token = data['token']; // Extract the token

      if (token != null) {
        await secureStorage.write(key: 'auth_token', value: token);

        print("✅ Token stored securely");
      }
      constWidgets.snackbar("OTP verified successfully", Colors.green,
          navigatorKey.currentContext!);
      return true;
    } else {
      print("after" + response.body);
      print("Failed to verify OTP from inside function");
      constWidgets.snackbar(
          "Failed to verify OTP", Colors.red, navigatorKey.currentContext!);
      return false;
    }
  }
}
