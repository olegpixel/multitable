import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import '../widgets/header.dart';
import 'package:multitables/datastore/progress_dao.dart';

class StatsScreen extends StatelessWidget {
  static const routeName = '/stats';

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex;

  @override
  Widget build(BuildContext context) {
    List<dynamic> tmp = getLastWeekProgress();
    double maxY = [
      tmp[0][1],
      tmp[0][2],
      tmp[1][1],
      tmp[1][2],
      tmp[2][1],
      tmp[2][2],
      tmp[3][1],
      tmp[3][2],
      tmp[4][1],
      tmp[4][2],
      tmp[5][1],
      tmp[5][2],
      tmp[6][1],
      tmp[6][2]
    ].reduce((curr, next) => curr > next ? curr : next);

    print(maxY);

    final barGroup1 = makeGroupData(0, tmp[0][1], tmp[0][2]);
    final barGroup2 = makeGroupData(1, tmp[1][1], tmp[1][2]);
    final barGroup3 = makeGroupData(2, tmp[2][1], tmp[2][2]);
    final barGroup4 = makeGroupData(3, tmp[3][1], tmp[3][2]);
    final barGroup5 = makeGroupData(4, tmp[4][1], tmp[4][2]);
    final barGroup6 = makeGroupData(5, tmp[5][1], tmp[5][2]);
    final barGroup7 = makeGroupData(6, tmp[6][1], tmp[6][2]);

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
              description: 'Practice and learn',
              image: 'assets/images/square1.png',
              bgColor: '#FFEABA',
            ),
            Container(
              child: AspectRatio(
                aspectRatio: 1,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  color: const Color(0xff2c4260),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Transactions',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 38,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: BarChart(
                              BarChartData(
                                maxY: maxY,
                                barTouchData: BarTouchData(
                                  touchTooltipData: BarTouchTooltipData(
                                    tooltipBgColor: Colors.grey,
                                    getTooltipItem: (_a, _b, _c, _d) => null,
                                  ),
                                ),
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: SideTitles(
                                    showTitles: true,
                                    textStyle: TextStyle(
                                        color: const Color(0xff7589a2),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                    margin: 20,
                                    getTitles: (double value) {
                                      return tmp[value.toInt()][0];
                                    },
                                  ),
                                  leftTitles: SideTitles(
                                    showTitles: true,
                                    textStyle: TextStyle(
                                        color: const Color(0xff7589a2),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                    margin: 32,
                                    reservedSize: 14,
                                    getTitles: (value) {
                                      if (value % 10 == 0) {
                                        return value.toInt().toString();
                                      } else {
                                        return '';
                                      }
                                    },
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                barGroups: showingBarGroups,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
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
      color: const Color(0xffff5182),
      width: 7.0,
    ),
    BarChartRodData(
      y: y2,
      color: const Color(0xff53fdd7),
      width: 7.0,
    ),
  ]);
}
