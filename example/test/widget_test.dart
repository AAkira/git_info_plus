import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_info_plus_example/main.dart';

void main() {
  const channel = MethodChannel('git_info_plus');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      return switch (methodCall.method) {
        'getBranchName' => 'main',
        'getLastCommitDate' => '2021-01-01 18:00:00 +0900',
        'getLastCommitHash' => 'ff4aa27opijo38jsdflajffdasfijoeqwifahf',
        'getLastCommitHashShort' => 'ff4aa27',
        'getLastCommitMessage' => 'Initial commit.',
        _ => null,
      };
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  testWidgets('Shows git information', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('main'), findsOneWidget);
    expect(
      find.text(DateTime.utc(2021, 1, 1, 9).toLocal().toString()),
      findsOneWidget,
    );
    expect(
      find.text('ff4aa27opijo38jsdflajffdasfijoeqwifahf'),
      findsOneWidget,
    );
    expect(find.text('ff4aa27'), findsOneWidget);
    expect(find.text('Initial commit.'), findsOneWidget);
  });
}
