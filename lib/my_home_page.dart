import 'dart:io';
import 'package:music_app/music_page.dart';
import 'package:music_app/pallette_color.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:google_fonts/google_fonts.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
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
        backgroundColor: appBarColor,
        title: const Text(
          'Apple Music',
          style: TextStyle(color: whiteFont,fontWeight: FontWeight.w600),
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
            icon:const Icon(Icons.add_circle_outline),color: whiteFont,)
        ],
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: audioList.length,
        itemBuilder: ((context,index){
          Metadata music=audioMetaData[index];
          return InkWell(
            onTap: (){
              Navigator.push(
                  context,
                MaterialPageRoute(builder: (context){
                  return  MusicPage(
                    audioList:audioList,
                    audioMetadata: audioMetaData,
                    index: index,
                  );
                })
              );
            },
            child: Dismissible
            (
              direction: DismissDirection.startToEnd,
              background: Container(
                color: removerColor,
                padding:const EdgeInsets.only(top: 10,left: 10,right: 10),
                child:const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     Icon(Icons.delete,color: Colors.white,)
                  ],
                ),
              ),
              onDismissed: (direction){
                setState(() => audioList.removeAt(index));
                setState(() =>audioMetaData.removeAt(index));
                setState(() {});
                },
              behavior: HitTestBehavior.translucent,
              key: UniqueKey(),
              child:  Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 10.0,bottom: 10.0,left: 20.0),
                    height: 80,
                    width: 86,
                    clipBehavior: Clip.hardEdge,
                    decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:music.albumArt==null?
                    Image.asset(
                      "images/cover.png",
                      fit: BoxFit.cover,
                    ):
                    Image.memory(
                        music.albumArt!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding:const EdgeInsets.only(left: 10.0,top: 7.0),
                    child: Column(
                      children:[
                        textWithStyle(
                            music.trackName != null?
                              music.filePath!.split("/").last: "inconnue".toUpperCase(),
                            1.0
                        ) ,
                        textWithStyle(
                            music.trackArtistNames!=null?
                            music.trackArtistNames!.join(" "): "inconnue".toUpperCase()
                            , 0.9
                        ),
                      ]
                  ),
                )
              ],
              ),
            ),
          );
        }),
      ),
      backgroundColor: bodyColor,
    );
  }

  Text textWithStyle(String data,double scale ){
    return Text(
      data,
      textScaleFactor: scale,
      textAlign: TextAlign.left,
      style:GoogleFonts.lato(
        textStyle:const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontStyle: FontStyle.italic
        ),
      ),
    );
  }
}