import 'package:flutter/material.dart';
import 'models/schedule.dart';

class ScheduleProvider with ChangeNotifier {
  final Map<DateTime, List<Schedule>> _schedules = {};

  List<Schedule> getSchedules(DateTime date) {
    return _schedules[date] ?? [];
  }

  void addSchedule(Schedule schedule) {
    final date = DateTime(schedule.date.year, schedule.date.month, schedule.date.day);
    if (_schedules[date] == null) {
      _schedules[date] = [];
    }
    _schedules[date]!.add(schedule);
    notifyListeners();
  }

  void removeSchedule(Schedule schedule) {
    final date = DateTime(schedule.date.year, schedule.date.month, schedule.date.day);
    _schedules[date]?.remove(schedule);
    notifyListeners();
  }
}
