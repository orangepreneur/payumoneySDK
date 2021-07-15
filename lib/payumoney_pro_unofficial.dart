// Flutter plugin to implement PayUMoney CheckoutPro SDK in Android & iOS App
// Developed by Mukesh Joshi
// https://iammukesh.com

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Unofficial Plugin for PayU
class PayumoneyProUnofficial {
  // method channel allow us to run platform specific code.
  static const MethodChannel _channel =
      const MethodChannel('payumoney_pro_unofficial');
  // function to build payment params for payumoney. More details can be found at payumoney documentation
  static Future<Map<dynamic, dynamic>> payUParams({
    // amount is required
    required String amount,
    // Is Production or Test Environment
    required bool isProduction,
    // require product information
    required String productInfo,
    // merchant key
    required String merchantKey,
    // user's phone number is required by payumoney gateway
    required String userPhoneNumber,
    // a unique transactionId is required
    required String transactionId,
    // user's first name is required. make sure it doesn't have space
    required String firstName,
    // merchantSalt provided by the payumoney dashboard
    required String merchantSalt,
    // user's email for payment related notification. payumoney will handle emails
    required String email,
    // server url to generate hashes
    required String hashUrl,
    // optional Merchant Name will appear on payment page
    String merchantName = PayUParams.merchantName,
    // bool value will decide whether to show exit dialog or not
    bool showExitConfirmation = true,
    // Bool will decide whether to show debug logs or not
    bool showLogs = false,
    // payumoney success url
    String successURL = PayUParams.successURL,
    // payumoney failure url
    String failureURL = PayUParams.failureURL,
    // user credentials are used to store saved cards and payment details for repetive payments and fast checkouts.
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
      // returning response back to flutter app
      return data;
    } catch (error) {
      // debuging error in case of payment failure.
      debugPrint(error.toString());
      // creating map with failed status for better event handling
      final errorResponse = {"status": "failed", "message": "payment canceled"};
      // returning recently generated map as response
      return errorResponse;
    }
  }
}

// Class to abstract some strings and make code look clean for users.
class PayUParams {
  // default successurl for payment params
  static const successURL =
      "https://www.payumoney.com/mobileapp/payumoney/success.php";
  // default failureurl for payment params
  static const failureURL =
      "https://www.payumoney.com/mobileapp/payumoney/failure.php";
  // default merchant name for payment params
  static const merchantName = "Payu";
  // default string variable to make code clean
  static const success = "success";
  // default string variable to make code clean
  static const failed = "failed";
}
