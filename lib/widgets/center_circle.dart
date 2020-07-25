import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_app/utils/constants.dart';

class CustomCenterCircle extends StatelessWidget {

  final String songInfo;

  CustomCenterCircle({this.songInfo});

 
  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 2,
              color: kBackgrounColor,
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(7, 7),
                color: Color(0xFFB8C6DD),
                blurRadius: 15,
                spreadRadius: 10,
              ),
              BoxShadow(
                offset: Offset(-4, -4),
                color: Color(0xFFF2FCFF),
                blurRadius: 15,
                spreadRadius: 3,
              ),
            ],
            /* image: DecorationImage(
            
                  image: ExactAssetImage(songInfo), fit: BoxFit.cover )
             */);
           
            if (songInfo !=null) {
             
              boxDecoration = boxDecoration.copyWith(
                image: DecorationImage(
                  image: ExactAssetImage(songInfo), fit: BoxFit.cover)
              );
              
            }else{
              boxDecoration = boxDecoration.copyWith(
                color: kPauseColor
              );
            }
    return Expanded(
      flex: 3,
      child: Container(
        height: 300,
        width: 300,
        decoration: boxDecoration,
        
      
    ));
  }
}