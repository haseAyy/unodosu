import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:adventer_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // アプリをビルドして、フレームをトリガーします。
    await tester.pumpWidget(const MyApp());

    // カウンターが0から始まることを確認します。
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // '+' アイコンをタップしてフレームを再描画します。
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // カウンターがインクリメントされたことを確認します。
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
