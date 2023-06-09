import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/Music.dart';
import 'package:music_app/pallette_color.dart';
import 'package:flutter/material.dart';
import 'package:music_app/metier_methods.dart';
class MusicPage extends StatefulWidget{
  const MusicPage({
    super.key,
    required this.audioList,
    required this.audioMetadata,
    required this.index
  });
   final List<File> audioList;
   final List<Metadata> audioMetadata;
   final int index;
  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  AudioPlayer audioPlayer=AudioPlayer();
  Duration position=Duration.zero;
  Duration duration=Duration.zero;
  PlayerState playerState=PlayerState.stopped;
  late Music currentMusic;
  bool repeatMusic=false;
  late int index;
  @override
  void initState(){
    super.initState();
    index=widget.index;
    currentMusic = Music(
        titre:widget.audioMetadata[index].trackName,
        artiste: widget.audioMetadata[index].trackArtistNames?.join(' '),
        path: widget.audioMetadata[index].filePath,
        cover:widget.audioMetadata[index].albumArt
    );
    initAudioPlayer();
  }
  initAudioPlayer(){
    audioPlayer.onPositionChanged.listen((newPosition) => setState(() =>position=newPosition));
    audioPlayer.onDurationChanged.listen((newDuration) => setState(()=>duration=newDuration));
    audioPlayer.onPlayerStateChanged.listen((newState) => setState(()=>playerState=newState));
    audioPlayer.onPlayerComplete.listen((event) =>setState(() {
      position=duration;
    }));

  }
  @override
  Widget build(BuildContext context){
    ImageProvider imageProvider;
    if(currentMusic.cover==null){
      imageProvider=const AssetImage("images/img-4.jpg");
    }else{
      imageProvider=MemoryImage(currentMusic.cover!);
    }
    return Scaffold(
      appBar:AppBar() ,
      body: Center(
        child:Padding(
          padding:const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
              Container(
                width: MediaQuery.of(context).size.width/1,
                height: MediaQuery.of(context).size.height/2.0,
                margin:const EdgeInsets.only(left: 10.0,right: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image:  DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.repeat,color: Colors.grey[900],),
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:<Widget> [
                  timeCode("00:00:00"),
                  timeCode("00:00:00")
                ],
              ),
              Slider(
                  activeColor:appBarColor ,
                  inactiveColor: Colors.white,
                  value: 0,
                  onChanged: (value){
                  }
              ),
              Padding(
                padding:const EdgeInsets.symmetric(
                 horizontal: 23,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    circleWithAvatar(
                        Icons.skip_previous_rounded ,Colors.transparent,onPrevious
                    ),
                    circleWithAvatar(
                        Icons.play_arrow_rounded ,appBarColor,onPrevious
                    ),
                    circleWithAvatar(
                        Icons.skip_next_rounded ,Colors.transparent,onPrevious
                    ),
                  ],
                ),
              )
            ]
          ),
        ),
      ) ,
      backgroundColor: bodyColor,
    );
  }
}
Text timeCode(String data){
  return Text(data,
    style: GoogleFonts.lato(
      textStyle: const TextStyle(
        color: whiteFont,
        fontSize: 17.0,
      ),
    ),
  );
}
CircleAvatar circleWithAvatar(IconData  icone,Color color,VoidCallback action) {
  return CircleAvatar(
      backgroundColor: color,
      radius: 30,
      child: IconButton(
        icon: Icon(icone ),
        color: Colors.grey[200],
        onPressed: action,
      ),

  );
}

