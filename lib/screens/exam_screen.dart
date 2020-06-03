import 'package:flutter/material.dart';
import '../widgets/list_item.dart';
import '../widgets/header.dart';
import 'package:multitables/datastore/test_groups.dart';

class ExamScreen extends StatelessWidget {
  static const routeName = '/exam';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Header(
              title: 'Exam',
              description: 'Check you knowledge and master your skills.',
              image: 'assets/images/elearning_exam.png',
              bgColor: '#FFEABA',
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ...EXAM_TEST_GROUPS
                      .map(
                        (group) => new ListItem(
                          testGroup: group,
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
