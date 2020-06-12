import 'package:flutter/material.dart';
import 'package:multitables/widgets/list_item.dart';
import 'package:multitables/widgets/header.dart';
import 'package:multitables/datastore/test_groups.dart';
import 'package:multitables/funcs/localisations.dart';

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
              title: AppLocalizations.of(context).translate('exam-screen_title'),
              description: AppLocalizations.of(context).translate('exam-screen_description'),
              image: 'assets/images/elearning_exam.png',
              bgColor: 0xffFFEABA,
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
