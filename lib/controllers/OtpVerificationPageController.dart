import 'package:flutter/material.dart';
import 'package:say_anything/services/API_services.dart';

class OtpVerificationPageController {
  final otpController = TextEditingController();
  final VerifyOTPService otpService = VerifyOTPService();

  Future<int> verifyOtp() async {
    return await otpService.verifyOTP(otpController.text);
  }

  void dispose() {
    otpController.dispose();
  }
}
