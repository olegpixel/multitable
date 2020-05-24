import 'package:flutter/material.dart';
import 'package:multitables/funcs/funcs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multitables/models/test_group.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multitables/datastore/constants.dart';

class TestScreen extends StatefulWidget {
  static const routeName = '/test';

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  Box _box;
  String _question;
  List<String> _answers;

  @override
  void initState() {
    _box = Hive.box(hiveProgressBox);
    super.initState();
  }

  void passArgsToState(TestGroup testGroup) {
    setState(() {
      _question = testGroup.title;
    });
  }

  @override
  Widget build(BuildContext context) {
    final testGroup = ModalRoute.of(context).settings.arguments as TestGroup;
    passArgsToState(testGroup);

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
          testGroup.title,
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
              _question,
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
