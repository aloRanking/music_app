import 'package:flutter/material.dart';
import 'package:music_app/utils/constants.dart';

class MediaPlayButton extends StatelessWidget {
  final Icon icon;
  final Color color;
  final Color color2;
  final Function onPressed;

  MediaPlayButton({this.icon, this.color, this.color2, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 100,
        width: 100,
        decoration:
            BoxDecoration(
              shape: BoxShape.circle, 
              color: color,
              border: Border.all(
                width: 2,
                color: kBackgrounColor
              ),
              
              
              boxShadow: [
          BoxShadow(
            offset: Offset(2, 2),
            color: Color(0xFFB8C6DD),
            blurRadius: 10,
            spreadRadius: 5,
          ),
          BoxShadow(
            offset: Offset(-4, -4),
            color: Color(0xFFF2FCFF),
            blurRadius: 10,
            spreadRadius: 3,
          )
        ],
        gradient: RadialGradient(colors: 
        [
          color, color,
          

        ])),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          
              child: icon),
        
      ),
    );
  }
}
