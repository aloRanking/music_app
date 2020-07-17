import 'package:flutter/material.dart';
import 'package:music_app/utils/constants.dart';

class SmallRoundBox extends StatelessWidget {
  final Icon icon;
  final Function onPressed;
  final bool isActive;
  SmallRoundBox({this.icon, this.onPressed, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    var Boxdecoration = BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: isActive ? kDarkBlue : kBackgrounColor,
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(4, 4),
            color: Color(0xFFB6C4DB),
            blurRadius: 10,
            spreadRadius: 5,
          ),
          BoxShadow(
            offset: Offset(-5, -5),
            color: Color(0xFFF2FCFF),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
        gradient: RadialGradient(
          colors: [
            kBackgrounColor,
            kBackgrounColor,
            kBackgrounColor,
            Colors.white.withAlpha(0)
          ],
        ));

    if (isActive) {
      Boxdecoration.copyWith(
          gradient: RadialGradient(colors: [kLightBlue, kDarkBlue]));
    } else {
      Boxdecoration.copyWith(
          gradient: RadialGradient(
        colors: [
          kBackgrounColor,
          kBackgrounColor,
          kBackgrounColor,
          Colors.white.withAlpha(0)
        ],
      ));
    }
    return Container(
      height: 50,
      width: 50,
      decoration: Boxdecoration,
      child: FlatButton(
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(200))),
        onPressed: onPressed,
        child: icon,
      ),
    );
  }
}
