import 'package:flutter/material.dart';
import 'package:music_app/utils/constants.dart';

class MusicHome extends StatefulWidget {
  @override
  _MusicHomeState createState() => _MusicHomeState();
}

class _MusicHomeState extends State<MusicHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgrounColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            _customAppber(),
            _centerCircle(),
        _musicTitle(),
                  ],
                ),
              ),
            );
          }
        
          Widget _customAppber() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SmallRoundBox(),
                Text('Playing Now', style: TextStyle(color: Colors.grey)),
                SmallRoundBox(),
              ],
            );
          }
        
          Widget _centerCircle() {
            return Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kBackgrounColor,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(4, 4),
                      color: Colors.grey,
                      blurRadius: 15,
                      spreadRadius: 10,
                    ),
                    BoxShadow(
                      offset: Offset(-4, -4),
                      color: Colors.white,
                      blurRadius: 15,
                      spreadRadius: 10,
                    ),
                  ]),
              child: Container(),
            );
          }
        
        Widget  _musicTitle() {

          return Container(
           margin: EdgeInsets.only(top:25),            
            child: Column(
              children: <Widget>[

                Text('A Good Thing',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF8D9AAF),
                ),),
                SizedBox(height: 10,),

                Text('Asa ft, Brymo',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF8D9AAF),
                ),)

              ],
            ),
          );
        }
}

class SmallRoundBox extends StatelessWidget {
  const SmallRoundBox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kBackgrounColor,
          boxShadow: [
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
        padding: const EdgeInsets.all(4.0),
        child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kBackgrounColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 2,
                    spreadRadius: 1,
                  ),
                ]),
            child: Icon(Icons.arrow_back)),
      ),
    );
  }
}
