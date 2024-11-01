import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/main.dart';

void main() {
  testWidgets('App launches with empty schedule list', (WidgetTester tester) async {
    // 构建应用并触发一帧渲染。
    await tester.pumpWidget(MyApp());

    // 验证应用启动时显示的无日程提示文本（假设为 "No schedules added"）。
    expect(find.text('No schedules added'), findsOneWidget);
  });

  testWidgets('Adding a new schedule updates the schedule list', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // 点击 FloatingActionButton 以添加日程
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();  // 等待页面加载

    // 找到输入框并输入日程信息
    await tester.enterText(find.byKey(const Key('titleField')), 'Team Meeting');
    await tester.enterText(find.byKey(const Key('descriptionField')), 'Discuss project goals');
    
    // 点击添加日程按钮
    await tester.tap(find.byKey(const Key('addScheduleButton')));
    await tester.pumpAndSettle();

    // 验证新添加的日程是否显示在列表中
    expect(find.text('Team Meeting'), findsOneWidget);
    expect(find.text('Discuss project goals'), findsOneWidget);
  });

  testWidgets('Deleting a schedule removes it from the list', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // 添加一个新日程
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('titleField')), 'Team Meeting');
    await tester.enterText(find.byKey(const Key('descriptionField')), 'Discuss project goals');
    await tester.tap(find.byKey(const Key('addScheduleButton')));
    await tester.pumpAndSettle();

    // 验证新添加的日程显示在列表中
    expect(find.text('Team Meeting'), findsOneWidget);

    // 点击删除图标删除该日程
    await tester.tap(find.byIcon(Icons.delete).first);
    await tester.pumpAndSettle();

    // 验证日程被从列表中移除
    expect(find.text('Team Meeting'), findsNothing);
  });
}
