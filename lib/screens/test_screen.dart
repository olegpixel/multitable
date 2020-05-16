import 'package:flutter/material.dart';
import '../funcs/funcs.dart';
import 'package:google_fonts/google_fonts.dart';

class AnswerSquare extends StatelessWidget {
  final String answerText;

  AnswerSquare(this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: hexToColor("#004080").withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 8,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Text(
          answerText,
          overflow: TextOverflow.clip,
          style: GoogleFonts.titilliumWeb(
            textStyle: TextStyle(
              fontWeight: FontWeight.w700,
              color: hexToColor('#3D3D74'),
              fontSize: 53.0,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

class TestScreen extends StatelessWidget {
  static const routeName = '/test';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: hexToColor('#3D3D74')),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'Text',
          style: TextStyle(color: hexToColor('#3D3D74')),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Text(
              '1  of  10',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: hexToColor('#888992'),
                  fontSize: 19.0,
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              '12 x 12 = ?',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: hexToColor('#202027'),
                  fontSize: 67.0,
                ),
              ),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 20.0, right: 7.0, bottom: 6.0),
                          child: InkWell(
                            onTap: () => {},
                            borderRadius: BorderRadius.circular(15.0),
                            child: AnswerSquare("12"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 7.0, top: 20.0, right: 20.0, bottom: 6.0),
                          child: InkWell(
                            onTap: () => {},
                            borderRadius: BorderRadius.circular(15.0),
                            child: AnswerSquare("9"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 20.0, right: 7.0, bottom: 6.0),
                          child: InkWell(
                            onTap: () => {},
                            borderRadius: BorderRadius.circular(15.0),
                            child: AnswerSquare("155"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 7.0, top: 20.0, right: 20.0, bottom: 6.0),
                          child: InkWell(
                            onTap: () => {},
                            borderRadius: BorderRadius.circular(15.0),
                            child: AnswerSquare("0"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
