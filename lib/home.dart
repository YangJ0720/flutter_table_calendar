import 'package:flutter/material.dart';
import 'package:flutter_table_calendar/provider/table_calendar_provider.dart';
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
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      ScrollPosition position = _controller.position;
      debugPrint('position = ${position.pixels}');
      // if (position.pixels == 0) {
      //   var provider = Provider.of<TableCalendarProvider>(
      //     context,
      //     listen: false,
      //   );
      //   if (CalendarFormat.week == provider.calendarFormat) {
      //     provider.onFormatChanged(CalendarFormat.month);
      //   }
      // } else if (position.pixels > 0) {
      //   var provider = Provider.of<TableCalendarProvider>(
      //     context,
      //     listen: false,
      //   );
      //   if (CalendarFormat.month == provider.calendarFormat) {
      //     provider.onFormatChanged(CalendarFormat.week);
      //   }
      // }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverPersistentHeader(delegate: HeaderSliver(), pinned: true),
            ];
          },
          body: const HomeListView(count: 50),
          // controller: _controller,
        ),
      ),
    );
  }
}
