import Flutter
import UIKit
import PayUCheckoutProKit
import PayUCheckoutProBaseKit
import PayUParamsKit

public class SwiftPayumoneyProUnofficialPlugin: NSObject, FlutterPlugin, PayUCheckoutProDelegate {

    var url:String = ""
    var logs = false
    var mainResult:FlutterResult?
    public func onPaymentSuccess(response: Any?) {
        print("Payment Successful")
        self.mainResult!(response)
    }

    public func onPaymentFailure(response: Any?) {
        print(response ?? "Payment Failed. Something Went Wrong")
        let map:[String:Any] = ["status":"failed","message":response ?? "Something Went Wrong"]
        self.mainResult!(map)
    }

    public func onPaymentCancel(isTxnInitiated: Bool) {
        print("Payment Cancelled")
        let map:[String:Any] = ["status":"failed","message":"Payment Cancelled"]
        self.mainResult!(map)
    }

    public func onError(_ error: Error?) {
        print(error ?? "Payment Error. Something Went Wrong")
        let map:[String:Any] = ["status":"failed","message":error ?? "Something Went Wrong"]
        self.mainResult!(map)
    }

    public func generateHash(for param: DictOfString, onCompletion: @escaping PayUHashGenerationCompletion) {
        // Send this string to your backend and append the salt at the end and send the sha512 back to us, do not calculate the hash at your client side, for security is reasons, hash has to be calculated at the server side
           let hashStringWithoutSalt = param[HashConstant.hashString] ?? ""
           // Or you can send below string hashName to your backend and send the sha512 back to us, do not calculate the hash at your client side, for security is reasons, hash has to be calculated at the server side
           let hashName = param[HashConstant.hashName] ?? ""
        generateChecksum(url: url, string: hashStringWithoutSalt, onComplete: {(response)-> Void in
            let hashFetchedFromServer = response
            if(self.logs){
                print("Generating Hash for: " + hashName)
                print("String: " + hashStringWithoutSalt)
                print("Hash from Server:" + hashFetchedFromServer)
            }
            onCompletion([hashName : hashFetchedFromServer])
            
        })
          
    }

    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "payumoney_pro_unofficial", binaryMessenger: registrar.messenger())
    let instance = SwiftPayumoneyProUnofficialPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    self.mainResult=result
    if(call.method.elementsEqual("payUParams")){
        buildPaymentParams(result: result, args: call.arguments)
    }
  }
    
    
    private func buildPaymentParams(result: @escaping FlutterResult,args:Any?){
//        Storing incoming data into variables
        let argsMap = args as! NSDictionary
        self.url = argsMap["hash"] as! String
        let amount = argsMap["amount"] as! String
        let isProduction = argsMap["isProduction"] as! Bool
        let productInfo = argsMap["productInfo"] as! String
        let merchantKey = argsMap["merchantKey"] as! String
        let userPhoneNumber = argsMap["userPhoneNumber"] as! String
        let transactionId = argsMap["transactionId"] as! String
        let firstName = argsMap["firstName"] as! String
        let email = argsMap["email"] as! String
        let merchantName = argsMap["merchantName"] as! String
        let showExitConfirmation = argsMap["showExitConfirmation"] as! Bool
        let successURL = argsMap["successURL"] as! String
        let failureURL = argsMap["failureURL"] as! String
        let userCredentials = argsMap["userCredentials"] as! String
        let showLogs = argsMap["showLogs"] as? Bool ?? false
        logs = showLogs
        
//        Logging if showLog is true
        if(logs){
            print("=====================")
            print("Debug Mode is Enabled")
            print("=====================")
            print("Parameters Passed to the PayUMoneyCheckoutPro SDK")
            print("amount: " + amount)
            print("isProduction: " + isProduction.description)
            print("productInfo: " + productInfo)
            print("merchantKey: " + merchantKey)
            print("Phone: " + userPhoneNumber)
            print("Transaction ID: " + transactionId)
            print("FirstName: " + firstName)
            print("Email: " + email)
            print("Merchant Name: " + merchantName)
            print("showExitConfirmation: " + showExitConfirmation.description)
            print("sURL: " + successURL)
            print("fURL: " + failureURL)
            print("userCredential: " + userCredentials)
        }
        
//         Initating Payment Now
        let paymentParam = PayUPaymentParam(key: merchantKey,
                                    transactionId: transactionId,
                                    amount: amount,
                                    productInfo: productInfo,
                                    firstName: firstName,
                                    email: email,
                                    phone: userPhoneNumber,
                                    surl: successURL,
                                    furl: failureURL,
                                    environment: isProduction ? .production : .test)
//        Optional Field
        paymentParam.userCredential=userCredentials
        
//        Additional Fields for SDK
        paymentParam.additionalParam[PaymentParamConstant.udf1] = "udf1"
        paymentParam.additionalParam[PaymentParamConstant.udf2] = "udf2"
        paymentParam.additionalParam[PaymentParamConstant.udf3] = "udf3"
        paymentParam.additionalParam[PaymentParamConstant.udf4] = "udf4"
        paymentParam.additionalParam[PaymentParamConstant.udf5] = "udf5"

//        UI Configuration
        let config = PayUCheckoutProConfig()
        config.merchantName = merchantName
        config.showExitConfirmationOnPaymentScreen = showExitConfirmation

//        Starting Payment
        if(logs){
         print("Initating Payment")
        }

        PayUCheckoutPro.open(on: UIApplication.getTopViewController()!,paymentParam: paymentParam, config:config, delegate: self)
    }
    
    

    
}

extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
