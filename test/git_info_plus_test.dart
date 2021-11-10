import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_info_plus/git_info_plus.dart';

void main() {
  const MethodChannel channel = MethodChannel('git_info_plus');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getBranchName') {
        return 'main';
      } else if (methodCall.method == 'getLastCommitDate') {
        return '2021-01-01 18:00:00 +0900';
      } else if (methodCall.method == 'getLastCommitHash') {
        return 'ff4aa27opijo38jsdflajffdasfijoeqwifahf';
      } else if (methodCall.method == 'getLastCommitHashShort') {
        return 'ff4aa27';
      } else if (methodCall.method == 'getLastCommitMessage') {
        return 'Initial commit.';
      }

      return null;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('branchName', () async {
    expect(await GitInfo.branchName, 'main');
  });

  test('getLastCommitDate', () async {
    expect(await GitInfo.lastCommitDate, DateTime(2021, 01, 01, 18));
  });

  test('getLastCommitHash', () async {
    expect(await GitInfo.lastCommitHash, 'ff4aa27opijo38jsdflajffdasfijoeqwifahf');
  });

  test('getLastCommitHashShort', () async {
    expect(await GitInfo.lastCommitHashShort, 'ff4aa27');
  });

  test('getLastCommitMessage', () async {
    expect(await GitInfo.lastCommitMessage, 'Initial commit.');
  });
}
