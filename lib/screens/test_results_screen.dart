import 'package:flutter/material.dart';
import 'package:multitables/funcs/funcs.dart';
import 'package:multitables/models/test_results.dart';
import 'package:multitables/models/problem.dart';
import 'package:multitables/widgets/styled_button.dart';
import 'package:multitables/screens/test_screen.dart';
import 'package:multitables/screens/test_exam_screen.dart';
import 'package:multitables/screens/answers_list_screen.dart';
import 'package:multitables/datastore/lang.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TestResultsScreen extends StatelessWidget {
  static const routeName = '/test-results';

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

    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.close, color: hexToColor('#3D3D74')),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
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
                    image: AssetImage('assets/images/test-results-background.png'), fit: BoxFit.fitHeight),
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
                            color: hexToColor('#599BF0'),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(22.0),
                            child: new CircularPercentIndicator(
                              radius: 140.0,
                              lineWidth: 13.0,
                              animation: true,
                              percent: correctNumber / totalNumber,
                              center: new Text(
                                '$correctNumber of $totalNumber',
                                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
                              ),
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: hexToColor('#E3F0FF'),
                              backgroundColor: hexToColor('#4785EB'),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 139.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: hexToColor("#004080").withOpacity(0.1),
                                spreadRadius: 3,
                                blurRadius: 2,
                                offset: Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '+ $xp XP',
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Color(0xffE24C4B),
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 45.0),
                    child: Image(
                      image: starsRating(percentage),
                      width: 25.0,
                      height: 40.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ...resultText(percentage),
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 3.0, right: 15.0, left: 15.0),
            child: StyledButton(
              onPressed: () => Navigator.of(context).pushNamed(AnswersListScreen.routeName, arguments: args.testData),
              text: 'Show answers',
              light: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0, bottom: 25.0, right: 15.0, left: 15.0),
            child: totalNumber > correctNumber
                ? StyledButton(
                    onPressed: () => {
                      if (args.exam)
                        {
                          Navigator.of(context)
                              .pushReplacementNamed(TestExamScreen.routeName, arguments: args.testGroup),
                        }
                      else
                        {
                          Navigator.of(context).pushReplacementNamed(TestScreen.routeName, arguments: args.testGroup),
                        }
                    },
                    text: 'Try again',
                  )
                : StyledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    text: 'Done',
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

List<Widget> resultText(double percent) {
  String title;
  String desc;

  if (percent > 0.99) {
    title = getRandomElement(LANG['ENGLISH']['test-results-great']);
    desc = '';
  } else if (percent > 0.6) {
    title = getRandomElement(LANG['ENGLISH']['test-results-good']);
    desc = '';
  } else {
    title = getRandomElement(LANG['ENGLISH']['test-results-bad']);
    desc = '';
  }

  return [
    Text(
      title,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: hexToColor('#3D3D74'),
        letterSpacing: 0.3,
      ),
      textAlign: TextAlign.center,
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Text(
        'Study more next time and get all the answers correct!',
        style: TextStyle(
          fontSize: 17.0,
          height: 1.7,
          fontWeight: FontWeight.w400,
          color: hexToColor('#999999'),
          letterSpacing: 0.3,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  ];
}
