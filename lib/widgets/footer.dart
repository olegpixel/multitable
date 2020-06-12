import 'package:flutter/material.dart';
import 'package:multitables/screens/language_screen.dart';
import 'package:multitables/screens/settings_screen.dart';
import 'package:multitables/funcs/localisations.dart';

class MenuIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String pathTo;

  MenuIcon(this.title, this.icon, this.color, this.pathTo);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pushNamed(pathTo),
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Column(
              children: <Widget>[
                Icon(
                  icon,
                  color: color,
                  size: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    '$title',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: color,
                      fontSize: 12.0,
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
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
//          MenuIcon('Home', Icons.home, hexToColor('#666666')),
          MenuIcon(AppLocalizations.of(context).translate('home-screen_footer-language'), Icons.language,
              Color(0xff666666), LanguageScreen.routeName),
          MenuIcon(AppLocalizations.of(context).translate('home-screen_footer-settings'), Icons.settings,
              Color(0xff666666), SettingsScreen.routeName),
//          MenuIcon(AppLocalizations.of(context).translate('home-screen_footer-rate-us'), Icons.star,
//             Color(0xffFF8A5B), '/'),
        ],
      ),
      height: 60.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xff999999).withOpacity(0.18),
            spreadRadius: 5,
            blurRadius: 15,
            offset: Offset(0, -3), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
