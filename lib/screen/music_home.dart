import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
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

  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
    List<SongInfo> music = [];

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
            _buildBottomGradient()
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
    return Expanded(
      flex: 2,
      child: Container(
      child: ListView.builder(
        itemCount: music.length,
        physics: BouncingScrollPhysics(),
        
        itemBuilder: (context,index) { 
          print(music.length);
        return MusicCard(song: music[index],);
          })
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
