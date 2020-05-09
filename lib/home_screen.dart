import 'package:flutter/material.dart';
import 'sharedFuncs/funcs.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
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
          Container(
            child: Text('asFsdsad'),
          ),
          Container(
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.volume_up),
                  tooltip: 'Increase volume by 10',
                  onPressed: () {
                    setState(() {
                      _volume += 10;
                    });
                  },
                ),
                (
                  Icons.home,
                  color: Colors.grey,
                  size: 24.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                  label: '',
                ),
              ],
            ),
            height: 97.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: hexToColor("#999999").withOpacity(0.16),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, -3), // changes position of shadow
                ),
              ],
            ),
//            color: Colors.red,
//            decoration: BoxDecoration(
//              border: Border(
//                top: BorderSide(
//                  width: 3.0,
//                  color: Colors.black,
//                ),
//              ),
//              borderRadius: BorderRadius.only(
//                topLeft: Radius.circular(10),
//                topRight: Radius.circular(10),
//                bottomLeft: Radius.circular(10),
//                bottomRight: Radius.circular(10),
//              ),
////              boxShadow: [
////                BoxShadow(
////                  color: Colors.grey.withOpacity(0.5),
////                  spreadRadius: 5,
////                  blurRadius: 7,
////                  offset: Offset(0, 3), // changes position of shadow
////                ),
////              ],
//            ),
//            padding: const EdgeInsets.symmetric(
//              vertical: 15.0,
//              horizontal: 20.0,
//            ),
          ),
        ],
      ),
    );
  }
}
