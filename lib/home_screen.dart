import 'package:flutter/material.dart';
import 'sharedFuncs/funcs.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        width: double.infinity,
        height: 150.0,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Hello,  How are you?',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 34.0,
                    fontFamily: 'Lato',
//                    fontFamily:
//                      font-family: SF UI Display;
//                      font-size: 34px;
//                  line-height: 41px;
                  ),
                ),
                Text('asdf')
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
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
