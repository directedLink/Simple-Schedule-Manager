// lib/main.dart
import 'package:flutter/material.dart';
import 'models/task.dart';
import 'screens/add_task_screen.dart';

void main() => runApp(ScheduleManagerApp());

class ScheduleManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schedule Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState(); 
  final List<Task> tasks = [
    Task(title: 'Meeting with John', description: 'Discuss project updates', date: DateTime.now().add(Duration(days: 1))),
    Task(title: 'Gym Session', description: 'Leg day workout', date: DateTime.now().add(Duration(days: 2))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Manager'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.description),
            trailing: Text('${task.date.month}/${task.date.day} ${task.date.hour}:${task.date.minute}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to task creation page
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  void _addNewTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Schedule Manager')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.description),
            trailing: Text('${task.date.month}/${task.date.day} ${task.date.hour}:${task.date.minute}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddTaskScreen(onTaskAdd: _addNewTask),
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
