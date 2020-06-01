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
