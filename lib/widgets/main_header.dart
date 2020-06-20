import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multitables/datastore/progress_dao.dart';
import 'package:multitables/models/user_level.dart';
import 'package:multitables/funcs/localisations.dart';

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
    final mediaQuerySize = MediaQuery.of(context);
    final screenWidth = mediaQuerySize.size.width;
    final screenHeight = mediaQuerySize.size.height;
    final hc = screenHeight / 683;
    final wc = screenWidth / 411;

    return Container(
      padding: EdgeInsets.fromLTRB(20.0 * wc, 10.0 * hc, 20.0 * wc, 0),
      width: double.infinity,
      height: 125.0 * hc,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xff599BF0),
            const Color(0xff4785EB),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40 * hc)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      AppLocalizations.of(context).translate('home-screen_title'),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.titilliumWeb(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 24.0 * wc,
                          letterSpacing: .5,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 240 * wc,
                    child: SizedBox(
                      child: Text(
                        AppLocalizations.of(context).translate('home-screen_points-to-next-level'),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.titilliumWeb(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 17.0 * wc,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: Hive.box(HIVE_PROGRESS_BOX).listenable(keys: [TOTAL_SOLVED_KEY]),
                    builder: (context, box, w) {
                      return Padding(
                        padding: EdgeInsets.only(top: 7.0),
                        child: () {
                          NextLevelPoints p = getPointsToNextLevel();
                          return LinearPercentIndicator(
                            width: 250 * wc,
                            animation: true,
                            animationDuration: 700,
                            lineHeight: 18.0 * hc,
                            percent: p.current / p.totalLevelPoints,
                            backgroundColor: Color(0xffE6E6E6),
                            center: Text(
                              "${p.current} / ${p.totalLevelPoints} XP",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xff3D3D74),
                                fontSize: 13.0 * wc,
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
                valueListenable: Hive.box(HIVE_PROGRESS_BOX).listenable(keys: [TOTAL_SOLVED_KEY]),
                builder: (context, box, w) {
                  UserLevel level = getCurrentUserLevel();
                  return Container(
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 40.0 * hc,
                          child: new Image.asset('assets/images/animals/' + level.icon,
                              width: 76.0 * hc, height: 76.0 * hc),
                          backgroundColor: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            AppLocalizations.of(context).translate('home-screen_level') + ' ' + level.name,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 15.0 * wc,
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
