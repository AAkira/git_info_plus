import 'dart:async';

import 'package:flutter/services.dart';

class GitInfo {
  static const MethodChannel _channel = MethodChannel('git_info_plus');

  static Future<String?> get branchName =>
      _channel.invokeMethod('getBranchName');

  static Future<DateTime?> get lastCommitDate async {
    final String dateString = await _channel.invokeMethod('getLastCommitDate');

    try {
      return DateTime.parse(dateString).toLocal();
    } catch (_) {
      return null;
    }
  }

  static Future<String?> get lastCommitHash =>
      _channel.invokeMethod('getLastCommitHash');

  static Future<String?> get lastCommitHashShort =>
      _channel.invokeMethod('getLastCommitHashShort');

  static Future<String?> get lastCommitMessage =>
      _channel.invokeMethod('getLastCommitMessage');
}
