import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/schedule.dart';
import '../schedule_provider.dart';

class SchedulePage extends StatelessWidget {
  final DateTime date;

  SchedulePage({required this.date});

  @override
  Widget build(BuildContext context) {
    final schedules = context.watch<ScheduleProvider>().getSchedules(date);

    return Scaffold(
      appBar: AppBar(
        title: Text('${date.year}年 ${date.month}月 ${date.day}日的日程'),
      ),
      body: ListView.builder(
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          final schedule = schedules[index];
          return ListTile(
            title: Text(schedule.content),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                context.read<ScheduleProvider>().removeSchedule(schedule);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddScheduleDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddScheduleDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('添加日程'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: '输入日程内容'),
          ),
          actions: [
            TextButton(
              child: Text('取消'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('添加'),
              onPressed: () {
                final content = _controller.text;
                if (content.isNotEmpty) {
                  final schedule = Schedule(date: date, content: content);
                  context.read<ScheduleProvider>().addSchedule(schedule);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
