import 'package:flutter/material.dart';
import 'package:multitables/funcs/funcs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multitables/datastore/progress_dao.dart';
import 'package:multitables/models/user_level.dart';

class MainHeader extends StatefulWidget {
  @override
  _MainHeaderState createState() => _MainHeaderState();
}

class _MainHeaderState extends State<MainHeader> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0),
      width: double.infinity,
      height: 155.0,
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
                    'Multiplication Tables',
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
                  Text(
                    'Next level:',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: GoogleFonts.titilliumWeb(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: Hive.box(HIVE_PROGRESS_BOX)
                        .listenable(keys: [TOTAL_SOLVED_KEY]),
                    builder: (context, box, w) {
                      return Padding(
                        padding: EdgeInsets.only(top: 7.0),
                        child: () {
                          NextLevelPoints p = getPointsToNextLevel();
                          return LinearPercentIndicator(
                            width: 250.0,
                            animation: true,
                            animationDuration: 700,
                            lineHeight: 18.0,
                            percent: p.current / p.totalLevelPoints,
                            backgroundColor: Color(0xffE6E6E6),
                            center: Text(
                              "${p.current} / ${p.totalLevelPoints} XP",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xff3D3D74),
                                fontSize: 13.0,
                              ),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Color(0xffF7AC1A),
                          );
                        }(),
                      );
                    },
                  ),
                ],
              ),
              ValueListenableBuilder(
                valueListenable: Hive.box(HIVE_PROGRESS_BOX)
                    .listenable(keys: [TOTAL_SOLVED_KEY]),
                builder: (context, box, w) {
                  UserLevel level = getCurrentUserLevel();
                  return Container(
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 40.0,
                          child: new Image.asset(
                              'assets/images/animals/' + level.icon,
                              width: 76.0,
                              height: 76.0),
                          backgroundColor: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            '${level.name}',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 15.0,
                              letterSpacing: .5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
