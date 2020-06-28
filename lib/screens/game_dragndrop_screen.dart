import 'package:flutter/material.dart';
import 'package:multitables/funcs/localisations.dart';
import 'package:multitables/funcs/drag_n_drop_options_generator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class DragNDropGame extends StatefulWidget {
  static const routeName = '/game-drag-n-drop';

  @override
  _DragNDropGameState createState() => _DragNDropGameState();
}

class _DragNDropGameState extends State<DragNDropGame> {
  Map<int, bool> score = {};
  int pageNumber;
  var questionsList = [];
  var choices = [];

  void dragDrop(int s) {
    setState(() {
      score[s] = true;
    });

    if (score.length >= 4) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          score = {};
          pageNumber++;
          choices = questionsList[pageNumber - 1];
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    pageNumber = 1;
    questionsList = generateVariants(1, 2);
    choices = questionsList[pageNumber - 1];
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
        preferredSize: Size.fromHeight(50.0 * hc),
        child: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          leading: InkWell(
            child: Icon(
              Icons.arrow_back,
              color: Color(0xff3D3D74),
              size: 30 * wc,
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          title: Text(
            "AppLocalizations.of(context).translate('')",
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
                '$pageNumber  ' + AppLocalizations.of(context).translate('out-of') + '  10',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xff888992),
                  fontSize: 19.0 * wc,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDragTarget(choices[0], 0),
                    _buildDragTarget(choices[1], 1),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDragTarget(choices[2], 2),
                    _buildDragTarget(choices[3], 3),
                  ],
                ),
                SizedBox(
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: (score[0] == true)
                          ? AnswerSquare(answerText: choices[0][0], light: true)
                          : Draggable<String>(
                              data: choices[0][1],
                              child: AnswerSquare(answerText: choices[0][0]),
                              feedback: AnswerSquare(answerText: choices[0][0]),
                              childWhenDragging: AnswerSquare(answerText: choices[0][0]),
                            ),
                    ),
                    Expanded(
                      child: (score[1] == true)
                          ? AnswerSquare(answerText: choices[1][0], light: true)
                          : Draggable<String>(
                              data: choices[1][1],
                              child: AnswerSquare(answerText: choices[1][0]),
                              feedback: AnswerSquare(answerText: choices[1][0]),
                              childWhenDragging: AnswerSquare(answerText: choices[1][0], light: true),
                            ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: (score[2] == true)
                          ? AnswerSquare(answerText: choices[2][0], light: true)
                          : Draggable<String>(
                              data: choices[2][1],
                              child: AnswerSquare(answerText: choices[2][0]),
                              feedback: AnswerSquare(answerText: choices[2][0]),
                              childWhenDragging: AnswerSquare(answerText: choices[2][0], light: true),
                            ),
                    ),
                    Expanded(
                      child: (score[3] == true)
                          ? AnswerSquare(answerText: choices[3][0], light: true)
                          : Draggable<String>(
                              data: choices[3][1],
                              child: AnswerSquare(answerText: choices[3][0]),
                              feedback: AnswerSquare(answerText: choices[3][0]),
                              childWhenDragging: AnswerSquare(answerText: choices[3][0], light: true),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDragTarget(q, ind) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String> incoming, List rejected) {
        if (score[ind] == true) {
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  q[1],
                  style: TextStyle(
                    color: Color(0xff777777),
                    fontSize: 39,
                  ),
                ),
                Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 30,
                ),
              ],
            ),
            alignment: Alignment.center,
            height: 80,
            width: 180,
          );
        } else {
          return Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            alignment: Alignment.center,
            height: 80,
            width: 180,
            padding: EdgeInsets.all(10),
            child: Text(
              q[1],
              style: TextStyle(
                color: Color(0xff383838),
                fontSize: 39,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Color(0xff9c9c9c)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffdbdcdd),
                ),
                BoxShadow(
                  color: Color(0xfffafafa),
                  spreadRadius: -5.0,
                  blurRadius: 5.0,
                ),
              ],
            ),
          );
        }
      },
      onWillAccept: (data) => data == q[1],
      onAccept: (data) {
        dragDrop(ind);
      },
      onLeave: (data) {},
    );
  }
}

class AnswerSquare extends StatelessWidget {
  AnswerSquare({Key key, this.answerText, this.visible = true, this.light = false}) : super(key: key);

  final String answerText;
  final bool visible;
  final bool light;

  @override
  Widget build(BuildContext context) {
    return visible
        ? Opacity(
            opacity: light ? 0.3 : 1.0,
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                alignment: Alignment.center,
                height: 80,
                width: 180,
                padding: EdgeInsets.all(10),
                child: Text(
                  answerText,
                  style: TextStyle(color: Colors.black, fontSize: 50),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                ),
              ),
            ),
          )
        : Container(
            height: 80,
            width: 180,
          );
  }
}
