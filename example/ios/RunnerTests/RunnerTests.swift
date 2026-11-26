import Flutter
import Testing
import UIKit


@testable import git_info_plus

struct RunnerTests {

  @Test func getBranchNameReturnsInfoPlistValueOrNil() async {
    let plugin = GitInfoPlusPlugin()
    let call = FlutterMethodCall(methodName: "getBranchName", arguments: nil)

    let result = await withCheckedContinuation { continuation in
      plugin.handle(call) { continuation.resume(returning: $0) }
    }

    let plistValue = Bundle.main.infoDictionary?["GitBranchName"] as? String
    #expect(result as? String == (plistValue?.isEmpty == false ? plistValue : nil))
  }

  @Test func unknownMethodReturnsError() async {
    let plugin = GitInfoPlusPlugin()
    let call = FlutterMethodCall(methodName: "unknown", arguments: nil)

    let result = await withCheckedContinuation { continuation in
      plugin.handle(call) { continuation.resume(returning: $0) }
    }

    #expect((result as? FlutterError)?.code == "NotImplemntedError")
  }

}
