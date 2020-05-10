import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'sharedFuncs/funcs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/squares.dart';
import 'widgets/footer.dart';
import 'widgets/progress_bar.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0),
            width: double.infinity,
            height: 145.0,
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
                            percent: 0.21,
                            backgroundColor: hexToColor('#E6E6E6'),
                            center: Text(
                              "21.0%",
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
//                        ProgressBar(30),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          children: <Widget>[
//                            Padding(
//                              padding: const EdgeInsets.only(right: 8.0),
//                              child: Text(
//                                'Solved today: 150',
////                              textAlign: TextAlign.center,
//                                overflow: TextOverflow.ellipsis,
//                                style: TextStyle(
//                                  fontWeight: FontWeight.normal,
//                                  color: Colors.white,
//                                  fontSize: 14.0,
//                                  fontFamily: 'Lato',
//                                ),
//                              ),
//                            ),
//                            Text(
//                              'Total: 2865',
////                              textAlign: TextAlign.center,
//                              overflow: TextOverflow.ellipsis,
//                              style: TextStyle(
//                                fontWeight: FontWeight.normal,
//                                color: Colors.white,
//                                fontSize: 14.0,
//                                fontFamily: 'Lato',
//                              ),
//                            ),
//                          ],
//                        ),
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
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SquareMenuItem(
                        'Tables',
                        'assets/images/square1.png',
                        '#F9CF72',
                        EdgeInsets.only(
                            left: 20.0, top: 20.0, right: 10.0, bottom: 10.0),
                        () => {},
                      ),
                      SquareMenuItem(
                        'Practice',
                        'assets/images/square2.png',
                        '#FFEABA',
                        EdgeInsets.only(
                            left: 10.0, top: 20.0, right: 20.0, bottom: 10.0),
                        () => {},
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SquareMenuItem(
                        'Exam',
                        'assets/images/square3.png',
                        '#B3EEFA',
                        EdgeInsets.only(
                            left: 20.0, top: 10.0, right: 10.0, bottom: 20.0),
                        () => {},
                      ),
                      SquareMenuItem(
                        'Stats',
                        'assets/images/square4.png',
                        '#FFD5DF',
                        EdgeInsets.only(
                            left: 10.0, top: 10.0, right: 20.0, bottom: 20.0),
                        () => {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Footer(),
        ],
      ),
    );
  }
}
