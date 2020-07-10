import 'package:flutter/material.dart';
import 'package:music_app/models/music_model.dart';

import 'package:music_app/utils/constants.dart';
import 'package:music_app/widgets/music_card.dart';
import 'package:music_app/widgets/smallRoundBox.dart';

class MusicHome extends StatefulWidget {
  @override
  _MusicHomeState createState() => _MusicHomeState();
}

class _MusicHomeState extends State<MusicHome> {
  String albumTitle = 'FLUME';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgrounColor,
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            _albumTitle(),
            _centerCircle(),
            _musicList(),
          ],
        ),
      )),
    );
  }

  _albumTitle() {
    return Column(
      children: <Widget>[
        SizedBox(height: 15,),
        Text(
            'SKIN - $albumTitle',
            style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
            ),
          ),
           SizedBox(height: 15,),
      ],
    );
  }

  _centerCircle() {
    return Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SmallRoundBox(icon: Icon(Icons.favorite, color: Color(0xFF8D9AAF))),
          CenterCircle(height: 150, width: 150),
          SmallRoundBox(icon: Icon(Icons.list, color: Color(0xFF8D9AAF)))
        ],
      ),
    );
  }

  _musicList() {
    return Expanded(
      flex: 2,
      child: Container(
      child: ListView.builder(
        itemCount: musicList.length,
        
        itemBuilder: (context,index) => MusicCard())
            ));
          }
        }
        
       
class CenterCircle extends StatelessWidget {
  final double height;
  final double width;
  const CenterCircle({
    Key key,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kBackgrounColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(4, 4),
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
          ]),
      child: Container(),
    );
  }
}
