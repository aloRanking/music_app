import 'package:flutter/material.dart';
import 'package:music_app/screen/music_home.dart';
import 'package:music_app/widgets/smallRoundBox.dart';

class MusicCard extends StatefulWidget {
  @override
  _MusicCardState createState() => _MusicCardState();
}

class _MusicCardState extends State<MusicCard> {

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.only(top: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(children: <Widget>[
              Text('Helix'),
              Text('Flume'),


            ],),

            SmallRoundBox(icon: Icon( isPlaying ? Icons.play_arrow : Icons.pause, color: Color(0xFF8D9AAF)) )
          ],
        ),
        
      ),
    );
  }
}