import 'package:flutter/material.dart';
import 'package:multitables/funcs/localisations.dart';
import 'package:multitables/models/problem.dart';
import 'package:multitables/widgets/striked_text.dart';

class AnswersListScreen extends StatelessWidget {
  static const routeName = '/test/answers';

  @override
  Widget build(BuildContext context) {
    final List<Problem> args = ModalRoute.of(context).settings.arguments;
    List<Widget> answersList = [];

    for (Problem pr in args) {
      answersList.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 7.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: (pr.correctAnswer != pr.givenAnswer)
                    ? Icon(Icons.close, color: Colors.red)
                    : Icon(Icons.done, color: Colors.green),
              ),
              ...(() {
                if (pr.type == 1) {
                  return [
                    Text(
                      '${pr.x} \u00D7 ${pr.y} = ',
                      style: TextStyle(fontSize: 35),
                    ),
                    (pr.correctAnswer != pr.givenAnswer)
                        ? StrikeThroughWidget(
                            child: Text(
                              '${pr.givenAnswer}',
                              style: TextStyle(fontSize: 35),
                            ),
                          )
                        : Container(),
                    Text(
                      ' ${pr.correctAnswer}',
                      style: TextStyle(fontSize: 35, color: Colors.green),
                    ),
                  ];
                } else {
                  return [
                    Text(
                      '${pr.x} \u00D7',
                      style: TextStyle(fontSize: 35),
                    ),
                    (pr.correctAnswer != pr.givenAnswer)
                        ? StrikeThroughWidget(
                            child: Text(
                              '${pr.givenAnswer}',
                              style: TextStyle(fontSize: 35),
                            ),
                          )
                        : Container(),
                    Text(
                      ' ${pr.correctAnswer}',
                      style: TextStyle(fontSize: 35, color: Colors.green),
                    ),
                    Text(
                      ' = ${pr.y}',
                      style: TextStyle(fontSize: 35),
                    ),
                  ];
                }
              }()),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff3D3D74),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'Your Answers',
          style: TextStyle(color: Color(0xff3D3D74)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ListBody(
                children: <Widget>[
                  ...answersList,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
