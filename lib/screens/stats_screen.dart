import 'package:flutter/material.dart';
import '../funcs/funcs.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/list_item.dart';
import '../widgets/header.dart';

class StatsScreen extends StatelessWidget {
  static const routeName = '/stats';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Stats'),
        ),
      ),
    );
  }
}
