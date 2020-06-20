import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multitables/widgets/squares.dart';
import 'package:multitables/widgets/footer.dart';
import 'package:multitables/widgets/main_header.dart';
import 'package:multitables/screens/practice_screen.dart';
import 'package:multitables/screens/stats_screen.dart';
import 'package:multitables/screens/exam_screen.dart';
import 'package:multitables/screens/tables_screen.dart';
import 'package:multitables/funcs/localisations.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context);
    final screenWidth = mediaQuerySize.size.width;
    final screenHeight = mediaQuerySize.size.height;
    final hc = screenHeight / 683;
    final wc = screenWidth / 411;

    return Container(
      color: Color(0xff599BF0),
      child: SafeArea(
        child: Scaffold(
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
                            title: AppLocalizations.of(context).translate('home-screen_squares-tables'),
                            backgroundImage: 'assets/images/sq2.png',
                            iconImage: Padding(
                              padding: EdgeInsets.only(bottom: 10.0 * hc, right: 10.0 * wc),
                              child: Image(
                                image: AssetImage(
                                  'assets/images/book.png',
                                ),
                                width: 110.0 * wc,
                                height: 110.0 * hc,
                              ),
                            ),
                            backgroundColor: 0xff93d296,
                            pathTo: TablesScreen.routeName,
                            margins:
                                EdgeInsets.only(left: 20.0 * wc, top: 20.0 * hc, right: 7.0 * wc, bottom: 6.0 * hc),
                            wc: wc,
                            hc: hc,
                          ),
                          SquareMenuItem(
                            title: AppLocalizations.of(context).translate('home-screen_squares-practice'),
                            backgroundImage: 'assets/images/sq1.png',
                            iconImage: Padding(
                              padding: EdgeInsets.only(bottom: 10.0 * hc, right: 10.0 * wc),
                              child: Image(
                                image: AssetImage(
                                  'assets/images/clipboard.png',
                                ),
                                width: 110.0 * wc,
                                height: 110.0 * hc,
                              ),
                            ),
                            backgroundColor: 0xffF9CF72,
                            pathTo: PracticeScreen.routeName,
                            margins:
                                EdgeInsets.only(left: 7.0 * wc, top: 20.0 * hc, right: 20.0 * wc, bottom: 6.0 * hc),
                            wc: wc,
                            hc: hc,
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
                            title: AppLocalizations.of(context).translate('home-screen_squares-exam'),
                            backgroundImage: 'assets/images/sq3.png',
                            iconImage: Padding(
                              padding: EdgeInsets.only(bottom: 10.0 * hc, right: 10.0 * wc),
                              child: Image(
                                image: AssetImage(
                                  'assets/images/graduation-cap.png',
                                ),
                                width: 115.0 * wc,
                                height: 115.0 * hc,
                              ),
                            ),
                            backgroundColor: 0xffB3EEFA,
                            pathTo: ExamScreen.routeName,
                            margins:
                                EdgeInsets.only(left: 20.0 * wc, top: 6.0 * hc, right: 7.0 * wc, bottom: 20.0 * hc),
                            wc: wc,
                            hc: hc,
                          ),
                          SquareMenuItem(
                            title: AppLocalizations.of(context).translate('home-screen_squares-progress'),
                            backgroundImage: 'assets/images/sq4.png',
                            iconImage: Padding(
                              padding: EdgeInsets.only(bottom: 10.0 * hc, right: 10.0 * wc),
                              child: Image(
                                image: AssetImage(
                                  'assets/images/monitoring.png',
                                ),
                                width: 110.0 * wc,
                                height: 110.0 * hc,
                              ),
                            ),
                            backgroundColor: 0xffFFD5DF,
                            pathTo: StatsScreen.routeName,
                            margins:
                                EdgeInsets.only(left: 7.0 * wc, top: 6.0 * hc, right: 20.0 * wc, bottom: 20.0 * hc),
                            wc: wc,
                            hc: hc,
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
        ),
      ),
    );
  }
}
