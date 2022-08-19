import 'package:flutter/material.dart';
import 'package:flutter_table_calendar/provider/table_calendar_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HeaderSliver extends SliverPersistentHeaderDelegate {
  final double _minExtent = 77;
  final double _maxExtent = 280;
  double _extent = 280;

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Positioned(
          child: Container(
            child: Consumer<TableCalendarProvider>(
              builder: (_, value, child) {
                var dateTime = value.selectedDay;
                var calendarFormat = value.calendarFormat;
                if (CalendarFormat.month == calendarFormat) {
                  _extent = _maxExtent;
                } else {
                  _extent = _minExtent;
                }
                return TableCalendar(
                  focusedDay: dateTime,
                  firstDay: dateTime,
                  lastDay: dateTime,
                  locale: 'zh',
                  headerVisible: false,
                  daysOfWeekHeight: 25,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarFormat: calendarFormat,
                  availableCalendarFormats: const {
                    CalendarFormat.week: 'Week',
                    CalendarFormat.month: 'Month',
                  },
                  selectedDayPredicate: (day) => isSameDay(dateTime, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    value.onDaySelected(selectedDay);
                  },
                  onFormatChanged: (CalendarFormat format) {
                    if (CalendarFormat.month == format) {
                      value.onFormatChanged(CalendarFormat.week);
                    } else {
                      value.onFormatChanged(CalendarFormat.month);
                    }
                  },
                  onPageChanged: (DateTime focusedDay) {
                    value.onDaySelected(focusedDay);
                  },
                );
              },
            ),
            color: Colors.black87,
          ),
          left: 0,
          top: 0,
          right: 0,
        ),
      ],
    );
  }

  @override
  double get maxExtent => _extent;

  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
