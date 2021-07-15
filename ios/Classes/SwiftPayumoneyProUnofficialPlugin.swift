import Flutter
import UIKit
import PayUCheckoutProKit
import PayUCheckoutProBaseKit
import PayUParamsKit

public class SwiftPayumoneyProUnofficialPlugin: NSObject, FlutterPlugin, PayUCheckoutProDelegate {
    var url:String = ""
    public func onPaymentSuccess(response: Any?) {
        
    }

    public func onPaymentFailure(response: Any?) {
        print(response)
    }

    public func onPaymentCancel(isTxnInitiated: Bool) {
        
    }

    public func onError(_ error: Error?) {
        print(error)
    }

    public func generateHash(for param: DictOfString, onCompletion: @escaping PayUHashGenerationCompletion) {
        // Send this string to your backend and append the salt at the end and send the sha512 back to us, do not calculate the hash at your client side, for security is reasons, hash has to be calculated at the server side
           let hashStringWithoutSalt = param[HashConstant.hashString] ?? ""
           // Or you can send below string hashName to your backend and send the sha512 back to us, do not calculate the hash at your client side, for security is reasons, hash has to be calculated at the server side
           let hashName = param[HashConstant.hashName] ?? ""
        generateChecksum(url: url, string: hashStringWithoutSalt, onComplete: {(response)-> Void in
            let hashFetchedFromServer = response
            onCompletion([hashName : hashFetchedFromServer])
            
        })
          
    }

    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "payumoney_pro_unofficial", binaryMessenger: registrar.messenger())
    let instance = SwiftPayumoneyProUnofficialPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if(call.method.elementsEqual("payUParams")){
        buildPaymentParams(result: result, args: call.arguments)
    }
  }
    
    
    private func buildPaymentParams(result: @escaping FlutterResult,args:Any?){
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
        paymentParam.additionalParam[PaymentParamConstant.udf1] = "udf1"
        paymentParam.additionalParam[PaymentParamConstant.udf2] = "udf2"
        paymentParam.additionalParam[PaymentParamConstant.udf3] = "udf3"
        paymentParam.additionalParam[PaymentParamConstant.udf4] = "udf4"
        paymentParam.additionalParam[PaymentParamConstant.udf5] = "udf5"
         
        paymentParam.userCredential=userCredentials
        
        let config = PayUCheckoutProConfig()
        config.merchantName = merchantName
        config.showExitConfirmationOnPaymentScreen = showExitConfirmation
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
