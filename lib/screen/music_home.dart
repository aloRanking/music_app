import 'package:flutter/material.dart';
import 'package:music_app/utils/constants.dart';

class MusicHome extends StatefulWidget {
  @override
  _MusicHomeState createState() => _MusicHomeState();
}

class _MusicHomeState extends State<MusicHome> {

  double sliderValue = 50;


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
                                  SmallRoundBox(),
                                  Text('Playing Now', style: TextStyle(color: Colors.grey)),
                                  SmallRoundBox(),
                                ],
                              ),
                            );
                          }
                        
                          Widget _centerCircle() {
                            return Expanded(
                              flex: 2,
                                                          child: Container(
                                height: 250,
                                width: 250,
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
                                        spreadRadius: 5,
                                      ),
                                    ]),
                                child: Container(),
                              ),
                            );
                          }
                        
                        Widget  _musicTitle() {
                
                          return Expanded(
                                                      child: Container(
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
                            ),
                          );
                        }
                
                  _slider() {
                    return Expanded(
                                          child: Container(
                        child: Column(
                          children: <Widget>[
        
                            Padding(
                              padding: const EdgeInsets.only(left:15.0, right:15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                Text('1:23'),
                                Text('3:21')
                              ],),
                            ),
        
        
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: kPauseColor,
                                thumbShape: RoundSliderThumbShape(),
                                


                              ),
                                                          child: Slider(
                                value: sliderValue,
                                min: 1.0,
                                max: 100.0,
                                 
                                onChanged: (double newValue){
                                  setState(() {
                                    newValue = sliderValue;
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

                  MusicButtons(color: kBackgrounColor, icon: Icon(Icons.fast_rewind),),
              MusicButtons(color: kPauseColor, icon: Icon(Icons.pause,color: Colors.white,), onPressed: (){

              },),
              MusicButtons(color: kBackgrounColor, icon: Icon(Icons.fast_forward)),


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
                ],
                
                
                ),
            child: Icon(Icons.arrow_back)),
      ),
    );
  }
}

class MusicButtons extends StatelessWidget {
 
 final Icon icon;
 final Color color;
 final Function onPressed;
 

 MusicButtons({this.icon, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
          child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
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
          padding: const EdgeInsets.all(6.0),
          child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                  boxShadow: [
                    BoxShadow(
                      color:Colors.grey[200] ,
                      offset: Offset(-2, -2),
                      blurRadius: 2,
                      spreadRadius: 1,
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [
                      color,
                      color,
                     
                    ])
                  
                  ),
              child: icon ),
        ),
      ),
    );
  }
}
