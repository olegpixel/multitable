import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_screen.dart';
import 'screens/practice_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/exam_screen.dart';
import 'screens/tables_screen.dart';
import 'screens/test_screen.dart';
import 'screens/test_exam_screen.dart';
import 'screens/test_results_screen.dart';
import 'screens/language_screen.dart';
import 'screens/settings_screen.dart';
import 'package:multitables/screens/game_dragndrop_screen.dart';
import 'package:multitables/screens/games_screen.dart';
import 'package:multitables/funcs/firebase_analytics.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:multitables/funcs/localisations.dart';
import 'package:multitables/funcs/app_lang.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multitables/datastore/progress_dao.dart';
import 'package:multitables/screens/answers_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(HIVE_PROGRESS_BOX);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          buttonTheme: ButtonThemeData(
            minWidth: 20,
//            minHeight: 10,
          ),
        ),
        navigatorObservers: <NavigatorObserver>[MyApp.observer],
        locale: _locale,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('ru', 'RU'),
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          // Check if the current device locale is supported
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          // If the locale of the device is not supported, use the first one
          // from the list (English, in this case).
          return Locale('en', 'US');
        },
        routes: {
          '/': (ctx) => HomeScreen(),
          TablesScreen.routeName: (ctx) => TablesScreen(),
          PracticeScreen.routeName: (ctx) => PracticeScreen(),
          ExamScreen.routeName: (ctx) => ExamScreen(),
          StatsScreen.routeName: (ctx) => StatsScreen(),
          TestResultsScreen.routeName: (ctx) => TestResultsScreen(),
          AnswersListScreen.routeName: (ctx) => AnswersListScreen(),
          LanguageScreen.routeName: (ctx) => LanguageScreen(),
          SettingsScreen.routeName: (ctx) => SettingsScreen(),
          GamesScreen.routeName: (ctx) => GamesScreen(),
          DragNDropGame.routeName: (ctx) => DragNDropGame(),
        },
        onGenerateRoute: (RouteSettings settings) {
          var routes = <String, WidgetBuilder>{
            TestScreen.routeName: (ctx) => TestScreen(settings.arguments),
            TestExamScreen.routeName: (ctx) => TestExamScreen(settings.arguments),
          };
          WidgetBuilder builder = routes[settings.name];
          return MaterialPageRoute(builder: (ctx) => builder(ctx));
        });
  }
}
