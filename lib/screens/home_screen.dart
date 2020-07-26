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
import 'package:rate_my_app/rate_my_app.dart';
import 'package:multitables/funcs/firebase_analytics.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 4,
    minLaunches: 5,
    remindDays: 3,
    remindLaunches: 5,
  );

  @override
  void initState() {
    super.initState();
    _rateMyApp.init().then((_) {
      if (_rateMyApp.shouldOpenDialog) {
        _rateMyApp.showRateDialog(
          context,
          title: AppLocalizations.of(context).translate('rate-us_title'),
          // The dialog title.
          message: AppLocalizations.of(context).translate('rate-us_desc'),
          // The dialog message.
          rateButton: AppLocalizations.of(context).translate('rate-us_rate-button'),
          // The dialog "rate" button text.
          noButton: AppLocalizations.of(context).translate('rate-us_no-button'),
          // The dialog "no" button text.
          laterButton: AppLocalizations.of(context).translate('rate-us_later-button'),
          // The dialog "later" button text.
          listener: (button) {
            // The button click listener (useful if you want to cancel the click event).
            switch (button) {
              case RateMyAppDialogButton.rate:
                print('Clicked on "Rate".');
                analytics.logEvent(name: 'rate_us_yes');
                break;
              case RateMyAppDialogButton.later:
                print('Clicked on "Later".');
                analytics.logEvent(name: 'rate_us_later');
                break;
              case RateMyAppDialogButton.no:
                print('Clicked on "No".');
                analytics.logEvent(name: 'rate_us_no');
                break;
            }

            return true; // Return false if you want to cancel the click event.
          },
          ignoreIOS: false,
          // Set to false if you want to show the Apple's native app rating dialog on iOS.
          dialogStyle: DialogStyle(),
          // Custom dialog styles.
          onDismissed: () => _rateMyApp.callEvent(RateMyAppEventType
              .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
          // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
          // actionsBuilder: (context) => [], // This one allows you to use your own buttons.
        );
      }
    });
  }

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
                                width: 110.0 * wc,
                                height: 110.0 * hc,
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

//class HomeScreen extends StatelessWidget {
//  RateMyApp _rateMyApp = RateMyApp(
//    preferencesPrefix: 'rateMyApp_',
//    minDays: 4,
//    minLaunches: 5,
//    remindDays: 3,
//    remindLaunches: 5,
//  );
//
//  @override
//  Widget build(BuildContext context) {
//    final mediaQuerySize = MediaQuery.of(context);
//    final screenWidth = mediaQuerySize.size.width;
//    final screenHeight = mediaQuerySize.size.height;
//    final hc = screenHeight / 683;
//    final wc = screenWidth / 411;
//
//    return Container(
//      color: Color(0xff599BF0),
//      child: SafeArea(
//        child: Scaffold(
//          body: Column(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            children: <Widget>[
//              MainHeader(),
//              Expanded(
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                  children: <Widget>[
//                    Expanded(
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        crossAxisAlignment: CrossAxisAlignment.stretch,
//                        children: <Widget>[
//                          SquareMenuItem(
//                            title: AppLocalizations.of(context).translate('home-screen_squares-tables'),
//                            backgroundImage: 'assets/images/sq2.png',
//                            iconImage: Padding(
//                              padding: EdgeInsets.only(bottom: 10.0 * hc, right: 10.0 * wc),
//                              child: Image(
//                                image: AssetImage(
//                                  'assets/images/book.png',
//                                ),
//                                width: 110.0 * wc,
//                                height: 110.0 * hc,
//                              ),
//                            ),
//                            backgroundColor: 0xff93d296,
//                            pathTo: TablesScreen.routeName,
//                            margins:
//                                EdgeInsets.only(left: 20.0 * wc, top: 20.0 * hc, right: 7.0 * wc, bottom: 6.0 * hc),
//                            wc: wc,
//                            hc: hc,
//                          ),
//                          SquareMenuItem(
//                            title: AppLocalizations.of(context).translate('home-screen_squares-practice'),
//                            backgroundImage: 'assets/images/sq1.png',
//                            iconImage: Padding(
//                              padding: EdgeInsets.only(bottom: 10.0 * hc, right: 10.0 * wc),
//                              child: Image(
//                                image: AssetImage(
//                                  'assets/images/clipboard.png',
//                                ),
//                                width: 110.0 * wc,
//                                height: 110.0 * hc,
//                              ),
//                            ),
//                            backgroundColor: 0xffF9CF72,
//                            pathTo: PracticeScreen.routeName,
//                            margins:
//                                EdgeInsets.only(left: 7.0 * wc, top: 20.0 * hc, right: 20.0 * wc, bottom: 6.0 * hc),
//                            wc: wc,
//                            hc: hc,
//                          ),
//                        ],
//                      ),
//                    ),
//                    Expanded(
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        crossAxisAlignment: CrossAxisAlignment.stretch,
//                        children: <Widget>[
//                          SquareMenuItem(
//                            title: AppLocalizations.of(context).translate('home-screen_squares-exam'),
//                            backgroundImage: 'assets/images/sq3.png',
//                            iconImage: Padding(
//                              padding: EdgeInsets.only(bottom: 10.0 * hc, right: 10.0 * wc),
//                              child: Image(
//                                image: AssetImage(
//                                  'assets/images/graduation-cap.png',
//                                ),
//                                width: 110.0 * wc,
//                                height: 110.0 * hc,
//                              ),
//                            ),
//                            backgroundColor: 0xffB3EEFA,
//                            pathTo: ExamScreen.routeName,
//                            margins:
//                                EdgeInsets.only(left: 20.0 * wc, top: 6.0 * hc, right: 7.0 * wc, bottom: 20.0 * hc),
//                            wc: wc,
//                            hc: hc,
//                          ),
//                          SquareMenuItem(
//                            title: AppLocalizations.of(context).translate('home-screen_squares-progress'),
//                            backgroundImage: 'assets/images/sq4.png',
//                            iconImage: Padding(
//                              padding: EdgeInsets.only(bottom: 10.0 * hc, right: 10.0 * wc),
//                              child: Image(
//                                image: AssetImage(
//                                  'assets/images/monitoring.png',
//                                ),
//                                width: 110.0 * wc,
//                                height: 110.0 * hc,
//                              ),
//                            ),
//                            backgroundColor: 0xffFFD5DF,
//                            pathTo: StatsScreen.routeName,
//                            margins:
//                                EdgeInsets.only(left: 7.0 * wc, top: 6.0 * hc, right: 20.0 * wc, bottom: 20.0 * hc),
//                            wc: wc,
//                            hc: hc,
//                          ),
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              Footer(),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
