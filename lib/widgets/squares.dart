import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SquareMenuItem extends StatelessWidget {
  final String title;
  final String backgroundImage;
  final int backgroundColor;
  final Widget iconImage;
  final String pathTo;
  final EdgeInsets margins;
  final double wc;
  final double hc;
  final double size;

  const SquareMenuItem({
    this.title,
    this.backgroundImage,
    this.backgroundColor,
    this.iconImage,
    this.margins,
    this.pathTo,
    this.wc,
    this.hc,
    this.size,
  });

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(pathTo);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margins,
      child: InkWell(
        onTap: () => selectCategory(context),
        borderRadius: BorderRadius.circular(15.0 * wc),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0 * wc),
            color: Color(backgroundColor),
            image: DecorationImage(
              image: AssetImage("$backgroundImage"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 27.0 * hc, left: 15.0 * wc),
                child: Text(
                  '$title',
                  overflow: TextOverflow.clip,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xff3D3D74),
                      fontSize: 30.0 * wc,
                      letterSpacing: .5,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: iconImage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
