import 'dart:async';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_app/utils/constants.dart';
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
    String songDuration = widget.song.duration;
    musicStopDuration = parseDuration(songDuration);

    audioPlugin = AudioPlayer();
    //audioPlugin.play(widget.song.filePath);
    //print(widget.song);
    audioPlugin.onAudioPositionChanged.listen((event) {
      setState(() {
        // musicStartDuration = audioPlugin.duration;
        currentTime = event;
      });
    });

    audioPlugin.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING) {
        setState(() {
          completeTime = audioPlugin.duration;
         // musicStopDuration = audioPlugin.duration;
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
            _centerCircle(),
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

  Widget _centerCircle() {
    return Expanded(
      flex: 3,
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kBackgrounColor,
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
            ]),
        child: Container(),
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
              'A Wish',
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
              'Asa ft, Brymo',
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
                thumbShape: RoundSliderThumbShape(),
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
          MusicButtons(
            color: kBackgrounColor,
            color2: Color(0xFFE2ECFB),
            icon: Icon(Icons.fast_rewind, color: Color(0xFF8D9AAF)),
          ),
          MusicButtons(
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
          MusicButtons(
              color: kBackgrounColor,
              color2: Color(0xFFE2ECFB),
              icon: Icon(Icons.fast_forward, color: Color(0xFF8D9AAF))),
        ],
      ),
    );
  }
}

class MusicButtons extends StatelessWidget {
  final Icon icon;
  final Color color;
  final Color color2;
  final Function onPressed;

  MusicButtons({this.icon, this.color, this.color2, this.onPressed});

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
