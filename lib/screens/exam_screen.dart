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
              description:
                  'Select one of the multiplication table you wish to practice.',
              image: 'assets/images/elearning_exam.png',
              bgColor: '#FFEABA',
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ...PRACTICE_TEST_GROUPS
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
