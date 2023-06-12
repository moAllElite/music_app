import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
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
  AudioPlayer audioPlayer = AudioPlayer();
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  PlayerState playerState = PlayerState.stopped;
  late Music currentMusic;
  bool repeatMusic = false;
  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.index;
    currentMusic = Music(
        widget.audioMetadata[index].trackName,
        widget.audioMetadata[index].trackArtistNames?.join(' '),
        widget.audioMetadata[index].filePath,
        widget.audioMetadata[index].albumArt
    );
    initAudioPlayer();
  }

  initAudioPlayer() {
    audioPlayer.onPositionChanged.listen((newPosition) =>
        setState(() => position = newPosition));
    audioPlayer.onDurationChanged.listen((newDuration) =>
        setState(() => duration = newDuration));
    audioPlayer.onPlayerStateChanged.listen((newState) =>
        setState(() {
          playerState = newState;
        })
    );
    audioPlayer.onPlayerComplete.listen((event) =>
        setState(() {
          position = duration;
        }));
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;
    if (currentMusic.cover == null) {
      imageProvider = const AssetImage("images/img-4.jpg");
    } else {
      imageProvider = MemoryImage(currentMusic.cover!);
    }
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 1,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 2.0,
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: textWithStyle(currentMusic.titre != null ?
                  currentMusic.path!
                      .split("/").last
                      .split("/")
                      .first :
                  "Inconnue"
                      , 1.2
                  ),
                ),
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: textWithStyle(
                      currentMusic.artiste ?? "Inconnue",
                      1
                  ),
                ),
                iconButton (Icons.repeat,
                  repeatMusic?lowBrown:Colors.grey[900]!,
                   () {
                     setState(() {
                       repeatMusic=!repeatMusic;
                     });
                   }
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    timeStamp(formatDuration(position)),
                    timeStamp(formatDuration(duration)),
                  ],
                ),
                Slider(
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                    activeColor: appBarColor,
                    inactiveColor: Colors.white,
                    value: position.inSeconds.toDouble(),
                    onChanged: (value) async {
                      setState(() {
                        position = Duration(seconds: value.toInt());
                      });
                      await audioPlayer.seek(position);

                    }
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 23,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      circleWithAvatar(
                          Icons.skip_previous_rounded,
                          Colors.transparent,
                          () async =>previousMusic()
                      ),
                      circleWithAvatar(
                          (playerState == PlayerState.playing)?
                           Icons.play_arrow:Icons.pause_circle, 
                          removerColor,
                          changeAudioPlayerState
                        ),
                      circleWithAvatar(
                          Icons.skip_next_rounded,
                          Colors.transparent, 
                          () async => nextMusic()
                      ),
                    ],
                  ),
                )
              ]
          ),
        ),
      ),
      backgroundColor: bodyColor,
    );
  }
  void changeMusic(){
    setState(() {
      currentMusic = Music(
          widget.audioMetadata[index].trackName,
          widget.audioMetadata[index].trackArtistNames?.join(' '),
          widget.audioMetadata[index].filePath,
          widget.audioMetadata[index].albumArt
      );
    });
  }
  void changeAudioPlayerState(){
    if(playerState==PlayerState.playing){
      setState(() {
        audioPlayer.stop();
      });
    }else if(playerState == PlayerState.paused){
      audioPlayer.resume();
    }else if(playerState == PlayerState.stopped){
      audioPlayer.play(DeviceFileSource(currentMusic.path??""));
    }
  }
  void nextMusic(){
    setState(() {
      audioPlayer.stop().then((value) {
        setState(() {
          position = Duration.zero;
          if (!repeatMusic) {
            if (index < widget.audioMetadata.length - 1) {
              setState(() {
                index++;
              });
            } else {
              setState(() {
                index = 0;
              });
            }
            changeMusic();
          }
        });
        setState(() {
          audioPlayer.play(DeviceFileSource(currentMusic.path?? ""));
        });
      });
    });
  }
  void previousMusic(){
    setState(() {
      audioPlayer.stop().then((value) {
        setState(() {
          position = Duration.zero;
          if (!repeatMusic) {
            if (index > 0) {
              setState(() {
                index--;
              });
            } else {
              setState(() {
                index = widget.audioList.length - 1;
              });
            }
            changeMusic();
          }
        });
        setState(() {
          audioPlayer.play(DeviceFileSource(currentMusic.path?? ""));
        });
      }
      );
    });

  }
  void backMusicList(){
    setState(() {
      audioPlayer.stop();
    });
    Navigator.pop(context);
  }
}
