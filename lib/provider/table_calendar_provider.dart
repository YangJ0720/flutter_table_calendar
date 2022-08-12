import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarProvider extends ChangeNotifier {
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime get selectedDay => _selectedDay;

  void onDaySelected(DateTime selectedDay) {
    _selectedDay = selectedDay;
    notifyListeners();
  }

  CalendarFormat get calendarFormat => _calendarFormat;

  void onFormatChanged(CalendarFormat format) {
    _calendarFormat = format;
    notifyListeners();
  }
}
