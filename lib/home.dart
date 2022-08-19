import 'package:flutter/material.dart';
import 'package:flutter_table_calendar/provider/table_calendar_provider.dart';
import 'package:flutter_table_calendar/repository/pointer_repository.dart';
import 'package:flutter_table_calendar/sliver/header_sliver.dart';
import 'package:flutter_table_calendar/widget/home_list_view.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _pixels = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverPersistentHeader(
                  delegate: HeaderSliver(),
                  pinned: true,
                ),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.only(top: 78),
            child: Listener(
              child: HomeListView(
                count: 50,
                onPointerMoveTop: (double pixels) => _pixels = pixels,
              ),
              onPointerDown: (PointerDownEvent event) {
                PointerRepository.instance.setEnable(true);
              },
              onPointerMove: (PointerMoveEvent event) {
                var repository = PointerRepository.instance;
                if (repository.isEnable && _pixels == 0) {
                  var y = event.delta.dy;
                  if (y < 0) {
                    // 手指向上滑动
                    var provider = Provider.of<TableCalendarProvider>(
                      context,
                      listen: false,
                    );
                    if (CalendarFormat.month == provider.calendarFormat) {
                      repository.setEnable(false);
                      provider.onFormatChanged(CalendarFormat.week);
                    }
                  } else if (y > 0) {
                    // 手指向下滑动
                    var provider = Provider.of<TableCalendarProvider>(
                      context,
                      listen: false,
                    );
                    if (CalendarFormat.week == provider.calendarFormat) {
                      repository.setEnable(false);
                      provider.onFormatChanged(CalendarFormat.month);
                    }
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
