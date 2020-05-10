import 'package:flutter/material.dart';
import '../funcs/funcs.dart';

class MenuIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  MenuIcon(this.title, this.icon, this.color);

  void clickHandler(BuildContext ctx) {
//    Navigator.of(ctx).pushNamed(pathTo);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FlatButton(
          onPressed: () {},
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
          MenuIcon('Home', Icons.home, hexToColor('#666666')),
          MenuIcon('Settings', Icons.settings, hexToColor('#666666')),
          MenuIcon('Language', Icons.language, hexToColor('#666666')),
          MenuIcon('Rate Us', Icons.star, hexToColor('#FF8A5B')),
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
            color: hexToColor("#999999").withOpacity(0.18),
            spreadRadius: 5,
            blurRadius: 15,
            offset: Offset(0, -3), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
