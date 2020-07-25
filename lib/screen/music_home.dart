import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_app/models/music_model.dart';
import 'package:music_app/utils/InheritedMusicList.dart';

import 'package:music_app/utils/constants.dart';
import 'package:music_app/widgets/center_circle.dart';
import 'package:music_app/widgets/music_card.dart';
import 'package:music_app/widgets/smallRoundBox.dart';

class MusicHome extends StatefulWidget {
  @override
  _MusicHomeState createState() => _MusicHomeState();
}

class _MusicHomeState extends State<MusicHome> {
  String albumTitle = 'FLUME';

  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
    List<SongInfo> music = [];

    bool isPlaying = false;

 Future<void> getSongsList() async{

    //List<AlbumInfo> albumList = await audioQuery.getAlbums();
    List<SongInfo> songs = await audioQuery.getSongs();

   // return songs;

   songs.forEach((song) {
     music.add(song);
   });

  
  }

  void songList() async{
    await getSongsList();
    print(music.length);
    setState(() {
      
    });



  }

  @override
  void initState() {
       songList(); 
    super.initState();
     

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgrounColor,
      body: SafeArea(
              child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                _albumTitle(),
                _centerCircle(),


        _musicList(),




              ],
            ),
            _buildBottomGradient(),
            //_buildNowPlaying(),
          ],
        ),
      ),
    );
  }

  Align _buildBottomGradient() {
    return Align(
            alignment: Alignment.bottomCenter,
            
                      child: Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  kBackgrounColor.withAlpha(0), kBackgrounColor
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
                
                )
              ),
            ),
          );
  }

  _albumTitle() {
    return Column(
      children: <Widget>[
        SizedBox(height: 15,),
        Text(
            'SKIN ',
            style: TextStyle(
              color: kGreyColor,
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

   //final data = InheritedMusicList.of(context);
    return Expanded(
      flex: 2,
      child: Container(
      child: ListView.builder(
        itemCount: music.length,
        physics: BouncingScrollPhysics(),
        
        itemBuilder: (context,index) { 
          print(music.length);
        return MusicCard(song: music[index], index: index, );
          })
        ));
          }

 /* _buildNowPlaying(BuildContext context) {
    final data = InheritedMusicList.of(context).data;

    return Scaffold(
      backgroundColor: kBackgrounColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _customAppber(),
            CustomCenterCircle(songInfo: data.song.albumArtwork ),
            _musicTitle(),
            _slider(),
            _musicButtons(),
          ],
        ),
      ),
    );





  }*/

 /* Widget _customAppber() {
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
  }*/
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
          border: Border.all(
            width: 5,
            color: kBackgrounColor ),
          //color: kBackgrounColor,
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
          ],
          
          gradient: RadialGradient(colors: [
            kBackgrounColor,kBackgrounColor,kBackgrounColor, Colors.white54.withAlpha(0)
          ]),
      image: DecorationImage(image: AssetImage('images/rose.jpg'), fit: BoxFit.cover)
      ),

    );
  }
}
