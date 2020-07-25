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
  final int index;

  const Nowplaying({Key key, this.song, this.index}) : super(key: key);
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

  StreamSubscription<AudioPlayerState> _audioPlayerStateSubscription;
  StreamSubscription<Duration> _positionSubscription;
  String songIDuration;
  /*  String currentTime = '0:00';
  String completeTime = '0:00'; */

  Duration currentTime = Duration();
  Duration completeTime = Duration();

  int currentIndexOfMusic = 0;

  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<SongInfo> music = [];

  Future<void> getSongsList() async {

    List<SongInfo> songs = await audioQuery.getSongs();

    // return songs;

   songs.forEach((song) {
       music.add(song);
    });

    setState(() {
      currentIndexOfMusic = widget.index;
    });


    initPlayer();

    return songs;
  }

  @override
  void initState() {

    getSongsList();




  // initPlayer();

    super.initState();
  }

  void initPlayer() {
     

     

    audioPlugin = AudioPlayer();
    audioPlugin.play(widget.song.filePath);
    isPlaying = true;

    _positionSubscription = audioPlugin.onAudioPositionChanged.listen((event) {
      setState(() {
        currentTime = event;
        sliderValue = currentTime.inSeconds.toDouble();
      });
    });

    _audioPlayerStateSubscription =
        audioPlugin.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING) {
        setState(() {
          completeTime = audioPlugin.duration;
        });
      } else if (s == AudioPlayerState.COMPLETED) {
        print('complete state');

        /* setState(() {
          onComplete();
        }); */

      } else if (s == AudioPlayerState.STOPPED) {
        print('stop state');

        setState(() {
          currentTime = completeTime;
        });
      }
    });
  }

  void play() async{
    await getSongsList();
    initPlayer();
  }

  @override
  void dispose() {
    
    _audioPlayerStateSubscription.cancel();
    _positionSubscription.cancel();

    super.dispose();
  }

  void seekToSecond(int second) {
    audioPlugin = AudioPlayer();
    //convert the sliders value to duration
    Duration newDuration = Duration(seconds: second);
    audioPlugin.seek(newDuration.inSeconds.toDouble());

    _positionSubscription = audioPlugin.onAudioPositionChanged.listen((event) {
      setState(() {
        currentTime = event;
        sliderValue = currentTime.inSeconds.toDouble();
      });
    });

    setState(() {
      Duration newDuration = Duration(seconds: sliderValue.toInt());
      currentTime = newDuration;
      sliderValue = currentTime.inSeconds.toDouble();
    });
    // to keep the slider moving after the slider is move to a new position
    audioPlugin.play(music[currentIndexOfMusic].filePath);
  }

  void onComplete() {
    if (currentIndexOfMusic < music.length) {
      audioPlugin.stop();
      setState(() {
        currentIndexOfMusic++;
        audioPlugin.play(music[currentIndexOfMusic].filePath);
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgrounColor,
      body:      
              SafeArea(
          child:  Column(
                  children: <Widget>[
                    _customAppber(),
                    CustomCenterCircle(
                        songInfo: music[currentIndexOfMusic].albumArtwork),
                    _musicTitle( ),
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
            onPressed: () {
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

  Widget _musicTitle({SongInfo song}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 25),
        child: Column(
          children: <Widget>[
            Flexible(
              child: Text(
                music[currentIndexOfMusic].title,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8D9AAF),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              music[currentIndexOfMusic].artist,
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
                children: <Widget>[
                  Text('${currentTime.toString().split(".")[0]}'),
                  Text('${completeTime.toString().split(".")[0]}')
                ],
              ),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: kPauseColor,
                //thumbShape: RoundSliderThumbShape(),
                //trackShape: RoundSliderTrackShape()
              ),
              child: Slider(
                  value: sliderValue,
                  min: 0.0,
                  max: completeTime.inSeconds.toDouble(),
                  onChanged: (double newValue) {
                    setState(() {
                      seekToSecond(newValue.toInt());
                      //sliderValue = currentTime.inSeconds.toDouble();

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
              icon: Icon(
                Icons.fast_rewind,
                color: Color(0xFF8D9AAF),
              ),
              onPressed: () {
                audioPlugin.stop();
                if (currentIndexOfMusic <= 0) {
                  return;
                } else {
                  setState(() {
                    currentIndexOfMusic--;
                    audioPlugin.play(music[currentIndexOfMusic].filePath);
                    isPlaying = true;
                  });
                }
              }),
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
            icon: Icon(Icons.fast_forward, color: Color(0xFF8D9AAF)),
            onPressed: () {
              audioPlugin.stop();
              if (currentIndexOfMusic >= music.length - 1) {
                return;
              } else {
                setState(() {
                  currentIndexOfMusic++;
                  audioPlugin.play(music[currentIndexOfMusic].filePath);
                  isPlaying = true;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
