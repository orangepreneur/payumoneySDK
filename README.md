# Flutter PayUMoney Pro SDK
###  Flutter Plugin to implement PayUMoney Latest Checkout SDK in Android App.
Screenshots

![screenshot](https://github.com/orangepreneur/payumoneySDK/blob/master/screenshots/card.jpg)
![screenshot](https://github.com/orangepreneur/payumoneySDK/blob/master/screenshots/main.jpg)
![screenshot](https://github.com/orangepreneur/payumoneySDK/blob/master/screenshots/paymentpage.jpg)
![screenshot](https://github.com/orangepreneur/payumoneySDK/blob/master/screenshots/upi.jpg)
![screenshot](https://github.com/orangepreneur/payumoneySDK/blob/master/screenshots/wallets.jpg)
![screenshot](https://github.com/orangepreneur/payumoneySDK/blob/master/screenshots/netbanking.jpg)
## Note: This Plugin is in initial release. Please test it well before using it in production app.

### Currently Support Android Platform only. iOS Soon

### Android Implementation
There are few steps you need to follow to implement PayUMoney SDK:

 - Open file **android/app/build.gradle** in your flutter project and update **minSdkVersion** under "defaultConfig" to **21** (if greater than leave)
 - Open **AndroidManifest.xml** located at **android/app/src/main** and add following code:

```java 
xmlns:tools="http://schemas.android.com/tools"
```
```java
<manifest  xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools" <--- paste here
    package="yourPackageName">
```
*also add this code:*
```java 
tools:replace="android:label"
```
```java
<application
android:name="io.flutter.app.FlutterApplication"
android:label="YourAppName"
tools:replace="android:label" <-- Paste here
android:icon="@mipmap/ic_launcher">
```

### Flutter Implementation

Run this command in project terminal to add dependency
```flutter pub add payumoney_pro_unofficial```


or add manually to **pubspecs.yaml**
```payumoney_pro_unofficial: ^0.0.3```


Import package to by adding this line at the top
```dart 
import  'package:payumoney_pro_unofficial/payumoney_pro_unofficial.dart';
```

Copy and paste this code
```dart
Future<void> initializePayment() async{
final response= await  PayumoneyProUnofficial.payUParams(
email: userDetails['email'],
firstName: userDetails['name'],
merchantName: 'GAMENEX E-Sports',
isProduction: true,
merchantKey: 'XHqp4X',
merchantSalt: 'mPcke2Yv',
amount: value,
productInfo: 'App Wallet Recharge',
transactionId: orderId,
userCredentials:
'XHqp4X:' + userDetails['email'],
userPhoneNumber: phone);
if (response['status'] == 'success')
handlePaymentSuccess();
if (response['status'] == 'failed')
handlePaymentFailure(response['message']);
}

handlePaymentSuccess(){
//Implement Your Success Logic
}

handlePaymentFailure(String errorMessage){
print(errorMessage);
//Implement Your Failed Payment Logic
}
```


For any issue  please write to [contact@orangewp.com](mailto:contact@orangewp.com)
To Connect on Instagram [Click here](https://instagram.com/orangepreneur)
[Youtube](https://orangepreneur.com) | [Business Inqury](https://wa.me/916398259963)

