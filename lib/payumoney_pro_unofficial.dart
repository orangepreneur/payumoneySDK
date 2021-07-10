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
    required String email,
    String merchantName = "Payu",
    bool showExitConfirmation = true,
    String successURL =
        "https://www.payumoney.com/mobileapp/payumoney/success.php",
    String failureURL =
        "https://www.payumoney.com/mobileapp/payumoney/failure.php",
    required String userCredentials,
    required String merchantSalt,
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
        'email': email,
        'merchantName': merchantName,
        'showExitConfirmation': showExitConfirmation,
        'successURL': successURL,
        'failureURL': failureURL,
        'userCredentials': userCredentials,
        'merchantSalt': merchantSalt
      });
      print(data);
      return data;
    } catch (error) {
      debugPrint(error.toString());

      final errorResponse = {"status": "failed", "message": "payment canceled"};
      return errorResponse;
    }
  }
}
