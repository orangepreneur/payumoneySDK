import 'package:flutter/material.dart';
import 'package:payumoney_pro_unofficial/payumoney_pro_unofficial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PayUMoney Checkout Pro'),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text("Make Payment"),
            onPressed: () async {
              String orderId = DateTime.now().millisecondsSinceEpoch.toString();
              final String amount = "1";

              // Amount is in rs. Enter 100 for Rs100.
              // Every Transaction should have a unique ID
              // Phone Number should be 10 digits. Please validate it before passing else it will throw error.
              // hashUrl is required. check github documentation for nodejs code.
              var response = await PayumoneyProUnofficial.payUParams(
                  email: 'test@example.com',
                  firstName: "Orange",
                  merchantName: 'Orange Digitals',
                  isProduction: true,
                  merchantKey:
                      'merchantKey', //You will find these details from payumoney dashboard
                  merchantSalt: 'merchantSalt',
                  amount: amount,
                  productInfo: 'iPhone 12', // Enter Product Name
                  transactionId:
                      orderId, //Every Transaction should have a unique ID
                  hashUrl: '',
                  userCredentials: 'merchantKey:test@example.com',
                  showLogs: true,
                  userPhoneNumber: '9999999999');

              if (response['status'] == PayUParams.success)
                handlePaymentSuccess(amount);
              if (response['status'] == PayUParams.failed)
                handlePaymentFailure(amount, response['message']);
            },
          ),
        ),
      ),
    );
  }

  handlePaymentSuccess(String amount) {
    print("Success");
    // Implement your logic here for successful payment.
  }

  handlePaymentFailure(String amount, String error) {
    print("Failed");
    print(error);
    // Implement your logic here for failed payment.
  }
}
