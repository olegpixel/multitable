import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/practice_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/exam_screen.dart';
import 'screens/tables_screen.dart';
import 'screens/test_screen.dart';
import 'screens/test_results_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multitables/datastore/constants.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(hiveProgressBox);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (ctx) => HomeScreen(),
          TablesScreen.routeName: (ctx) => TablesScreen(),
          PracticeScreen.routeName: (ctx) => PracticeScreen(),
          ExamScreen.routeName: (ctx) => ExamScreen(),
          StatsScreen.routeName: (ctx) => StatsScreen(),
          TestResultsScreen.routeName: (ctx) => TestResultsScreen(),
//          TestScreen.routeName: (ctx) => TestScreen(),
        },
        onGenerateRoute: (RouteSettings settings) {
          var routes = <String, WidgetBuilder>{
            TestScreen.routeName: (ctx) => TestScreen(settings.arguments),
          };
          WidgetBuilder builder = routes[settings.name];
          return MaterialPageRoute(builder: (ctx) => builder(ctx));
        });
  }
}
