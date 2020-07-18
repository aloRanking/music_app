import 'dart:async';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_app/screen/music_home.dart';
import 'package:music_app/utils/constants.dart';
import 'package:music_app/utils/rounded_tracker.dart';
import 'package:music_app/widgets/center_circle.dart';
import 'package:music_app/widgets/media_player_button.dart';
import 'package:music_app/widgets/smallRoundBox.dart';

class Nowplaying extends StatefulWidget {
  final SongInfo song;

  const Nowplaying({Key key, this.song}) : super(key: key);
  @override
  _NowplayingState createState() => _NowplayingState();
}

class _NowplayingState extends State<Nowplaying> with TickerProviderStateMixin {
  double sliderValue = 0.0;

  Duration musicStopDuration = Duration();
  Duration musicStartDuration = Duration();

  AnimationController controller;
  bool isPlaying = false;
  AudioPlayer audioPlugin;
  String songIDuration;
 /*  String currentTime = '0:00';
  String completeTime = '0:00'; */

  Duration currentTime =Duration();
   Duration completeTime =Duration();

  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  String songDuration;

  @override
  void initState() {
    initPlayer();

    

    super.initState();
  }

  void initPlayer() {
    /* String songDuration = widget.song.duration;
    musicStopDuration = parseDuration(songDuration);

 */

  audioPlugin = AudioPlayer();
    audioPlugin.play(widget.song.filePath);
    /* songIDuration = widget.song.duration;
    print(widget.song);
    print(widget.song.duration);
 */
    isPlaying = true;

  
  
    
    audioPlugin.onAudioPositionChanged.listen((event) {
      setState(() {
        // musicStartDuration = audioPlugin.duration;
        currentTime = event;
      });
    });

    audioPlugin.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING ) {   

        setState(() {
          completeTime = audioPlugin.duration;
         
        });
        
      } else if (s == AudioPlayerState.STOPPED) {
        // onComplete();
        setState(() {
          currentTime = completeTime;
        });
      }
    });
  }

  void seekToSecond(int second) {
    audioPlugin = AudioPlayer();
    Duration newDuration = Duration(seconds: second);

    audioPlugin.seek(newDuration.inSeconds.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgrounColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _customAppber(),
            CustomCenterCircle(songInfo: widget.song.albumArtwork ),
            _musicTitle(),
            _slider(),
            _musicButtons(),
          ],
        ),
      ),
    );
  }

  Widget _customAppber() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SmallRoundBox(
            icon: Icon(Icons.arrow_back, color: Color(0xFF8D9AAF)),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          Text('PLAYING NOW', style: TextStyle(color: Colors.grey)),
          SmallRoundBox(
            icon: Icon(Icons.menu, color: Color(0xFF8D9AAF)),
          ),
        ],
      ),
    );
  }

  

  Widget _musicTitle() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 25),
        child: Column(
          children: <Widget>[
            Text(
              widget.song.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8D9AAF),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.song.artist,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF8D9AAF),
              ),
            )
          ],
        ),
      ),
    );
  }

  _slider() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('${currentTime.toString().split(".")[0]}'), Text('${completeTime.toString().split(".")[0]}')],
              ),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: kPauseColor,
                //thumbShape: RoundSliderThumbShape(),
                //trackShape: RoundSliderTrackShape()
              ),
              child: Slider(
                  value: currentTime.inSeconds.toDouble(),
                  min: 0.0,
                  max: completeTime.inSeconds.toDouble(),
                  onChanged: (double newValue) {
                    setState(() {
                      //seekToSecond(newValue.toInt());
                     sliderValue= currentTime.inSeconds.toDouble();
                     sliderValue = newValue;
                    });
                    
                  }),
            ),
          ],
        ),
      ),
    );
  }

  _musicButtons() {
    return Expanded(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          MediaPlayButton(
            color: kBackgrounColor,
            color2: Color(0xFFE2ECFB),
            icon: Icon(Icons.fast_rewind, color: Color(0xFF8D9AAF)),
          ),
          MediaPlayButton(
            color: kPauseColor,
            color2: kPauseColor,
            icon: isPlaying
                ? Icon(
                    Icons.pause,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
            onPressed: () {
              if (isPlaying) {
                audioPlugin.pause();
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
          ),
          MediaPlayButton(
              color: kBackgrounColor,
              color2: Color(0xFFE2ECFB),
              icon: Icon(Icons.fast_forward, color: Color(0xFF8D9AAF))),
        ],
      ),
    );
  }
}

