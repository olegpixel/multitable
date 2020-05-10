import 'package:flutter/material.dart';
import '../funcs/funcs.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/list_item.dart';
import '../widgets/header.dart';

class PracticeScreen extends StatelessWidget {
  static const routeName = '/practice';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
//        color: hexToColor('#F6F7FC'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Header(
              title: 'Tables',
              description: 'Practice and learn',
              image: 'assets/images/square1.png',
              bgColor: '#FFEABA',
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
//                  Expanded(
//                    child:
                  ListItem(
                    title: 'Tables',
                    iconImage: 'assets/images/square1.png',
                    backgroundColor: '#F9CF72',
                    pathTo: '',
                  ),
                  ListItem(
                    title: 'Tables',
                    iconImage: 'assets/images/square1.png',
                    backgroundColor: '#F9CF72',
                    pathTo: '',
                  ),
                  ListItem(
                    title: 'Tables',
                    iconImage: 'assets/images/square1.png',
                    backgroundColor: '#F9CF72',
                    pathTo: '',
                  ),
                  ListItem(
                    title: 'Tables',
                    iconImage: 'assets/images/square1.png',
                    backgroundColor: '#F9CF72',
                    pathTo: '',
                  ),
                  ListItem(
                    title: 'Tables',
                    iconImage: 'assets/images/square1.png',
                    backgroundColor: '#F9CF72',
                    pathTo: '',
                  ),
//                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
