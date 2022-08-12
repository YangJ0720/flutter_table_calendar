import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_table_calendar/home.dart';
import 'package:flutter_table_calendar/provider/table_calendar_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TableCalendarProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Home(),
      supportedLocales: const [Locale('en', 'US'), Locale('zh', 'CH')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
    );
  }
}
