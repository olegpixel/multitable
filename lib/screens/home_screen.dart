import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/squares.dart';
import '../widgets/footer.dart';
import '../widgets/main_header.dart';
import 'practice_screen.dart';
import 'stats_screen.dart';
import 'exam_screen.dart';
import 'tables_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          MainHeader(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SquareMenuItem(
                        title: 'Tables',
                        backgroundImage: 'assets/images/sq1.png',
                        iconImage: Padding(
                          padding:
                              const EdgeInsets.only(bottom: 10.0, right: 15.0),
                          child: Image(
                            image: AssetImage(
                              'assets/images/034-board.png',
                            ),
                            width: 104.0,
                            height: 104.0,
                          ),
                        ),
                        backgroundColor: '#F9CF72',
                        pathTo: TablesScreen.routeName,
                        margins: EdgeInsets.only(
                            left: 20.0, top: 20.0, right: 7.0, bottom: 6.0),
                      ),
                      SquareMenuItem(
                        title: 'Practice',
                        backgroundImage: 'assets/images/sq2.png',
                        iconImage: Padding(
                          padding:
                              const EdgeInsets.only(bottom: 15.0, right: 15.0),
                          child: Image(
                            image: AssetImage(
                              'assets/images/satisfaction.png',
                            ),
                            width: 100.0,
                            height: 100.0,
                          ),
                        ),
                        backgroundColor: '#93d296',
                        pathTo: PracticeScreen.routeName,
                        margins: EdgeInsets.only(
                            left: 7.0, top: 20.0, right: 20.0, bottom: 6.0),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SquareMenuItem(
                        title: 'Exam',
                        backgroundImage: 'assets/images/sq3.png',
                        iconImage: Padding(
                          padding:
                              const EdgeInsets.only(bottom: 3.0, right: 15.0),
                          child: Image(
                            image: AssetImage(
                              'assets/images/049-cap.png',
                            ),
                            width: 110.0,
                            height: 110.0,
                          ),
                        ),
                        backgroundColor: '#B3EEFA',
                        pathTo: ExamScreen.routeName,
                        margins: EdgeInsets.only(
                            left: 20.0, top: 6.0, right: 7.0, bottom: 20.0),
                      ),
                      SquareMenuItem(
                        title: 'Progress',
                        backgroundImage: 'assets/images/sq4.png',
                        iconImage: Padding(
                          padding:
                              const EdgeInsets.only(bottom: 15.0, right: 15.0),
                          child: Image(
                            image: AssetImage(
                              'assets/images/020-calendar.png',
                            ),
                            width: 100.0,
                            height: 100.0,
                          ),
                        ),
                        backgroundColor: '#FFD5DF',
                        pathTo: StatsScreen.routeName,
                        margins: EdgeInsets.only(
                            left: 7.0, top: 6.0, right: 20.0, bottom: 20.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Footer(),
        ],
      ),
    );
  }
}
