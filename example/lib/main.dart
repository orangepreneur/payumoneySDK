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
          title: const Text('Flutter PayUMoney Checkout Pro'),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text("Make Payment"),
            onPressed: () async {
              String orderId = DateTime.now().millisecondsSinceEpoch.toString();
              final String amount = "1"; //Amount is in rs. Enter 100 for Rs100.
              var response = await PayumoneyProUnofficial.payUParams(
                  email: '<Enter Customer Email>',
                  firstName: "<Enter Customer Name>",
                  merchantName: '<Add Your Merchant Name>',
                  isProduction: true,
                  merchantKey:
                      '<Add Your Merchant Key>', //You will find these details from payumoney dashboard
                  merchantSalt:
                      '<Add Your Merchant Salt Version 1>', //You will find these details from payumoney dashboard
                  amount: amount,
                  productInfo: '<Enter Product Name>', // Enter Product Name
                  transactionId:
                      orderId, //Every Transaction should have a unique ID
                  userCredentials:
                      '<Merchant Key>:<Enter Customer Email or USER ID>',
                  userPhoneNumber:
                      '<Enter Customer PhoneNumber>'); //Phone Number should be 10 digits. Please validate it before passing else it will throw error.
              if (response['status'] == 'success') handlePaymentSuccess(amount);
              if (response['status'] == 'failed')
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
