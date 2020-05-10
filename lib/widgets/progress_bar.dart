import 'package:flutter/material.dart';
import '../funcs/funcs.dart';

class ProgressBar extends StatelessWidget {
  final int progress;

  const ProgressBar(this.progress);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12.0,
      width: 250.0,
      margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: hexToColor('#EEEEEE'),
      ),
      child: Container(
//        width: 250 / 100 * progress,
        width: 50.0,
        height: 8.0,
        color: Colors.red,
        alignment: Alignment.center,
//        constraints: BoxConstraints(maxWidth: 30.0),
//        decoration: BoxDecoration(
//          image: DecorationImage(
//            fit: BoxFit.cover,
//            alignment: FractionalOffset.center,
//            image: AssetImage("assets/images/progress_bg.png"),
////            fit: BoxFit.cover,
//          ),
//        ),
        child: Text(
          '$progress%',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: hexToColor('#3D3D74'),
            fontSize: 11.0,
          ),
        ),
      ),
    );
  }
}
