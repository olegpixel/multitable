import 'package:flutter/material.dart';
import 'package:multitables/funcs/funcs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multitables/models/test_group.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multitables/datastore/constants.dart';
import 'package:multitables/models/problem.dart';
import 'package:multitables/funcs/question_generator.dart';
import 'dart:io';
import 'dart:async';

class TestScreen extends StatefulWidget {
  static const routeName = '/test';
  final TestGroup testGroup;

  TestScreen(this.testGroup);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  Box _box;
  List<Problem> _questionsList;
  int iterator;
  TestGroup testGroup;
  List<Color> buttonColors;
  bool clickable;

  @override
  void initState() {
    _box = Hive.box(hiveProgressBox);
    super.initState();
    testGroup = widget.testGroup;
    _questionsList = generateClosedTest(
        widget.testGroup.problemsClass, widget.testGroup.itemsCount);
    iterator = 0;
    buttonColors = [Colors.white, Colors.white, Colors.white, Colors.white];
    clickable = true;
  }

  void answerClick(int index) {
    if (clickable) {
      clickable = false;
      setState(() {
        int givenAnswer = _questionsList[iterator].answers[index];
        _questionsList[iterator].givenAnswer = givenAnswer;
        if (givenAnswer == _questionsList[iterator].correctAnswer) {
          buttonColors[index] = Colors.green;
        } else {
          buttonColors[index] = Colors.red;
        }
        if (iterator < _questionsList.length - 1) {
          iterator++;
          buttonColors[index] = Colors.white;
          Future.delayed(Duration(seconds: 1), () {
            clickable = true;
          });

//          sleep(const Duration(seconds: 1));
////          new Future.delayed(const Duration(seconds: 1), () {
//          iterator++;
//          buttonColors[index] = Colors.white;
//          clickable = true;
//          });
        }
      });
//      clicked = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: hexToColor('#3D3D74')),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          testGroup.title,
          style: TextStyle(color: hexToColor('#3D3D74')),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Text(
              '${iterator + 1}  of  10',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: hexToColor('#888992'),
                  fontSize: 19.0,
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              _questionsList[iterator].questionString,
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: hexToColor('#202027'),
                  fontSize: 67.0,
                ),
              ),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 20.0, right: 7.0, bottom: 6.0),
                          child: InkWell(
                            onTap: () => answerClick(0),
                            borderRadius: BorderRadius.circular(15.0),
                            child: AnswerSquare(
                                _questionsList[iterator].answers[0].toString(),
                                buttonColors[0]),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 7.0, top: 20.0, right: 20.0, bottom: 6.0),
                          child: InkWell(
                            onTap: () => answerClick(1),
                            borderRadius: BorderRadius.circular(15.0),
                            child: AnswerSquare(
                                _questionsList[iterator].answers[1].toString(),
                                buttonColors[1]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 20.0, right: 7.0, bottom: 6.0),
                          child: InkWell(
                            onTap: () => answerClick(2),
                            borderRadius: BorderRadius.circular(15.0),
                            child: AnswerSquare(
                                _questionsList[iterator].answers[2].toString(),
                                buttonColors[2]),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 7.0, top: 20.0, right: 20.0, bottom: 6.0),
                          child: InkWell(
                            onTap: () => answerClick(3),
                            borderRadius: BorderRadius.circular(15.0),
                            child: AnswerSquare(
                                _questionsList[iterator].answers[3].toString(),
                                buttonColors[3]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}

class AnswerSquare extends StatelessWidget {
  final String answerText;
  final Color bgColor;

  AnswerSquare(this.answerText, this.bgColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: bgColor,
        boxShadow: [
          BoxShadow(
            color: hexToColor("#004080").withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 8,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Text(
          answerText,
          overflow: TextOverflow.clip,
          style: GoogleFonts.titilliumWeb(
            textStyle: TextStyle(
              fontWeight: FontWeight.w700,
              color: hexToColor('#3D3D74'),
              fontSize: 53.0,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
