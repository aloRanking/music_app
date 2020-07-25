import 'package:flutter/cupertino.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class InheritedMusicList extends InheritedWidget{
  final List<SongInfo> data;



  InheritedMusicList({Widget child,this.data});


  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    throw UnimplementedError();
  }

  static InheritedMusicList of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: InheritedMusicList);

}