import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sapphire/main.dart';
import 'package:sapphire/utils/constWidgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthFunctions {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  String baseUrl = 'https://api.backend.sapphirebroking.com:8443';
  Future<void> emailVerification(String email) async {
    String url = '$baseUrl/api/v1/auth/signup/request-otp';
    String type = 'email';
    final http.Response response = await http
        .post(Uri.parse(url), body: {'type': type, 'email': email.toString()});
    if (response.statusCode == 200) {
      print("Otp sent");
      SnackBar(content: Text('OTP sent successfully'));
    } else {
      print(response.body);
      print("Lvde lagle");
      SnackBar(content: Text('Failed to send OTP'));
    }
  }

  Future<void> mobileVerification(String number, String email) async {
    String url = '$baseUrl/api/v1/auth/signup/request-otp';
    String type = 'phone';
    final http.Response response = await http.post(Uri.parse(url), body: {
      'type': type,
      'phone': number.toString(),
      'email': email.toString()
    });
    if (response.statusCode == 200) {
      print("Otp sent");
      SnackBar(content: Text('OTP sent successfully'));
    } else {
      print(response.body);
      print("Lvde lagle phone mdhe");
      SnackBar(content: Text('Failed to send OTP'));
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
      // constWidgets.snackbar("OTP verified successfully", Colors.green,
      //     navigatorKey.currentContext!);
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
      // constWidgets.snackbar("OTP verified successfully", Colors.green,
      //     navigatorKey.currentContext!);
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
