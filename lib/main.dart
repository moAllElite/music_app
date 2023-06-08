import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

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
  const MyHomePage({super.key, required this.title,});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<File> audioList=[];
  List<Metadata> audioMetaData=[];
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: const Text(
            'Apple Music',
            style: TextStyle(color: Colors.white),
        ),
        actions:<Widget> [
            IconButton(
                onPressed: (() async {
                  FilePickerResult? result=
                    await FilePicker.platform.pickFiles(type: FileType.audio);
                  String? audioPath= result ?.paths.first;
                  if(null != audioPath){
                   File file = File(audioPath);
                   MetadataRetriever.fromFile(file).
                    then((metadata){
                      bool isInAudioList=false;
                      for(var f in audioList){
                        if(f.path==file.path){
                          isInAudioList=true;
                        }
                      }
                      if(!isInAudioList) {
                        setState(() =>audioList.add(file));
                        setState(() => audioMetaData.add(metadata));
                      }

                    // ignore: invalid_return_type_for_catch_error
                    }).catchError((er)=>print("erreur lors de l'extraction des métadonnées"));
                  }
                }),
                icon:const Icon(Icons.add_circle_outline),color: Colors.white,)
        ],
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: 10,
          itemBuilder: ((context,index){
              return  Row(
                children: <Widget>[
                  Container(
                    padding:const EdgeInsets.only(bottom: 10.0),
                    height: 80,
                    width: 86,
                    child: Image.asset(
                        "images/cover.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding:const EdgeInsets.only(left: 10.0),
                    child: Column(
                        children:[
                          textWithStyle(
                          'Nom de la music',
                          1.0
                          ),
                          textWithStyle(
                              'nom de l\'artiste'
                              , 0.8
                          ),
                        ]
                    ),
                  )
                ],
              );
          }),
      ),
      backgroundColor: Colors.blueGrey,
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
}