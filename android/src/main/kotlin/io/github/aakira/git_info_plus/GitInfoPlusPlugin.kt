package io.github.aakira.git_info_plus

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** GitInfoPlusPlugin */
class GitInfoPlusPlugin: FlutterPlugin, MethodCallHandler {

  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "git_info_plus")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getBranchName") {
      result.success(BuildConfig.GIT_BRANCH_NAME)
    } else if (call.method == "getLastCommitDate") {
      result.success(BuildConfig.GIT_LAST_COMMIT_DATE)
    } else if (call.method == "getLastCommitHash") {
      result.success(BuildConfig.GIT_LAST_COMMIT_HASH)
    } else if (call.method == "getLastCommitHashShort") {
      result.success(BuildConfig.GIT_LAST_COMMIT_HASH_SHORT)
    } else if (call.method == "getLastCommitMessage") {
      result.success(BuildConfig.GIT_LAST_COMMIT_MESSAGE)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
