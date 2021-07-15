# Flutter PayUMoney Pro SDK

![Build Passing Badge](https://img.shields.io/badge/build-Passing-brightgreen) ![Pub Version](https://img.shields.io/pub/v/payumoney_pro_unofficial?label=Version) ![Flutter Version](https://img.shields.io/badge/Flutter-v2.2.3-blue) ![Platform Supported](https://img.shields.io/badge/Platform%20Supported-Android%20%7C%20iOS-red)

### Flutter Plugin to implement PayUMoney Latest CheckoutPro SDK in Android & iOS App.

Screenshots

![screenshot](https://github.com/orangepreneur/payumoneySDK/blob/master/screenshots/main.jpg)![screenshot](https://github.com/orangepreneur/payumoneySDK/blob/master/screenshots/paymentpage.jpg)![screenshot](https://github.com/orangepreneur/payumoneySDK/blob/master/screenshots/card.jpg)![screenshot](https://github.com/orangepreneur/payumoneySDK/blob/master/screenshots/upi.jpg)![screenshot](https://github.com/orangepreneur/payumoneySDK/blob/master/screenshots/wallets.jpg)![screenshot](https://github.com/orangepreneur/payumoneySDK/blob/master/screenshots/netbanking.jpg)

## Note: This Plugin is in initial release. Please test it well before using it in production app.

### Step 1: Android Implementation

There are few steps you need to follow to implement PayUMoney SDK:

- Open file **android/app/build.gradle** in your flutter project and update **minSdkVersion** under "defaultConfig" to **21** (if greater than leave)

- Open **AndroidManifest.xml** located at **android/app/src/main** and add following code:

```java
xmlns:tools="http://schemas.android.com/tools"
```

```java
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
xmlns:tools="http://schemas.android.com/tools" <--- paste here
package="yourPackageName">
```

_also add this code:_

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

### Step 2: iOS Implementation

<-- No additional steps required for iOS -->

### Step 3: Flutter Implementation

Run this command in project terminal to add dependency

`flutter pub add payumoney_pro_unofficial`

or add manually to **pubspecs.yaml**  
`payumoney_pro_unofficial: ^0.0.8`

Get latest packages
`flutter pub get `

Import package to by adding this line at the top

```dart
import  'package:payumoney_pro_unofficial/payumoney_pro_unofficial.dart';
```

Copy and paste this code

```dart
Future<void> initializePayment() async{
	final response= await  PayumoneyProUnofficial.payUParams(
		email: '<Customer Email>',
		firstName: '<Customer Name>',
		merchantName: '<Merchant Name>',
		isProduction: true,
		merchantKey: '<Merchant Key>',
		merchantSalt: '<Merchant Salt Version 1>',
		amount: '<Amount in Rs>',
		hashUrl:'<Checksum URL to generate dynamic hashes>', //nodejs code is included. Host the code and update its url here.
		productInfo: '<Product Name>',
		transactionId: '<Unique ID>',
		showExitConfirmation:true,
		showLogs:false, // true for debugging, false for production
		userCredentials:'<Merchant Key>:' + '<Customer Email or User ID>',
		userPhoneNumber: phone
		);

	if (response['status'] == PayUParams.success)
	handlePaymentSuccess();
	if (response['status'] == PayUParams.failed)
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

### Pro Tip:

1. Always make sure you validate Phone number(Must be 10 Digits) else payment page might not appear.
2. Avoid hardcoded credentials.
3. Always generate unique transaction id for each transaction.
4. Store Transaction & Details to database for later analysis or usage.

_For any issue please write to [contact@orangewp.com](mailto:contact@orangewp.com)_

To Connect on [Instagram](https://instagram.com/orangepreneur) | [Youtube](https://orangepreneur.com) | [Business Inqury](https://wa.me/916398259963)
