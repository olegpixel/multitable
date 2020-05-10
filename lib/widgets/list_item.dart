import 'package:flutter/material.dart';
import '../funcs/funcs.dart';
import 'package:google_fonts/google_fonts.dart';

class ListItem extends StatelessWidget {
  final String title;
  final String iconImage;
  final String backgroundColor;
  final String pathTo;

  const ListItem({
    this.title,
    this.iconImage = '',
    this.backgroundColor,
    this.pathTo,
  });

  void selectCategory(BuildContext ctx) {
//    Navigator.of(ctx).pushNamed(pathTo);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin:
            EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 8.0),
        height: 115.0,
        child: InkWell(
          onTap: () => selectCategory(context),
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: hexToColor("#c3c3c3").withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 8,
                  offset: Offset(0, -2), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
//                        child: Text('asdfads'),
                        width: 67.0,
                        height: 67.0,
                        decoration: BoxDecoration(
                          color: hexToColor('#5F4C9E'),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '$title',
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: hexToColor('#3D3D74'),
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              '$title',
                              overflow: TextOverflow.clip,
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: hexToColor('#999999'),
                                  fontSize: 11.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
//                    width: double.infinity,
//                    height: double.infinity,

//            decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(15.0),
//              color: hexToColor('$backgroundColor'),
////              image: DecorationImage(
////                image: AssetImage("$iconImage"),
////                fit: BoxFit.cover,
////              ),
//            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
