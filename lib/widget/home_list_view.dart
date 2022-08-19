import 'package:flutter/material.dart';
import 'package:flutter_table_calendar/provider/table_calendar_provider.dart';
import 'package:flutter_table_calendar/repository/pointer_repository.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

typedef OnPointerMoveTop = void Function(double pixels);

class HomeListView extends StatefulWidget {
  final int count;
  final OnPointerMoveTop? onPointerMoveTop;

  const HomeListView({Key? key, this.count = 0, this.onPointerMoveTop}) : super(key: key);

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
      widget.onPointerMoveTop?.call(pixels);
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
            var key = ValueKey(index);
            return ListTile(key: key, title: Text(index.toString()));
          },
          itemCount: widget.count,
          onReorder: (int oldIndex, int newIndex) {},
          scrollController: _controller,
          physics: const AlwaysScrollableScrollPhysics(),
        ),
        controller: _controller,
      );
    } else {
      view = ListView(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: const Text('暂无数据'),
            color: Colors.grey[200],
            padding: const EdgeInsets.only(top: 200),
          ),
        ],
      );
    }
    return RefreshIndicator(
      child: view,
      onRefresh: () async {
        return await Future.delayed(const Duration(seconds: 1));
      },
      notificationPredicate: (ScrollNotification notification) {
        var provider = Provider.of<TableCalendarProvider>(
          context,
          listen: false,
        );
        var format = provider.calendarFormat;
        var isEnable = PointerRepository.instance.isEnable;
        if (CalendarFormat.week == format && !isEnable) {
          return true;
        }
        return CalendarFormat.month == format && isEnable;
      },
    );
  }
}
