import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import 'package:music_app/screen/music_home.dart';
import 'package:music_app/screen/now_playing.dart';
import 'package:music_app/utils/constants.dart';
import 'package:music_app/widgets/smallRoundBox.dart';

class MusicCard extends StatefulWidget {
  final SongInfo song;
  const MusicCard({
    Key key,
    this.song,
  }) : super(key: key);

  @override
  _MusicCardState createState() => _MusicCardState();
}

class _MusicCardState extends State<MusicCard> {
  bool isPlaying = false;
   AudioPlayer audioPlugin = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
              return Nowplaying(song:widget.song);
          }));
        },
              child: Container(
          margin: EdgeInsets.only(top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                            child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.song.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      color: kGreyColor,
                    ),),
                    Text(widget.song.artist,
                     style: TextStyle(
                      fontSize: 16,
                      color: kGreyColor,
                    ),),
                  ],
                ),
              ),
              SmallRoundBox(
                 
                icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow,
                    color: Color(0xFF8D9AAF)),
                    onPressed: (){
                      print('the current filepath ${widget.song.filePath}');
                      if (isPlaying) {
                         audioPlugin.stop();
                        setState(() {                        
                          isPlaying = false;                   

                        });
                        
                      } else {
                         audioPlugin.play(widget.song.filePath);
                        setState(() {
                           isPlaying = true;
                        });
                       
                        
                        
                      }
                    },
                   
              )
            ],
          ),
        ),
      ),
    );
  }
}
