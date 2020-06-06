import 'package:flutter/material.dart';

class Problem {
  int x;
  int y;
  int correctAnswer;
  List<int> answers;
  int givenAnswer;
  String questionString;
  int type;

  Problem({
    @required this.x,
    @required this.y,
    @required this.correctAnswer,
    this.answers,
    this.givenAnswer,
    @required this.questionString,
    this.type,
  });
}
