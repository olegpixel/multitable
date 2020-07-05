import 'package:flutter/material.dart';
import 'package:multitables/widgets/header.dart';
import 'package:multitables/funcs/localisations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multitables/screens/game_dragndrop_screen.dart';

class GamesScreen extends StatelessWidget {
  static const routeName = '/games';

  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context);
    final screenWidth = mediaQuerySize.size.width;
    final screenHeight = mediaQuerySize.size.height;
    final hc = screenHeight / 683;
    final wc = screenWidth / 411;

    return Container(
      color: Color(0xffFFEABA),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Header(
                  title: AppLocalizations.of(context).translate('games-screen_title'),
                  description: AppLocalizations.of(context).translate('games-screen_description'),
                  image: 'assets/images/games/arcade.png',
                  bgColor: 0xffFFEABA,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      GameMenuItem(
                        hc,
                        wc,
                        "Drag ' n ' drop",
                        "drag.png",
                        "Desc",
                        DragNDropGame.routeName,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GameMenuItem extends StatelessWidget {
  final double hc;
  final double wc;
  final String title;
  final String iconImage;
  final String desc;
  final String pathTo;

  GameMenuItem(this.hc, this.wc, this.title, this.iconImage, this.desc, this.pathTo);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 20.0 * wc, top: 10.0 * hc, right: 20.0 * wc, bottom: 8.0 * hc),
        height: 100.0 * hc,
        child: InkWell(
          onTap: () => Navigator.of(context).pushNamed(pathTo),
          borderRadius: BorderRadius.circular(8.0 * hc),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0 * hc),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffc3c3c3).withOpacity(0.5),
                  spreadRadius: 4 * wc,
                  blurRadius: 8 * wc,
                  offset: Offset(0, -2), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 5.0 * hc, left: 15.0 * wc, bottom: 10.0 * hc, right: 20.0 * wc),
                      child: Image(
                        image: AssetImage(
                          'assets/images/games/' + iconImage,
                        ),
                        width: 64.0 * wc,
                        height: 64.0 * hc,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title, //AppLocalizations.of(context).translate(widget.testGroup.id),
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xff3D3D74),
                              fontSize: 17.0 * wc,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0 * hc, bottom: 8.0 * wc),
                            child: Text(
                              desc,
                              // AppLocalizations.of(context).translate('practice-screen_text-questions'),
                              overflow: TextOverflow.clip,
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                  fontSize: 13.0 * wc,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
