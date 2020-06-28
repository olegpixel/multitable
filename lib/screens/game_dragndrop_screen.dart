import 'package:flutter/material.dart';
import 'package:multitables/funcs/localisations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class DragNDropGame extends StatefulWidget {
  static const routeName = '/game-drag-n-drop';

  @override
  _DragNDropGameState createState() => _DragNDropGameState();
}

class _DragNDropGameState extends State<DragNDropGame> {
  Map<String, bool> score = {};

  void dragDrop(String s) {
    setState(() {
      print(score);
      score[s] = true;
      print(score[s]);
      print(score);
    });
  }

  final choices = [
    ['10', '2 \u00D7 5'],
    ['25', '5 \u00D7 5'],
    ['144', '12 \u00D7 12'],
    ['7', '7 \u00D7 1'],
  ];

  int seed = 0;

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
                '1  ' + AppLocalizations.of(context).translate('out-of') + '  10',
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
                    _buildDragTarget(choices[0]),
                    _buildDragTarget(choices[1]),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDragTarget(choices[2]),
                    _buildDragTarget(choices[3]),
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
                      child: Draggable<String>(
                        data: choices[0][1],
                        child: AnswerSquare(answerText: choices[0][0], opacity: score[choices[0][0]] == true),
                        feedback: AnswerSquare(answerText: choices[0][0]),
                        childWhenDragging: AnswerSquare(answerText: choices[0][0]),
                      ),
                    ),
                    Expanded(
                      child: Draggable<String>(
                        data: choices[1][1],
                        child: AnswerSquare(answerText: choices[1][0], opacity: score[choices[1][0]] == true),
                        feedback: AnswerSquare(answerText: choices[1][0]),
                        childWhenDragging: AnswerSquare(answerText: choices[1][0]),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Draggable<String>(
                        data: choices[2][1],
                        child: AnswerSquare(answerText: choices[2][0], opacity: score[choices[2][0]] == true),
                        feedback: AnswerSquare(answerText: choices[2][0]),
                        childWhenDragging: AnswerSquare(answerText: choices[2][0]),
                      ),
                    ),
                    Expanded(
                      child: Draggable<String>(
                        data: choices[3][1],
                        child: AnswerSquare(answerText: choices[3][0], opacity: score[choices[3][0]] == true),
                        feedback: AnswerSquare(answerText: choices[3][0]),
                        childWhenDragging: AnswerSquare(answerText: choices[3][0]),
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

  Widget _buildDragTarget(q) {
    print(q);
    return DragTarget<String>(
      builder: (BuildContext context, List<String> incoming, List rejected) {
        if (score[q[0]] == true) {
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 30,
                ),
                Text(
                  q[0],
                  style: TextStyle(
                    color: Color(0xff777777),
                    fontSize: 39,
                  ),
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
        print(q[0]);
        dragDrop(q[0]);
      },
      onLeave: (data) {},
    );
  }
}

class AnswerSquare extends StatelessWidget {
  AnswerSquare({Key key, this.answerText, this.opacity = true}) : super(key: key);

  final String answerText;
  final bool opacity;

  @override
  Widget build(BuildContext context) {
    return Material(
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
    );
  }
}
