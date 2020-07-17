import 'package:flutter/material.dart';

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
            BoxDecoration(shape: BoxShape.circle, color: color, boxShadow: [
          BoxShadow(
            offset: Offset(2, 2),
            color: Colors.grey,
            blurRadius: 10,
            spreadRadius: 3,
          ),
          BoxShadow(
            offset: Offset(-4, -4),
            color: Colors.white,
            blurRadius: 10,
            spreadRadius: 5,
          )
        ]),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[200],
                      offset: Offset(-2, -2),
                      blurRadius: 2,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.grey[200],
                      offset: Offset(2, 2),
                      blurRadius: 2,
                      spreadRadius: 1,
                    ),
                  ],
                  gradient: LinearGradient(colors: [
                    color,
                    color2,
                  ])),
              child: icon),
        ),
      ),
    );
  }
}
