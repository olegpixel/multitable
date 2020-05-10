import 'package:flutter/material.dart';
import '../sharedFuncs/funcs.dart';
import 'package:google_fonts/google_fonts.dart';
import '../practice_screen.dart';

class SquareMenuItem extends StatelessWidget {
  final String title;
  final String backgroundImage;
  final String backgroundColor;
  final Function clickHandler;
  final EdgeInsets sqMargin;

  const SquareMenuItem(this.title, this.backgroundImage, this.backgroundColor,
      this.sqMargin, this.clickHandler);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return PracticeScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: sqMargin,
        child: InkWell(
          onTap: () => selectCategory(context),
          splashColor: Colors.red,
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 28.0, left: 18.0),
              child: Text(
                '$title',
                overflow: TextOverflow.clip,
                style: GoogleFonts.titilliumWeb(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: hexToColor('#3D3D74'),
                    fontSize: 33.0,
                    letterSpacing: .5,
                  ),
                ),
              ),
            ),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: hexToColor('$backgroundColor'),
              image: DecorationImage(
                image: AssetImage("$backgroundImage"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
