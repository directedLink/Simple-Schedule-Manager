import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/main.dart';

void main() {
  testWidgets('App launches with empty task list', (WidgetTester tester) async {
    await tester.pumpWidget(ScheduleManagerApp());
    expect(find.text('No tasks added'), findsOneWidget); // 假设有这个文本提示
  });

  testWidgets('Adding a new task updates the task list', (WidgetTester tester) async {
    await tester.pumpWidget(ScheduleManagerApp());

    // 点击FloatingActionButton以添加任务
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();  // 等待页面加载

    // 找到输入框并输入任务信息
    await tester.enterText(find.byKey(Key('titleField')), 'Meeting with John');
    await tester.enterText(find.byKey(Key('descriptionField')), 'Project discussion');
    
    // 点击添加任务按钮
    await tester.tap(find.byKey(Key('addTaskButton')));
    await tester.pumpAndSettle();

    // 验证任务列表中出现了新添加的任务
    expect(find.text('Meeting with John'), findsOneWidget);
    expect(find.text('Project discussion'), findsOneWidget);
  });
}
