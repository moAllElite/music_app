
import 'package:flutter/material.dart';
import 'package:music_app/musique.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apple Music',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Apple Music'),
      debugShowCheckedModeBanner: false,
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double position=0.0;
  List<Musique> listMusic=[
    Musique("Princess Diana", "Aminata Barry Niang ", "images/img-1.jpg","https://cdn.pixabay.com/audio/2022/09/23/audio_533935ce4d.mp3"),
    Musique("I luv", "Tory Lanez", "images/img-2.jpeg","https://cdn.pixabay.com/audio/2022/09/18/audio_c96383087c.mp3")

  ];
  late Musique actualMusic;
  @override
  void initState(){
    super.initState();
    actualMusic=listMusic[0];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title:const Text(
            'Apple Music',
            style: TextStyle(color:Colors.white)
        ),
        centerTitle: true,
      ),
      body: Center (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:<Widget>[
            Card(
              margin:const EdgeInsets.only(left: 50.0,right: 50.0,),
              elevation: 20.0,
              child: Image.asset(
                actualMusic.imagePath,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height/2.5,
              ),
            ),
              textWithStyle(actualMusic.title, 1.5),
              textWithStyle(actualMusic.artist, 1.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                button(Icons.skip_previous, 30.0, ActionMusic.rewind),
                button(Icons.play_arrow, 45.0, ActionMusic.pause),
                button(Icons.skip_next, 30.0, ActionMusic.forward)

              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  textWithStyle('0:0', 0.8),
                  textWithStyle('3:0', 0.8),
                ],
              ),
            Slider(
                value: position,
                min: 0.0,
                max: 30.0,
                inactiveColor: Colors.white,
                activeColor: Colors.red,
                onChanged: (double duration){
                  setState(() {
                    position=duration;
                  });
                }
            )
            ],
        ),
      ),
      backgroundColor: Colors.grey[800],
    );
  }
  Text textWithStyle(String data,double scale ){
    return Text(
        data,
      textScaleFactor: scale,
      textAlign: TextAlign.center,
      style:const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontStyle: FontStyle.italic
      ),
    );
  }
  IconButton button(IconData icone,double  size,ActionMusic actionMusic){
    return IconButton(
        iconSize: size,
        color: Colors.white,
        onPressed: (){
            switch(actionMusic){
            case ActionMusic.play:
            print('Play');break;
            case ActionMusic.pause:
            print('Pause');break;
            case ActionMusic.rewind:
            print('rewind');break;
            case ActionMusic.forward:
            print('forward');break;
            }
        },
        icon:Icon(icone)
    );

  }

}

bool onPlay=false;
void previousTrack(){
  if(onPlay=!false){
    onPlay = true;
    Icons.play_arrow;
  }else{
    Icons.pause;
    onPlay=false;
  }
}
enum  ActionMusic{
  play,
  pause,
  rewind,
  forward,
}