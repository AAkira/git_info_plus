package io.github.aakira.git_info_plus

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** GitInfoPlusPlugin */
class GitInfoPlusPlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "git_info_plus")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getBranchName" -> result.success(BuildConfig.GIT_BRANCH_NAME)
            "getLastCommitDate" -> result.success(BuildConfig.GIT_LAST_COMMIT_DATE)
            "getLastCommitHash" -> result.success(BuildConfig.GIT_LAST_COMMIT_HASH)
            "getLastCommitHashShort" -> result.success(BuildConfig.GIT_LAST_COMMIT_HASH_SHORT)
            "getLastCommitMessage" -> result.success(BuildConfig.GIT_LAST_COMMIT_MESSAGE)
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
