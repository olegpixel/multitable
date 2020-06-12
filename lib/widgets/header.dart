import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final int bgColor;

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
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0),
      margin: const EdgeInsets.only(bottom: 10.0),
      width: double.infinity,
      height: 145.0,
      decoration: BoxDecoration(
        color: Color(bgColor),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () => goHomeScreen(context),
                          borderRadius: BorderRadius.circular(15.0),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, right: 15.0),
                            child: Icon(
                              Icons.arrow_back,
                              color: Color(0xff3D3D74),
                              size: 25.0,
                            ),
                          ),
                        ),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.titilliumWeb(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xff3D3D74),
                              fontSize: 24.0,
                              letterSpacing: .5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2.0, right: 10.0),
                      child: Text(
                        description,
                        textAlign: TextAlign.left,
//                        height: 1.01,
                        style: TextStyle(
                          height: 1.2,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff3D3D74),
                          fontSize: 15.0,
//                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Image(
                  image: AssetImage(
                    image,
                  ),
                  width: 100.0,
                  height: 100.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
