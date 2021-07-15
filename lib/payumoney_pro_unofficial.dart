import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// class to Implement PayUMoney CheckoutPro SDK in Android & iOS App
class PayumoneyProUnofficial {
  // method channel allow us to run platform specific code.
  static const MethodChannel _channel =
      const MethodChannel('payumoney_pro_unofficial');
  // function to build payment params for payumoney. More details can be found at payumoney documentation
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
      // passing data to platform. expected to get <string,dynamic> Map in return
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
      // debuging error in case of payment failure.
      debugPrint(error.toString());
      final errorResponse = {"status": "failed", "message": "payment canceled"};
      return errorResponse;
    }
  }
}

// Class to abstract some strings and make code look clean for users.
class PayUParams {
  static const successURL =
      "https://www.payumoney.com/mobileapp/payumoney/success.php";
  static const failureURL =
      "https://www.payumoney.com/mobileapp/payumoney/failure.php";
  static const merchantName = "Payu";
  static const success = "success";
  static const failed = "failed";
}
