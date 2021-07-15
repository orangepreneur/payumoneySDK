package com.example.payumoney_pro_unofficial;

import android.app.Activity;
import android.text.TextUtils;
import android.util.Log;
import android.webkit.WebView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.payu.base.models.ErrorResponse;
import com.payu.base.models.PayUPaymentParams;
import com.payu.checkoutpro.PayUCheckoutPro;
import com.payu.checkoutpro.models.PayUCheckoutProConfig;
import com.payu.checkoutpro.utils.PayUCheckoutProConstants;
import com.payu.ui.model.listeners.PayUCheckoutProListener;
import com.payu.ui.model.listeners.PayUHashGenerationListener;

import org.jetbrains.annotations.NotNull;

import java.security.Key;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import static android.content.ContentValues.TAG;

/** PayumoneyProUnofficialPlugin */
public class PayumoneyProUnofficialPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Activity activity;
  private MethodChannel.Result mainResult;
  Boolean showLogs=false;
  String paymentHash="";
  PayUPaymentParams payUPaymentParams =null;
  PayUPaymentParams.Builder builder = new PayUPaymentParams.Builder();
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "payumoney_pro_unofficial");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    this.mainResult=result;
   if (call.method.equals("payUParams")) {
     buildPaymentParams(call);
    }else {
      result.notImplemented();
    }
  }


  private void buildPaymentParams( MethodCall call){
    
    this.showLogs = (boolean) call.argument("showLogs");
    if(this.showLogs){
      Log.i(TAG,"=======================");
      Log.i(TAG,"Debug Mode is Enabled");
      Log.i(TAG,"=======================");
      Log.i(TAG,"Parameter passed to SDK");
      Log.i(TAG,"Amount: " + call.argument("amount"));
      Log.i(TAG,"isProduction:" + call.argument("isProduction"));
      Log.i(TAG,"productInfo:" + call.argument("productInfo"));
      Log.i(TAG,"merchantKey:" + call.argument("merchantKey"));
      Log.i(TAG,"userPhoneNumber:" + call.argument("userPhoneNumber"));
      Log.i(TAG,"transactionId:" + call.argument("transactionId"));
      Log.i(TAG,"firstName:" + call.argument("firstName"));
      Log.i(TAG,"email:" + call.argument("email"));
      Log.i(TAG,"successURL:" + call.argument("successURL"));
      Log.i(TAG,"failureURL:" + call.argument("failureURL"));
      Log.i(TAG,"userCredentials:" + call.argument("userCredentials"));
    }
    HashMap<String, Object> additionalParams = new HashMap<>();
    additionalParams.put(PayUCheckoutProConstants.CP_UDF1, "udf1");
    additionalParams.put(PayUCheckoutProConstants.CP_UDF2, "udf2");
    additionalParams.put(PayUCheckoutProConstants.CP_UDF3, "udf3");
    additionalParams.put(PayUCheckoutProConstants.CP_UDF4, "udf4");
    additionalParams.put(PayUCheckoutProConstants.CP_UDF5, "udf5");

  builder.setAmount((String) call.argument("amount"))
.setIsProduction((boolean) call.argument("isProduction"))
        .setProductInfo((String) call.argument("productInfo"))
        .setKey((String)  call.argument("merchantKey"))
        .setPhone((String) call.argument("userPhoneNumber"))
        .setTransactionId((String)  call.argument("transactionId"))
        .setFirstName((String)  call.argument("firstName"))
        .setEmail((String)  call.argument("email"))
        .setSurl((String)  call.argument("successURL"))
        .setFurl((String)  call.argument("failureURL"))
        .setAdditionalParams(additionalParams)
        .setUserCredential((String)  call.argument("userCredentials"));
    try {
      this.payUPaymentParams = builder.build();

if(this.showLogs){
        Log.i(TAG,"Starting payment process");
}
      startPayment(this.payUPaymentParams,"g0nGFe03");


    } catch (Exception e) {
      mainResult.error("ERROR", e.getMessage(), null);
      if(this.showLogs){
      Log.d(TAG, "Error : " + e.toString());
      }
    }
  }

  private void startPayment(PayUPaymentParams payUPaymentParams,final String salt){
      PayUCheckoutPro.open(
              activity,
              payUPaymentParams,
              new PayUCheckoutProListener() {

                @Override
                public void onPaymentSuccess(Object response) {
       
                  if(this.showLogs){
                 Log.i(TAG,"Payment Successfull");
                  }
                  //Cast response object to HashMap
                  HashMap<String,Object> result = (HashMap<String, Object>) response;
                  String payuResponse = (String)result.get(PayUCheckoutProConstants.CP_PAYU_RESPONSE);
                  String merchantResponse = (String) result.get(PayUCheckoutProConstants.CP_MERCHANT_RESPONSE);
                  result.put("status", "success");
                  result.put("message","Payment success");
                  mainResult.success(result);
                }
                @Override
                public void onPaymentFailure(Object response) {
                  if(this.showLogs){
                    Log.e(TAG,"Payment Failed");
                  }
                  
                  //Cast response object to HashMap
                  HashMap<String,Object> result = (HashMap<String, Object>) response;
                  String payuResponse = (String)result.get(PayUCheckoutProConstants.CP_PAYU_RESPONSE);
                  String merchantResponse = (String) result.get(PayUCheckoutProConstants.CP_MERCHANT_RESPONSE);
                  result.put("status", "failed");
                  result.put("message","Payment failed");
                  mainResult.success(result);
                }
                @Override
                public void onPaymentCancel(boolean isTxnInitiated) {
                  
                  if(this.showLogs){
                    Log.e(TAG,"Payment Cancelled");
                  }
                  HashMap<String,Object> result =new HashMap<String, Object>();
                  result.put("status", "failed");
                  result.put("message","Payment canceled");
                  mainResult.success(result);
                }
                @Override
                public void onError(ErrorResponse errorResponse) {
                  String errorMessage = errorResponse.getErrorMessage();
                  if(this.showLogs){
                    Log.e(TAG,errorMessage);
                  }
                  HashMap<String,Object> result =new HashMap<String, Object>();
                  result.put("status", "failed");
                  result.put("message",errorMessage);
                  mainResult.success(result);
                }
                @Override
                public void setWebViewProperties(@Nullable WebView webView, @Nullable Object o) {
                  //For setting webview properties, if any. Check Customized Integration section for more details on this
                }

                @Override
                public void generateHash(HashMap<String, String> valueMap, PayUHashGenerationListener hashGenerationListener) {
                  String hashName = valueMap.get(PayUCheckoutProConstants.CP_HASH_NAME);
                  String hashData = valueMap.get(PayUCheckoutProConstants.CP_HASH_STRING);
                  if (!TextUtils.isEmpty(hashName) && !TextUtils.isEmpty(hashData)) {
                    String hash = calculateHash(hashData + salt);
                    HashMap<String, String> dataMap = new HashMap<>();
                     if(this.showLogs){
                      Log.i(TAG,"----------");
                      Log.i(TAG,"Generating Hash for: "+hashName);
                      Log.i(TAG,"String: " + hashData);
                      Log.i(TAG,"Hash: "+ hash);
                    }
                    dataMap.put(hashName, hash);
                    hashGenerationListener.onHashGenerated(dataMap);
                  }
                }
              }
      );
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull @org.jetbrains.annotations.NotNull ActivityPluginBinding binding) {
this.activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull @org.jetbrains.annotations.NotNull ActivityPluginBinding binding) {

  }

  @Override
  public void onDetachedFromActivity() {
    this.activity=null;
  }

  private String calculateHash(String hashString) {
    try {
      MessageDigest messageDigest = MessageDigest.getInstance("SHA-512");
      messageDigest.update(hashString.getBytes());
      byte[] mdbytes = messageDigest.digest();
      return getHexString(mdbytes);
    }catch (Exception e){
      e.printStackTrace();
      return "";
    }
  }

  private String getHexString(byte[] array){
    StringBuilder hash = new StringBuilder();
    for (byte hashByte : array) {
      hash.append(Integer.toString((hashByte & 0xff) + 0x100, 16).substring(1));
    }
    return hash.toString();
  }


}
