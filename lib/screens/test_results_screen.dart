import 'package:flutter/material.dart';
import 'package:multitables/funcs/funcs.dart';
import 'package:multitables/models/test_results.dart';
import 'package:multitables/models/problem.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TestResultsScreen extends StatelessWidget {
  static const routeName = '/test-results';

  @override
  Widget build(BuildContext context) {
    final TestResults args = ModalRoute.of(context).settings.arguments;
    int correctNumber = 0;
    int totalNumber = args.testData.length;

    for (Problem pr in args.testData) {
      if (pr.correctAnswer == pr.givenAnswer) {
        correctNumber++;
      }
    }

    void closeHandler() {
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.close, color: hexToColor('#3D3D74')),
          onPressed: closeHandler,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 10.0,
                  percent: correctNumber / totalNumber,
                  header: new Text("Icon header"),
                  center: new Icon(
                    Icons.person_pin,
                    size: 50.0,
                    color: Colors.blue,
                  ),
                  backgroundColor: Colors.grey,
                  progressColor: Colors.blue,
                ),
                Text('$correctNumber of $totalNumber'),
                Text('Don’t Give Up!'),
                Text('Study more next time and get all the answers correct!'),
              ],
            ),
          ),
          Spacer(
            flex: 1,
          ),
          RaisedButton(
            onPressed: () {},
            child:
                const Text('Show answer list', style: TextStyle(fontSize: 20)),
          ),
          RaisedButton(
            onPressed: closeHandler,
            child: const Text('Try again', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
