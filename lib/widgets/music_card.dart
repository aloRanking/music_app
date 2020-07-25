import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import 'package:music_app/screen/music_home.dart';
import 'package:music_app/screen/now_playing.dart';
import 'package:music_app/utils/constants.dart';
import 'package:music_app/widgets/smallRoundBox.dart';

class MusicCard extends StatefulWidget {
  final SongInfo song;
  final int index;
  const MusicCard({
    Key key,
    this.song,
    this.index
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
      child: InkWell(
        onTap: () {
         /* setState(() {
            isPlaying = !isPlaying;
          });*/
          if (audioPlugin != null) {
            audioPlugin.stop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Nowplaying(song: widget.song, index: widget.index,);
          }));
            
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Nowplaying(song: widget.song, index: widget.index);
          }));
          }
          
        },
        child: Container(
          height: 80,
          margin: EdgeInsets.only(top: 4),
          padding: EdgeInsets.all(10),
          decoration: isPlaying
              ? BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: kActiveColor,
                )
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.song.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        color: kGreyColor,
                      ),
                    ),
                    Text(
                      widget.song.artist,
                      style: TextStyle(
                        fontSize: 16,
                        color: kGreyColor,
                      ),
                    ),
                  ],
                ),
              ),
              SmallRoundBox(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                    color: isPlaying? Colors.white : Color(0xFF8D9AAF)),
                    isActive: isPlaying,
                onPressed: () {

                 /* if (isPlaying) {
                    audioPlugin.pause();
                    setState(() {
                      isPlaying = false;
                    });
                    
                  } else {
                    //audioPlugin.stop();
                    audioPlugin.play(widget.song.filePath);
                    setState(() {
                      isPlaying = true;
                    });

                  }*/

                  

                 /*  audioPlugin.play(widget.song.filePath);

                  audioPlugin.onPlayerStateChanged.listen((event) {
                    if(event == AudioPlayerState.PLAYING){

                      
                      print('playinnng');
                    


                    }else if (event == AudioPlayerState.PAUSED) {

                      setState(() {
                      isPlaying = false;
                    });
                      
                    }
                  });

 */


                  //print('the current filepath ${widget.song.filePath}');
                   /*  if (audioPlugin.state ==  AudioPlayerState.STOPPED) {
                    audioPlugin.play(widget.song.filePath);
                    
                    print('Stopp state');
                    print('the playing state ${audioPlugin.state}');
                      setState(() {
                        
                      isPlaying = true;
                    });
                    
                  }else if (audioPlugin.state ==  AudioPlayerState.PLAYING) {
                     audioPlugin.pause();
                      setState(() {
                      isPlaying = true;
                    });
                  }  else {
                    audioPlugin.play(widget.song.filePath);
                     print('playing state');
                    setState(() {
                      isPlaying = false;
                    });
                  }  */
                   

                   
                  
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
