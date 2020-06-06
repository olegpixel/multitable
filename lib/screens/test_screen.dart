import 'package:flutter/material.dart';
import 'package:multitables/funcs/funcs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multitables/models/test_group.dart';
import 'package:multitables/models/test_results.dart';
import 'package:multitables/screens/test_results_screen.dart';
import 'package:multitables/datastore/progress_dao.dart';
import 'package:multitables/models/problem.dart';
import 'package:multitables/funcs/question_generator.dart';
import 'package:multitables/models/user_level.dart';
import 'dart:async';

class TestScreen extends StatefulWidget {
  static const routeName = '/test';
  final TestGroup testGroup;

  TestScreen(this.testGroup);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<Problem> _questionsList;
  int iterator;
  TestGroup testGroup;
  List<Color> buttonColors;
  bool _isButtonTapped = false;
  int correctAnswersCount = 0;
  int totalQNumber = 10;

  @override
  void initState() {
    super.initState();
    testGroup = widget.testGroup;
    _questionsList = generateClosedTest(
        widget.testGroup.problemsClass, widget.testGroup.itemsCount);
    iterator = 0;
    buttonColors = [Colors.white, Colors.white, Colors.white, Colors.white];
    _isButtonTapped = false;
    totalQNumber = _questionsList.length;
  }

  void answerClick(BuildContext ctx, int index) {
    setState(() {
      if (!_isButtonTapped) {
        int givenAnswer = _questionsList[iterator].answers[index];
        _questionsList[iterator].givenAnswer = givenAnswer;
        if (givenAnswer == _questionsList[iterator].correctAnswer) {
          buttonColors[index] = Color(0xFF0EAD69);
          correctAnswersCount++;
        } else {
          buttonColors[index] = Color(0xFFE24C4B);
        }

        _isButtonTapped = true;
        if (iterator < _questionsList.length - 1) {
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
              buttonColors[index] = Colors.white;
              _isButtonTapped = false;
              iterator++;
            });
          });
        } else {
          Future.delayed(const Duration(milliseconds: 500), () {
            // update score of test group
            double previousScore = getGroupProgress(widget.testGroup.id);
            if (previousScore <
                correctAnswersCount / widget.testGroup.itemsCount) {
              updateGroupProgress(widget.testGroup.id,
                  correctAnswersCount / widget.testGroup.itemsCount);
            }

            int xpToAdd = (correctAnswersCount * widget.testGroup.coefficient)
                .floor()
                .toInt();
            if (widget.testGroup.itemsCount - correctAnswersCount == 0) {
              xpToAdd = (xpToAdd * 1.1).floor().toInt();
            }

            UserLevel levelBeforeUpdate = getCurrentUserLevel();
            // increment total and today stats counters
            updateCountersAndXP(correctAnswersCount,
                widget.testGroup.itemsCount - correctAnswersCount, xpToAdd);
            UserLevel levelAfterUpdate = getCurrentUserLevel();
            bool nextLevelModal = false;

            if (levelBeforeUpdate.id != levelAfterUpdate.id) {
              nextLevelModal = true;
            }

            TestResults tr = TestResults(
              testGroup: widget.testGroup,
              testData: _questionsList,
              xp: xpToAdd,
              exam: false,
              nextLevelModal: nextLevelModal,
              level: levelBeforeUpdate,
            );
            Navigator.of(ctx).pushReplacementNamed(TestResultsScreen.routeName,
                arguments: tr);
          });
        }
      }
    });
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
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 14.0),
            child: Center(
              child: Text(
                '${iterator + 1}  of  $totalQNumber',
                style: TextStyle(
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
                              left: 30.0, top: 20.0, right: 15.0, bottom: 6.0),
                          child: InkWell(
                            onTap: () => answerClick(context, 0),
                            borderRadius: BorderRadius.circular(30.0),
                            child: AnswerSquare(
                                _questionsList[iterator].answers[0].toString(),
                                buttonColors[0]),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, top: 20.0, right: 30.0, bottom: 6.0),
                          child: InkWell(
                            onTap: () => answerClick(context, 1),
                            borderRadius: BorderRadius.circular(30.0),
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
                              left: 30.0, top: 20.0, right: 15.0, bottom: 6.0),
                          child: InkWell(
                            onTap: () => answerClick(context, 2),
                            borderRadius: BorderRadius.circular(30.0),
                            child: AnswerSquare(
                                _questionsList[iterator].answers[2].toString(),
                                buttonColors[2]),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, top: 20.0, right: 30.0, bottom: 6.0),
                          child: InkWell(
                            onTap: () => answerClick(context, 3),
                            borderRadius: BorderRadius.circular(30.0),
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
            blurRadius: 2,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Text(
          answerText,
          overflow: TextOverflow.clip,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: hexToColor('#3D3D74'),
            fontSize: 63.0,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
