# Flutter PayUMoney Pro SDK

Screenshots

![screenshot](https://github.com/orangepreneur/payumoneySDK/blob/master/screenshots/card.jpg)
![screenshot](https://github.com/orangepreneur/payumoneySDK/blob/master/screenshots/main.jpg)
![screenshot](https://github.com/orangepreneur/payumoneySDK/blob/master/screenshots/paymentpage.jpg)
![screenshot](https://github.com/orangepreneur/payumoneySDK/blob/master/screenshots/upi.jpg)

## Note: This Plugin is in initial release. Please test it will before using it in production app.

### Currently Support Android Platform only. iOS Soon

### Android Implementation
There are few steps you need to follow to implement PayUMoney SDK:

 - Open file **android/app/build.gradle** in your flutter project and update **minSdkVersion** under "defaultConfig" to **21** (if greater than leave)
 - Open **AndroidManifest.xml** located at **android/app/src/main** and add following code:

add following code
```java 
xmlns:tools="http://schemas.android.com/tools"
```
```java
<manifest  xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools" <--- paste here
    package="yourPackageName">
```
also add this code:
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


