import 'package:flutter/material.dart';
import 'package:multitables/widgets/list_item.dart';
import 'package:multitables/widgets/header.dart';
import 'package:multitables/datastore/test_groups.dart';
import 'package:multitables/funcs/localisations.dart';

class PracticeScreen extends StatefulWidget {
  static const routeName = '/practice';

  @override
  _PracticeScreenState createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffFFEABA),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Header(
                  title: AppLocalizations.of(context).translate('practice-screen_title'),
                  description: AppLocalizations.of(context).translate('practice-screen_description'),
                  image: 'assets/images/responsive.png',
                  bgColor: 0xffFFEABA,
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
        ),
      ),
    );
  }
}
