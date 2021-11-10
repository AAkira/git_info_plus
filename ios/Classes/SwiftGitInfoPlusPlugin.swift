import Flutter
import UIKit

public class SwiftGitInfoPlusPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "git_info_plus", binaryMessenger: registrar.messenger())
    let instance = SwiftGitInfoPlusPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
    
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let info = Bundle.main.infoDictionary!
    
    if call.method == "getBranchName" {
      result("\(info["GitBranchName"]!)")
    } else if call.method == "getLastCommitDate" {
      result("\(info["GitCommitDate"]!)")
    } else if call.method == "getLastCommitHash" {
      result("\(info["GitCommitHash"]!)")
    } else if call.method == "getLastCommitHashShort" {
      result("\(info["GitCommitHashShort"]!)")
    } else if call.method == "getLastCommitMessage" {
      result("\(info["GitCommitMessage"]!)")
    } else {
      result(FlutterError.init(code: "NotImplemntedError", message: "Method does not exist.", details: nil));
    }
  }
}
