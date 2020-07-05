import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multitables/models/test_group.dart';
import 'package:multitables/models/test_results.dart';
import 'package:multitables/screens/test_results_screen.dart';
import 'package:multitables/datastore/progress_dao.dart';
import 'package:multitables/models/problem.dart';
import 'package:multitables/funcs/question_generator.dart';
import 'package:multitables/widgets/styled_button.dart';
import 'package:multitables/models/user_level.dart';
import 'package:multitables/funcs/localisations.dart';
import 'package:multitables/funcs/firebase_analytics.dart';

class TestExamScreen extends StatefulWidget {
  static const routeName = '/testexam';
  final TestGroup testGroup;

  TestExamScreen(this.testGroup);

  @override
  _TestExamScreenState createState() => _TestExamScreenState();
}

class _TestExamScreenState extends State<TestExamScreen> {
  List<Problem> _questionsList;
  int iterator;
  TestGroup testGroup;
  int correctAnswersCount = 0;
  int totalQNumber = 10;
  String givenAnswer;
  Widget iconToShow;
  bool answerClicked;

  @override
  void initState() {
    super.initState();
    testGroup = widget.testGroup;
    _questionsList = generateOpenTest(testGroup.problemsClass, testGroup.itemsCount);
    iterator = 0;
    totalQNumber = _questionsList.length;
    givenAnswer = '';
    iconToShow = Container();
    answerClicked = false;
  }

  void _numberIconTap(String n) {
    setState(() {
      if (givenAnswer.length < 4 && !answerClicked) {
        givenAnswer += n;
      }
    });
  }

  void _backSpaceTap() {
    setState(() {
      if (givenAnswer.length > 0 && !answerClicked) {
        givenAnswer = givenAnswer.substring(0, givenAnswer.length - 1);
      }
    });
  }

  void _checkAnswer(BuildContext ctx) {
    setState(() {
      if (!answerClicked && givenAnswer != '') {
        answerClicked = true;
        _questionsList[iterator].givenAnswer = int.parse(givenAnswer);
        if (givenAnswer == _questionsList[iterator].correctAnswer.toString()) {
          iconToShow = Icon(
            Icons.done,
            color: Colors.green,
            size: 40,
          );
          correctAnswersCount++;
        } else {
          iconToShow = Icon(
            Icons.close,
            color: Colors.red,
            size: 40,
          );
        }

        if (iterator < _questionsList.length - 1) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            setState(() {
              iconToShow = Container();
              givenAnswer = '';
              iterator++;
              answerClicked = false;
            });
          });
        } else {
          Future.delayed(const Duration(milliseconds: 1000), () {
            // update score of test group
            double previousScore = getGroupProgress(widget.testGroup.id);
            if (previousScore < correctAnswersCount / widget.testGroup.itemsCount) {
              updateGroupProgress(widget.testGroup.id, correctAnswersCount / widget.testGroup.itemsCount);
            }

            int xpToAdd = (correctAnswersCount * widget.testGroup.coefficient).floor().toInt();
            if (widget.testGroup.itemsCount - correctAnswersCount == 0) {
              xpToAdd = (xpToAdd * 1.1).floor().toInt();
            }

            UserLevel levelBeforeUpdate = getCurrentUserLevel();
            // increment total and today stats counters
            updateCountersAndXP(correctAnswersCount, widget.testGroup.itemsCount - correctAnswersCount, xpToAdd);
            UserLevel levelAfterUpdate = getCurrentUserLevel();
            bool nextLevelModal = false;

            if (levelBeforeUpdate.id != levelAfterUpdate.id) {
              nextLevelModal = true;
              analytics.logEvent(name: 'level_achieved', parameters: {'level': levelAfterUpdate.id});
            }

            TestResults tr = TestResults(
              testGroup: widget.testGroup,
              testData: _questionsList,
              xp: xpToAdd,
              exam: true,
              nextLevelModal: nextLevelModal,
              level: levelAfterUpdate,
            );
            Navigator.of(ctx).pushReplacementNamed(TestResultsScreen.routeName, arguments: tr);
          });
        }
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
    final bool bs = (screenWidth > 400);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0 * hc), // here the desired height
        child: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          leading: InkWell(
//            iconSize: 30,
            child: Icon(
              Icons.arrow_back,
              color: Color(0xff3D3D74),
              size: 30 * wc,
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          title: Text(
            AppLocalizations.of(context).translate(widget.testGroup.id),
            style: TextStyle(
              color: Color(0xff3D3D74),
              fontSize: 20 * wc,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 4.0 * hc, bottom: 14.0 * hc),
            child: Center(
              child: Text(
                '${iterator + 1}  ' + AppLocalizations.of(context).translate('out-of') + ' $totalQNumber',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xff888992),
                  fontSize: 19.0 * wc,
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
                  color: Color(0xff202027),
                  fontSize: bs ? 74 : (57.0 * wc),
                ),
              ),
            ),
          ),
          Stack(
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 15.0 * hc, bottom: 15.0 * hc),
                  width: 150 * wc,
                  child: Center(
                      child: Text(
                    givenAnswer,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xff202027),
                      fontSize: bs ? 55 : (50.0 * wc),
                    ),
                  )),
                  decoration: BoxDecoration(
                    color: const Color(0xffFCFCFE),
                    border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 22.0 * hc, bottom: 15.0 * hc, left: 180.0 * wc),
                  child: iconToShow,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0 * hc, bottom: 15.0 * hc, right: 15.0 * wc, left: 15.0 * wc),
            child: StyledButton(
              onPressed: () => _checkAnswer(context),
              text: AppLocalizations.of(context).translate('test-exam-screen_next-button'),
              light: false,
              wc: wc,
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffCCCED3), //Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffc3c3c3).withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      NumberIcon(1, _numberIconTap, wc, hc),
                      NumberIcon(2, _numberIconTap, wc, hc),
                      NumberIcon(3, _numberIconTap, wc, hc),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      NumberIcon(4, _numberIconTap, wc, hc),
                      NumberIcon(5, _numberIconTap, wc, hc),
                      NumberIcon(6, _numberIconTap, wc, hc),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      NumberIcon(7, _numberIconTap, wc, hc),
                      NumberIcon(8, _numberIconTap, wc, hc),
                      NumberIcon(9, _numberIconTap, wc, hc),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 100 * wc,
                        height: 54 * hc,
                      ),
                      NumberIcon(0, _numberIconTap, wc, hc),
                      BackspaceButton(_backSpaceTap, wc, hc),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BackspaceButton extends StatelessWidget {
  final Function tapHandler;
  final double wc;
  final double hc;

  BackspaceButton(this.tapHandler, this.wc, this.hc);

  @override
  Widget build(BuildContext context) {
    return InkWell(
//      highlightColor: Colors.transparent,
//      splashColor: Colors.transparent,
//      padding: EdgeInsets.all(0),
      onTap: () => tapHandler(),
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(top: 4.0 * hc, bottom: 4.0 * hc),
          child: Center(
            child: Icon(Icons.backspace, color: Colors.black),
          ),
        ),
        width: 100 * wc,
        height: 54 * hc,
      ),
    );
  }
}

class NumberIcon extends StatelessWidget {
  final int number;
  final Function tapHandler;
  final double wc;
  final double hc;

  NumberIcon(this.number, this.tapHandler, this.wc, this.hc);

  @override
  Widget build(BuildContext context) {
    return InkWell(
//      highlightColor: Colors.transparent,
//      splashColor: Colors.transparent,
//      padding: EdgeInsets.all(0),
      onTap: () => tapHandler(number.toString()),
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(top: 4.0 * hc, bottom: 4.0 * hc),
          child: Center(
            child: Text(
              number.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontSize: 30.0 * wc,
              ),
            ),
          ),
        ),
        width: 100 * wc,
        height: 54 * hc,
        decoration: BoxDecoration(
          color: const Color(0xffFCFCFE),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff999999).withOpacity(0.9),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}
