import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final bool light;
  final bool small;
  final bool outlined;

  StyledButton({this.onPressed, this.text, this.light = false, this.small = false, this.outlined = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        child: FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          color: (light) ? Color(0xffE3F0FF) : Color(0xff4785EB),
          textColor: Colors.white,
          onPressed: onPressed,
          padding: small ? const EdgeInsets.all(15.0) : const EdgeInsets.all(21.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: small ? 16.0 : 22.0,
              fontWeight: FontWeight.w600,
              color: (light) ? Color(0xff589AEF) : Colors.white,
              letterSpacing: 0.3,
            ),
          ),
        ),
        decoration: (!light)
            ? BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(35)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(0xff4785EB).withOpacity(0.4),
                    blurRadius: 25,
                    offset: Offset(0, 15),
                  ),
                ],
              )
            : null,
      ),
    );
  }
}
