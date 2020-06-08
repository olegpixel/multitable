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
    List<dynamic> lastWeekProgress = getLastWeekProgress();
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

    showingBarGroups = rawBarGroups;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Header(
              title: 'Your progress',
              description: 'Check your progress in learning times tables.',
              image: 'assets/images/elearning_stat.png',
              bgColor: '#FFEABA',
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff3D3D74),
                          fontSize: 19.0,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'Solved last 7 days: '),
                          TextSpan(
                              text: totalLastWeekSolved.toString() + ' problems',
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
                        fontSize: 19.0,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Solved total: '),
                        TextSpan(
                            text: getTotalCounter().toString() + ' problems',
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
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        const SizedBox(
                          height: 18,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: BarChart(
                              BarChartData(
                                maxY: maxY,
//                                barTouchData: BarTouchData(
//                                  touchTooltipData: BarTouchTooltipData(
//                                    tooltipBgColor: Colors.grey,
//                                    getTooltipItem: (_a, _b, _c, _d) => null,
//                                  ),
//                                ),
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: SideTitles(
                                    showTitles: true,
                                    textStyle: TextStyle(
                                        color: const Color(0xff3D3D74), fontWeight: FontWeight.w500, fontSize: 15),
                                    margin: 12,
                                    getTitles: (double value) {
                                      return lastWeekProgress[value.toInt()][0];
                                    },
                                  ),
                                  leftTitles: SideTitles(
                                    showTitles: true,
                                    textStyle: TextStyle(
                                        color: const Color(0xff3D3D74), fontWeight: FontWeight.w500, fontSize: 15),
                                    margin: 20,
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
                        const SizedBox(
                          height: 12,
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
                                    width: 12.0,
                                    height: 12.0,
                                  ),
                                  Text(
                                    'Wrong',
                                    style: TextStyle(
                                      color: Color(0xff3D3D74),
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 12.0, right: 6.0),
                                    color: const Color(0xff4CAF50),
                                    width: 12.0,
                                    height: 12.0,
                                  ),
                                  Text(
                                    'Correct',
                                    style: TextStyle(
                                      color: Color(0xff3D3D74),
                                      fontSize: 14.0,
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
