import 'package:flutter/material.dart';
import 'package:music_app/utils/constants.dart';

class SmallRoundBox extends StatelessWidget {
  final Icon icon;
  final Function onPressed;
  SmallRoundBox({this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kBackgrounColor,
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
          ]),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kBackgrounColor,
             /*  boxShadow: [
                BoxShadow(
                  color: Color(0xFFF2FCFF),
                  blurRadius: 12,
                 // spreadRadius: 1,
                ),
              ], */
            ),
            child: IconButton(onPressed: onPressed,
            icon: icon,)),
      ),
    );
  }
}

