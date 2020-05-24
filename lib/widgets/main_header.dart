import 'package:flutter/material.dart';
import 'package:multitables/funcs/funcs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multitables/datastore/constants.dart';
import 'package:multitables/datastore/test_groups.dart';

class MainHeader extends StatefulWidget {
  @override
  _MainHeaderState createState() => _MainHeaderState();
}

class _MainHeaderState extends State<MainHeader> {
  Box _box;

  @override
  void initState() {
    _box = Hive.box(hiveProgressBox);
    super.initState();
  }

  int getTotalProgress() {
    double totalProgress = 0;
    PRACTICE_TEST_GROUPS.forEach((element) {
      totalProgress += _box.get(element.id, defaultValue: 0);
    });
    EXAM_TEST_GROUPS.forEach((element) {
      totalProgress += _box.get(element.id, defaultValue: 0);
    });

    return (totalProgress /
            (PRACTICE_TEST_GROUPS.length + EXAM_TEST_GROUPS.length))
        .round();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0),
      width: double.infinity,
      height: 145.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            hexToColor('#599BF0'),
            hexToColor('#4785EB'),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Multiplication Table',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: GoogleFonts.titilliumWeb(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 24.0,
                        letterSpacing: .5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      'Your progress: ',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 14.0,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 7.0),
                    child: new LinearPercentIndicator(
                      width: 200.0,
                      animation: true,
                      animationDuration: 700,
                      lineHeight: 12.0,
                      percent: getTotalProgress() / 100,
                      backgroundColor: hexToColor('#E6E6E6'),
                      center: Text(
                        getTotalProgress().toString() + ' XP',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: hexToColor('#3D3D74'),
                          fontSize: 12.0,
                        ),
                      ),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: hexToColor('#F7AC1A'),
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 35.0,
                backgroundImage: AssetImage('assets/images/faceIcon.png'),
                backgroundColor: Colors.white,
              )
            ],
          ),
        ],
      ),
    );
  }
}
