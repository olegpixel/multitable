import 'package:flutter/material.dart';
import '../funcs/funcs.dart';

class ExamScreen extends StatelessWidget {
  static const routeName = '/exam';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Exam'),
        ),
      ),
    );
  }
}