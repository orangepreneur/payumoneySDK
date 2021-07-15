import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PayumoneyProUnofficial {
  static const MethodChannel _channel =
      const MethodChannel('payumoney_pro_unofficial');
  static Future<Map<dynamic, dynamic>> payUParams({
    required String amount,
    required bool isProduction,
    required String productInfo,
    required String merchantKey,
    required String userPhoneNumber,
    required String transactionId,
    required String firstName,
    required String merchantSalt,
    required String email,
    required String hashUrl,
    String merchantName = PayUParams.merchantName,
    bool showExitConfirmation = true,
    bool showLogs = false,
    String successURL = PayUParams.successURL,
    String failureURL = PayUParams.failureURL,
    required String userCredentials,
  }) async {
    try {
      final data = await _channel.invokeMethod('payUParams', {
        'amount': amount,
        'isProduction': isProduction,
        'productInfo': productInfo,
        'merchantKey': merchantKey,
        'userPhoneNumber': userPhoneNumber,
        'transactionId': transactionId,
        'firstName': firstName,
        'merchantSalt': merchantSalt,
        'email': email,
        'showLogs': showLogs,
        'merchantName': merchantName,
        'showExitConfirmation': showExitConfirmation,
        'successURL': successURL,
        'failureURL': failureURL,
        'hash': hashUrl,
        'userCredentials': userCredentials,
      });
      return data;
    } catch (error) {
      debugPrint(error.toString());
      final errorResponse = {"status": "failed", "message": "payment canceled"};
      return errorResponse;
    }
  }
}

class PayUParams {
  static const successURL =
      "https://www.payumoney.com/mobileapp/payumoney/success.php";
  static const failureURL =
      "https://www.payumoney.com/mobileapp/payumoney/failure.php";
  static const merchantName = "Payu";
  static const success = "success";
  static const failed = "failed";
}
