import 'package:flutter/material.dart';
import 'package:multitables/screens/language_screen.dart';
import 'package:multitables/screens/settings_screen.dart';
import 'package:multitables/funcs/localisations.dart';

class MenuIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String pathTo;
  final double wc;
  final double hc;

  MenuIcon(this.title, this.icon, this.color, this.pathTo, this.wc, this.hc);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        InkWell(
          onTap: () => Navigator.of(context).pushNamed(pathTo),
          child: Padding(
            padding: EdgeInsets.only(top: 4.0 * hc, bottom: 4.0 * hc),
            child: Column(
              children: <Widget>[
                Icon(
                  icon,
                  color: color,
                  size: 25.0 * wc,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0 * hc),
                  child: Text(
                    '$title',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: color,
                      fontSize: 12.0 * wc,
                      fontFamily: 'Lato',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context);
    final screenWidth = mediaQuerySize.size.width;
    final screenHeight = mediaQuerySize.size.height;
    final hc = screenHeight / 683;
    final wc = screenWidth / 411;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          MenuIcon(AppLocalizations.of(context).translate('home-screen_footer-language'), Icons.language,
              Color(0xff666666), LanguageScreen.routeName, hc, wc),
          MenuIcon(AppLocalizations.of(context).translate('home-screen_footer-settings'), Icons.settings,
              Color(0xff666666), SettingsScreen.routeName, hc, wc),
//          MenuIcon(AppLocalizations.of(context).translate('home-screen_footer-rate-us'), Icons.star,
//             Color(0xffFF8A5B), '/'),
        ],
      ),
      height: 60.0 * hc,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25 * wc),
          topRight: Radius.circular(25 * wc),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xff999999).withOpacity(0.18),
            spreadRadius: 5 * hc,
            blurRadius: 15 * hc,
            offset: Offset(0, -3 * hc), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
