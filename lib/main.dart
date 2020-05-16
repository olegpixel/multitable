import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/practice_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/exam_screen.dart';
import 'screens/tables_screen.dart';
import 'screens/test_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        TablesScreen.routeName: (ctx) => TablesScreen(),
        PracticeScreen.routeName: (ctx) => PracticeScreen(),
        ExamScreen.routeName: (ctx) => ExamScreen(),
        StatsScreen.routeName: (ctx) => StatsScreen(),
        TestScreen.routeName: (ctx) => TestScreen(),
      },
    );
  }
}
