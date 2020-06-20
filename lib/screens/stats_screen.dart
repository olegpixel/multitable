import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:multitables/widgets/header.dart';
import 'package:multitables/datastore/progress_dao.dart';
import 'package:multitables/funcs/localisations.dart';

class StatsScreen extends StatelessWidget {
  static const routeName = '/stats';

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex;

  @override
  Widget build(BuildContext context) {
    List<dynamic> lastWeekProgress = getLastWeekProgress(context);
    double maxY = [
      lastWeekProgress[0][1],
      lastWeekProgress[0][2],
      lastWeekProgress[1][1],
      lastWeekProgress[1][2],
      lastWeekProgress[2][1],
      lastWeekProgress[2][2],
      lastWeekProgress[3][1],
      lastWeekProgress[3][2],
      lastWeekProgress[4][1],
      lastWeekProgress[4][2],
      lastWeekProgress[5][1],
      lastWeekProgress[5][2],
      lastWeekProgress[6][1],
      lastWeekProgress[6][2]
    ].reduce((curr, next) => curr > next ? curr : next);

    int totalLastWeekSolved = 0;
    for (final p in lastWeekProgress) {
      totalLastWeekSolved += (p[2]).toInt();
    }

    int segment = (maxY / 10).round().toInt();
    segment = segment == 0 ? 1 : segment;
    maxY += segment;

    final barGroup1 = makeGroupData(0, lastWeekProgress[0][1], lastWeekProgress[0][2]);
    final barGroup2 = makeGroupData(1, lastWeekProgress[1][1], lastWeekProgress[1][2]);
    final barGroup3 = makeGroupData(2, lastWeekProgress[2][1], lastWeekProgress[2][2]);
    final barGroup4 = makeGroupData(3, lastWeekProgress[3][1], lastWeekProgress[3][2]);
    final barGroup5 = makeGroupData(4, lastWeekProgress[4][1], lastWeekProgress[4][2]);
    final barGroup6 = makeGroupData(5, lastWeekProgress[5][1], lastWeekProgress[5][2]);
    final barGroup7 = makeGroupData(6, lastWeekProgress[6][1], lastWeekProgress[6][2]);

    rawBarGroups = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    String problemText(int n) {
      return ''; //AppLocalizations.of(context).translate('stats-screen_problems');
    }

    showingBarGroups = rawBarGroups;

    final mediaQuerySize = MediaQuery.of(context);
    final screenWidth = mediaQuerySize.size.width;
    final screenHeight = mediaQuerySize.size.height;
    final hc = screenHeight / 683;
    final wc = screenWidth / 411;

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
                  title: AppLocalizations.of(context).translate('stats-screen_title'),
                  description: AppLocalizations.of(context).translate('stats-screen_description'),
                  image: 'assets/images/elearning_stat.png',
                  bgColor: 0xffFFEABA,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0 * wc, top: 10.0 * hc),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 15.0 * hc, bottom: 15.0 * hc),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color(0xff3D3D74),
                              fontSize: 19.0 * wc,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: AppLocalizations.of(context).translate('stats-screen_solved-total')),
                              TextSpan(
                                  text: () {
                                    int tc = getTotalCounter();
                                    return tc.toString() + problemText(tc);
                                  }(),
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xff3D3D74),
                            fontSize: 19.0 * wc,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: AppLocalizations.of(context).translate('stats-screen_solved-7-days')),
                            TextSpan(
                                text: totalLastWeekSolved.toString() + problemText(totalLastWeekSolved),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.all(16 * hc),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            SizedBox(
                              height: 18 * hc,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0 * hc),
                                child: BarChart(
                                  BarChartData(
                                    maxY: maxY,
                                    titlesData: FlTitlesData(
                                      show: true,
                                      bottomTitles: SideTitles(
                                        showTitles: true,
                                        textStyle: TextStyle(
                                            color: const Color(0xff3D3D74),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15 * wc),
                                        margin: 12 * wc,
                                        getTitles: (double value) {
                                          return lastWeekProgress[value.toInt()][0];
                                        },
                                      ),
                                      leftTitles: SideTitles(
                                        showTitles: true,
                                        textStyle: TextStyle(
                                            color: const Color(0xff3D3D74),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15 * wc),
                                        margin: 20 * wc,
                                        reservedSize: 14,
                                        getTitles: (value) {
                                          if (value % (segment * 2) == 0) {
                                            return value.toInt().toString();
                                          } else {
                                            return '';
                                          }
                                        },
                                      ),
                                    ),
                                    gridData: FlGridData(
                                        show: true,
                                        drawVerticalLine: true,
                                        checkToShowHorizontalLine: (value) {
                                          if (value % segment == 0) {
                                            return true;
                                          } else {
                                            return false;
                                          }
                                          return true;
                                        }),
                                    borderData: FlBorderData(
                                      show: true,
                                      border: const Border(
                                        left: BorderSide(color: Colors.blueGrey),
                                        top: BorderSide(color: Colors.transparent),
                                        bottom: BorderSide(color: Colors.blueGrey),
                                        right: BorderSide(color: Colors.transparent),
                                      ),
                                    ),
                                    barGroups: showingBarGroups,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12 * hc,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.only(right: 6.0),
                                        color: const Color(0xffE24C4B),
                                        width: 12.0 * wc,
                                        height: 12.0 * hc,
                                      ),
                                      Text(
                                        AppLocalizations.of(context).translate('stats-screen_chart-wrong'),
                                        style: TextStyle(
                                          color: Color(0xff3D3D74),
                                          fontSize: 14.0 * wc,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 12.0 * wc, right: 6.0 * wc),
                                        color: const Color(0xff4CAF50),
                                        width: 12.0 * wc,
                                        height: 12.0 * hc,
                                      ),
                                      Text(
                                        AppLocalizations.of(context).translate('stats-screen_chart-correct'),
                                        style: TextStyle(
                                          color: Color(0xff3D3D74),
                                          fontSize: 14.0 * wc,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
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

BarChartGroupData makeGroupData(int x, double y1, double y2) {
  return BarChartGroupData(barsSpace: 4, x: x, barRods: [
    BarChartRodData(
      y: y1,
      color: const Color(0xffE24C4B),
      width: 7.0,
    ),
    BarChartRodData(
      y: y2,
      color: const Color(0xff4CAF50),
      width: 7.0,
    ),
  ]);
}
