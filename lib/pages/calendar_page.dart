import 'package:flutter/material.dart';
import 'schedule_page.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_focusedMonth.year}年 ${_focusedMonth.month}月'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              setState(() {
                _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
              });
            },
          ),
        ],
      ),
      body: _buildCalendar(),
    );
  }

  Widget _buildCalendar() {
    // 显示日期的代码
    return Column(
      children: List.generate(6, (week) {
        return Row(
          children: List.generate(7, (day) {
            final dayDate = DateTime(_focusedMonth.year, _focusedMonth.month, week * 7 + day + 1 - _focusedMonth.weekday);
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = dayDate;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SchedulePage(date: dayDate),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _selectedDate == dayDate ? Colors.blue[100] : Colors.white,
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  alignment: Alignment.center,
                  height: 50,
                  child: Text('${dayDate.day}'),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
