import Flutter
import UIKit

public class SwiftPayumoneyProUnofficialPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "payumoney_pro_unofficial", binaryMessenger: registrar.messenger())
    let instance = SwiftPayumoneyProUnofficialPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
