import 'package:awaitable_button/awaitable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AwaitableIconButton', () {
    final widget = MaterialApp(
      theme: ThemeData(
        iconTheme: const IconThemeData(
          size: 48,
        ),
      ),
      home: Scaffold(
        body: AwaitableIconButton<void>(
          onPressed: () async {
            await Future<void>.delayed(const Duration(seconds: 4));
          },
          icon: const Icon(Icons.label),
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
          final target = find.byType(AwaitableIconButton<void>);

          // ターゲットのWidgetが1つ見つかること
          expect(target, findsOneWidget);

          // IconButtonが1つ存在すること
          expect(find.byType(IconButton), findsOneWidget);

          // Icon Widgetが1つ存在すること
          expect(find.byType(Icon), findsOneWidget);

          // 指定の文字列を持つWidgetが1つ存在すること
          expect(find.byIcon(Icons.label), findsOneWidget);

          // ターゲット外のWidgetが存在しないこと
          expect(find.byType(ElevatedButton), findsNothing);
          expect(find.byType(TextButton), findsNothing);
          expect(find.byType(OutlinedButton), findsNothing);
          expect(find.byType(Text), findsNothing);
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
        final target = find.byType(AwaitableIconButton<void>);

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
        final target = find.byType(AwaitableIconButton<void>);

        /// タップ前のターゲットのサイズを取得して検証
        final sizeBeforeTap = tester.getSize(target);
        expect(sizeBeforeTap.height, equals(48 + 16));

        await tester.tap(target);
        await tester.pump(const Duration(seconds: 1));

        /// タップ後のターゲットのサイズを取得して検証
        final sizeAfterTap = tester.getSize(target);
        expect(sizeAfterTap.height, equals(48 + 16));
      });
    });
  });
}
