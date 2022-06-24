import 'package:awaitable_button/awaitable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AwaitableTextButton', () {
    final widget = MaterialApp(
      theme: ThemeData(
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: TextButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
          ),
        ),
      ),
      home: Scaffold(
        body: AwaitableTextButton<void>(
          onPressed: () async {
            await Future<void>.delayed(const Duration(seconds: 4));
          },
          child: const Text('Test Button'),
        ),
      ),
    );
    testWidgets(
      '初期表示に必要なWidgetが存在し、不要なWidgetが存在しないこと',
      (WidgetTester tester) async {
        /// AwaitableButtonが非同期処理を持つため、runAsyncでラップする必要がある
        await tester.runAsync(() async {
          // テスト用のWidgetツリーを構築
          await tester.pumpWidget(widget);

          // テストターゲットWidgetを検索
          final target = find.byType(AwaitableTextButton<void>);

          // ターゲットのWidgetが1つ見つかること
          expect(target, findsOneWidget);

          // TextButtonが1つ存在すること
          expect(find.byType(TextButton), findsOneWidget);

          // Text Widgetが1つ存在すること
          expect(find.byType(Text), findsOneWidget);

          // 指定の文字列を持つWidgetが1つ存在すること
          expect(find.text('Test Button'), findsOneWidget);

          // ターゲット外のWidgetが存在しないこと
          expect(find.byType(OutlinedButton), findsNothing);
          expect(find.byType(ElevatedButton), findsNothing);
          expect(find.byType(IconButton), findsNothing);
          expect(find.byType(Icon), findsNothing);
        });
      },
    );

    testWidgets('タップ後にCircularProgressIndicatorが存在すること',
        (WidgetTester tester) async {
      /// AwaitableButtonが非同期処理を持つため、runAsyncでラップする必要がある
      await tester.runAsync(() async {
        // テスト用のWidgetツリーを構築
        await tester.pumpWidget(widget);

        // テストターゲットWidgetを検索
        final target = find.byType(AwaitableTextButton<void>);

        /// タップ前なのでインジケータは存在しないこと
        expect(find.byType(CircularProgressIndicator), findsNothing);

        await tester.tap(target);
        await tester.pump(const Duration(seconds: 1));

        /// タップ後なのでインジケータWidgetが1つ存在すること
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    testWidgets('タップ前・タップ後ともにThemeDataで指定されたSizeであること',
        (WidgetTester tester) async {
      /// AwaitableButtonが非同期処理を持つため、runAsyncでラップする必要がある
      await tester.runAsync(() async {
        // テスト用のWidgetツリーを構築
        await tester.pumpWidget(widget);

        // テストターゲットWidgetを検索
        final target = find.byType(AwaitableTextButton<void>);

        /// タップ前のターゲットのサイズを取得して検証
        final sizeBeforeTap = tester.getSize(target);
        expect(sizeBeforeTap.height, equals(48));

        await tester.tap(target);
        await tester.pump(const Duration(seconds: 1));

        /// タップ後のターゲットのサイズを取得して検証
        final sizeAfterTap = tester.getSize(target);
        expect(sizeAfterTap.height, equals(48));
      });
    });
  });
}
