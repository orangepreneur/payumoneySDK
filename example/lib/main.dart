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
              final String amount = "0.50";

              // Amount is in rs. Enter 100 for Rs100.
              // Every Transaction should have a unique ID
              // Phone Number should be 10 digits. Please validate it before passing else it will throw error.

              var response = await PayumoneyProUnofficial.payUParams(
                  email: 'contact@orangewp.com',
                  firstName: "Mukesh Joshi",
                  merchantName: 'Payu',
                  isProduction: true,
                  merchantKey:
                      '3TnMpV', //You will find these details from payumoney dashboard
                  amount: amount,
                  productInfo: 'Wallet Recharge', // Enter Product Name
                  transactionId:
                      orderId, //Every Transaction should have a unique ID
                  hashUrl:
                      'https://us-central1-mukesh-joshi.cloudfunctions.net/payUMoney_CheckoutPro_Hash',
                  userCredentials: '3TnMpV:contact@orangewp.com',
                  showLogs: true,
                  userPhoneNumber: '6398259963');

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
