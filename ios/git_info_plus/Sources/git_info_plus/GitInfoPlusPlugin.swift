import Flutter
import UIKit

public class GitInfoPlusPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "git_info_plus", binaryMessenger: registrar.messenger())
    let instance = GitInfoPlusPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  private static let infoKeys = [
    "getBranchName": "GitBranchName",
    "getLastCommitDate": "GitCommitDate",
    "getLastCommitHash": "GitCommitHash",
    "getLastCommitHashShort": "GitCommitHashShort",
    "getLastCommitMessage": "GitCommitMessage",
  ]

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let key = Self.infoKeys[call.method] else {
      result(FlutterError.init(code: "NotImplemntedError", message: "Method does not exist.", details: nil))
      return
    }

    let value = Bundle.main.infoDictionary?[key].map { "\($0)" }
    result(value?.isEmpty == false ? value : nil)
  }
}
