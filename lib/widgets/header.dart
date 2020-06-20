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
    final mediaQuerySize = MediaQuery.of(context);
    final screenWidth = mediaQuerySize.size.width;
    final screenHeight = mediaQuerySize.size.height;
    final hc = screenHeight / 683;
    final wc = screenWidth / 411;

    return Container(
      padding: EdgeInsets.fromLTRB(20.0 * wc, 0.0, 20.0 * wc, 0),
      margin: EdgeInsets.only(bottom: 10.0 * hc),
      width: double.infinity,
      height: 120.0 * hc,
      decoration: BoxDecoration(
        color: Color(bgColor),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40 * hc)),
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
                          borderRadius: BorderRadius.circular(15.0 * hc),
                          child: Padding(
                            padding: EdgeInsets.only(top: 12.0 * hc, bottom: 12.0 * hc, right: 15.0 * wc),
                            child: Icon(
                              Icons.arrow_back,
                              color: Color(0xff3D3D74),
                              size: 25.0 * wc,
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
                              fontSize: 24.0 * wc,
                              letterSpacing: .5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2.0 * hc, right: 10.0 * wc),
                      child: Text(
                        description,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          height: 1.2,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff3D3D74),
                          fontSize: 15.0 * wc,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0 * hc),
                child: Image(
                  image: AssetImage(
                    image,
                  ),
                  width: 100.0 * wc,
                  height: 100.0 * hc,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
