import 'package:flutter/material.dart';
import 'package:flutter_table_calendar/provider/table_calendar_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeListView extends StatefulWidget {
  final int count;

  const HomeListView({Key? key, this.count = 0}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListView> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      ScrollPosition position = _controller.position;
      double pixels = position.pixels;
      double extentInside = position.extentInside;
      print('extentInside = $extentInside');
      if (pixels == 0) {
        var provider = Provider.of<TableCalendarProvider>(
          context,
          listen: false,
        );
        if (CalendarFormat.week == provider.calendarFormat) {
          provider.onFormatChanged(CalendarFormat.month);
        }
      } else if (pixels > 0) {
        var provider = Provider.of<TableCalendarProvider>(
          context,
          listen: false,
        );
        if (CalendarFormat.month == provider.calendarFormat) {
          provider.onFormatChanged(CalendarFormat.week);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget view;
    if (widget.count > 0) {
      view = Scrollbar(
        child: ReorderableListView.builder(
          itemBuilder: (_, index) {
            return ListTile(
              key: ValueKey(index),
              title: Text(index.toString()),
              onTap: () => print('index = $index'),
            );
          },
          itemCount: widget.count,
          onReorder: (int oldIndex, int newIndex) {},
          scrollController: _controller,
          physics: const AlwaysScrollableScrollPhysics(),
        ),
      );
    } else {
      Size size = MediaQuery.of(context).size;
      view = ListView(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: const Text('暂无数据'),
            width: size.width,
            height: size.height,
            color: Colors.grey[200],
            padding: const EdgeInsets.only(top: 200),
          ),
        ],
        controller: _controller,
        physics: const AlwaysScrollableScrollPhysics(),
      );
    }
    return RefreshIndicator(
      child: view,
      onRefresh: () async {
        return await Future.delayed(const Duration(seconds: 1));
      },
    );
  }
}
