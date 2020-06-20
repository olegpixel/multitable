import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final bool light;
  final bool small;
  final bool outlined;
  final double wc;
  final double hc;

  StyledButton({
    this.onPressed,
    this.text,
    this.light = false,
    this.small = false,
    this.outlined = false,
    this.wc = 1.0,
    this.hc = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.0 * wc),
      child: Container(
        child: FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35 * wc)),
          color: (light) ? Color(0xffE3F0FF) : Color(0xff4785EB),
          textColor: Colors.white,
          onPressed: onPressed,
          padding: small ? EdgeInsets.all(15.0 * wc) : EdgeInsets.all(21.0 * wc),
          child: Text(
            text,
            style: TextStyle(
              fontSize: small ? 16.0 * wc : 22.0 * wc,
              fontWeight: FontWeight.w600,
              color: (light) ? Color(0xff589AEF) : Colors.white,
              letterSpacing: 0.3,
            ),
          ),
        ),
        decoration: (!light)
            ? BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(35 * wc)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(0xff4785EB).withOpacity(0.4),
                    blurRadius: 25 * wc,
                    offset: Offset(0, 15 * wc),
                  ),
                ],
              )
            : null,
      ),
    );
  }
}
