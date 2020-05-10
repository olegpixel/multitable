import 'package:flutter/material.dart';
import '../funcs/funcs.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final String bgColor;

  Header({
    this.title,
    this.description = '',
    this.image,
    this.bgColor,
  });

  void goHomeScreen(BuildContext ctx) {
    Navigator.of(ctx).pushNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0),
      margin: const EdgeInsets.only(bottom: 10.0),
      width: double.infinity,
      height: 165.0,
      decoration: BoxDecoration(
        color: hexToColor(bgColor),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () => goHomeScreen(context),
                        borderRadius: BorderRadius.circular(15.0),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, bottom: 12.0, right: 15.0),
                          child: Icon(
                            Icons.arrow_back,
                            color: hexToColor('#3D3D74'),
                            size: 25.0,
                          ),
                        ),
                      ),
                      Text(
                        '$title',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.titilliumWeb(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: hexToColor('#3D3D74'),
                            fontSize: 24.0,
                            letterSpacing: .5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      '$description',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: hexToColor('#3D3D74'),
                        fontSize: 14.0,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ),
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
    );
  }
}
