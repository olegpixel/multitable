import 'package:flutter/material.dart';
import 'package:multitables/models/test_results.dart';
import 'package:multitables/models/problem.dart';
import 'package:multitables/widgets/styled_button.dart';
import 'package:multitables/screens/test_screen.dart';
import 'package:multitables/screens/test_exam_screen.dart';
import 'package:multitables/screens/answers_list_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:multitables/funcs/localisations.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'dart:math';

class TestResultsScreen extends StatefulWidget {
  static const routeName = '/test-results';

  @override
  _TestResultsScreenState createState() => _TestResultsScreenState();
}

class _TestResultsScreenState extends State<TestResultsScreen> {
  MobileAdTargetingInfo targetingInfo;
  InterstitialAd myInterstitial;

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () {
      final TestResults args = ModalRoute.of(context).settings.arguments;
      if (args.nextLevelModal) {
        showSimpleCustomDialog(context, args);
      }
    });

    targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['education', 'kids', 'learn', 'math', 'mathamatics', 'school', 'children'],
      childDirected: true,
      testDevices: <String>[], // Android emulators are considered test devices
    );
    myInterstitial = InterstitialAd(
      // Replace the testAdUnitId with an ad unit id from the AdMob dash.
      adUnitId: "ca-app-pub-1857451981250394/1217848443",
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
    myInterstitial.load();
  }

  void _showInterstitial() {
    myInterstitial.show(
      anchorOffset: 0.0,
      // Banner Position
      anchorType: AnchorType.bottom,
    );
  }

  void _showAds(Function pathFunc) async {
    _showInterstitial();
    pathFunc();
  }

  void showSimpleCustomDialog(BuildContext context, TestResults args) {
    Dialog simpleDialog = Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 350.0,
            width: 300.0,
            margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.yellow[700], Color(0xffF9CF72)],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    AppLocalizations.of(context).translate('new-level-modal_title'), //'Congratulations!',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Color(0xff3D3D74),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    AppLocalizations.of(context).translate('new-level-modal_description'), // 'New level achieved',
                    style: TextStyle(fontSize: 16.0, color: Color(0xff3D3D74)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: CircleAvatar(
                    radius: 80.0,
                    child: new Image.asset('assets/images/animals/' + args.level.icon, width: 145.0, height: 145.0),
                    backgroundColor: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    AppLocalizations.of(context).translate('new-level-screen_level') + ' ' + args.level.name,
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Color(0xff3D3D74),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0.0,
            top: 0.0,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 35.0,
                height: 35.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x22000000),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Icon(
                  Icons.close,
                  color: Color(0xff3D3D74),
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => simpleDialog);
  }

  @override
  Widget build(BuildContext context) {
    final TestResults args = ModalRoute.of(context).settings.arguments;
    int correctNumber = 0;
    int totalNumber = args.testData.length;
    double percentage = 0;
    int xp = args.xp;

    for (Problem pr in args.testData) {
      if (pr.correctAnswer == pr.givenAnswer) {
        correctNumber++;
      }
      percentage = correctNumber / totalNumber * 1.0;
    }
    final mediaQuerySize = MediaQuery.of(context);
    final screenWidth = mediaQuerySize.size.width;
    final screenHeight = mediaQuerySize.size.height;
    final hc = screenHeight / 683;
    final wc = screenWidth / 411;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0 * hc), // here the desired height
        child: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Color(0xff3D3D74),
              size: 30 * wc,
            ),
            onPressed: () => _showAds(Navigator.of(context).pop),
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 20,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/test-results-background.png'), fit: BoxFit.fitWidth),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Center(
                        child: Container(
                          margin: EdgeInsets.all(0.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff599BF0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(22.0 * wc),
                            child: new CircularPercentIndicator(
                              radius: 140.0 * hc,
                              lineWidth: 13.0,
                              animation: true,
                              percent: correctNumber / totalNumber,
                              center: new Text(
                                '$correctNumber ' + AppLocalizations.of(context).translate('out-of') + ' $totalNumber',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20.0 * wc, color: Colors.white),
                              ),
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: Color(0xffE3F0FF),
                              backgroundColor: Color(0xff4785EB),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 139.0 * hc),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0 * wc),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff004080).withOpacity(0.1),
                                spreadRadius: 3,
                                blurRadius: 2,
                                offset: Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0 * wc),
                            child: Text(
                              '+ $xp XP',
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Color(0xffE24C4B),
                                fontSize: 16.0 * wc,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 45.0 * hc),
                    child: Image(
                      image: starsRating(percentage),
                      width: 25.0 * wc,
                      height: 40.0 * hc,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ...resultText(percentage, context, wc, hc, screenHeight),
          (screenHeight > 600)
              ? Spacer(
                  flex: 1,
                )
              : Container(),
          Padding(
            padding: EdgeInsets.only(top: 10.0 * hc, bottom: 3.0 * hc, right: 15.0 * wc, left: 15.0 * wc),
            child: StyledButton(
              wc: wc,
              onPressed: () => Navigator.of(context).pushNamed(AnswersListScreen.routeName, arguments: args.testData),
              text: AppLocalizations.of(context).translate('test-results-screen_show-answers'),
              light: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 3.0 * hc, bottom: 25.0 * hc, right: 15.0 * wc, left: 15.0 * wc),
            child: totalNumber > correctNumber
                ? StyledButton(
                    wc: wc,
                    onPressed: () => {
                      if (args.exam)
                        {
                          _showAds(() => Navigator.of(context)
                              .pushReplacementNamed(TestExamScreen.routeName, arguments: args.testGroup)),
                        }
                      else
                        {
                          _showAds(() => Navigator.of(context)
                              .pushReplacementNamed(TestScreen.routeName, arguments: args.testGroup)),
                        }
                    },
                    text: AppLocalizations.of(context).translate('test-results-screen_try-again'),
                  )
                : StyledButton(
                    wc: wc,
                    onPressed: () {
                      _showAds(Navigator.of(context).pop);
                    },
                    text: AppLocalizations.of(context).translate('test-results-screen_done'),
                  ),
          ),
        ],
      ),
    );
  }
}

AssetImage starsRating(double percent) {
  if (percent > 0.99) {
    return AssetImage('assets/images/3-stars.png');
  } else if (percent > 0.6) {
    return AssetImage('assets/images/2-stars.png');
  } else if (percent > 0.2) {
    return AssetImage('assets/images/1-stars.png');
  } else {
    return AssetImage('assets/images/0-stars.png');
  }
}

List<Widget> resultText(double percent, BuildContext context, double wc, double hc, double screenHeight) {
  String title;
  String desc;

  dynamic getRandomElement(String s) {
    List<dynamic> arr = s.split('|');
    var i = new Random().nextInt(arr.length);
    return arr[i];
  }

  if (percent > 0.99) {
    String titleVars = AppLocalizations.of(context).translate('test-results-screen_title-great');
    title = getRandomElement(titleVars);
    String descVars = AppLocalizations.of(context).translate('test-results-screen_desc-great');
    desc = getRandomElement(descVars);
  } else if (percent > 0.6) {
    String titleVars = AppLocalizations.of(context).translate('test-results-screen_title-good');
    title = getRandomElement(titleVars);
    String descVars = AppLocalizations.of(context).translate('test-results-screen_desc-good');
    desc = getRandomElement(descVars);
  } else {
    String titleVars = AppLocalizations.of(context).translate('test-results-screen_title-bad');
    title = getRandomElement(titleVars);
    String descVars = AppLocalizations.of(context).translate('test-results-screen_desc-bad');
    desc = getRandomElement(descVars);
  }

  return [
    Text(
      title,
      style: TextStyle(
        fontSize: 18.0 * wc,
        fontWeight: FontWeight.w700,
        color: Color(0xff3D3D74),
        letterSpacing: 0.3,
      ),
      textAlign: TextAlign.center,
    ),
    (screenHeight > 600)
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.0 * hc),
            child: Text(
              desc,
              style: TextStyle(
                fontSize: 17.0 * wc,
                height: 1.7,
                fontWeight: FontWeight.w400,
                color: Color(0xff999999),
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
            ),
          )
        : Container(),
  ];
}
