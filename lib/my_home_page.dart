import 'dart:io';
import 'package:music_app/music_page.dart';
import 'package:music_app/pallette_color.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'metier_methods.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<File> audioList = [];
  List<Metadata> audioMetaData = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Apple Music',
          style: TextStyle(color: purWhite, fontWeight: FontWeight.w600),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (() async {
              FilePickerResult? result =
                  await FilePicker.platform.pickFiles(type: FileType.audio);
              String? audioPath = result?.paths.first;
              if (null != audioPath) {
                File file = File(audioPath);
                MetadataRetriever.fromFile(file).then((metadata) {
                  bool isInAudioList = false;
                  for (var f in audioList) {
                    if (f.path == file.path) {
                      isInAudioList = true;
                    }
                  }
                  if (!isInAudioList) {
                    setState(() => audioList.add(file));
                    setState(() => audioMetaData.add(metadata));
                  }
                  // ignore: invalid_return_type_for_catch_error
                }).catchError((er) => er);
              }
            }),
            icon: const Icon(Icons.add_circle_outline),
            color: purWhite,
          )
        ],
        centerTitle: false,
      ),
      body: audioList.isNotEmpty? ListView.builder(
        itemCount: audioList.length,
        itemBuilder: ((context, index) {
          Metadata music = audioMetaData[index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MusicPage(
                  audioList: audioList,
                  audioMetadata: audioMetaData,
                  index: index,
                );
              }));
            },
            child: Dismissible(
              direction: DismissDirection.startToEnd,
              background: Container(
                color: darkBrown,
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              onDismissed: (direction) {
                setState(() => audioList.removeAt(index));
                setState(() => audioMetaData.removeAt(index));
                setState(() {});
              },
              behavior: HitTestBehavior.translucent,
              key: UniqueKey(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                        top: 15.0, bottom: 10.0, left: 15.0),
                    height: 80,
                    width: 86,
                    clipBehavior: Clip.hardEdge,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: music.albumArt == null
                        ? Image.asset(
                            "images/cover.png",
                            fit: BoxFit.cover,
                          )
                        : Image.memory(
                            music.albumArt!,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 12,
                      top: 22,
                    ),
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          h1(
                              music.trackName != null
                                  ? music.filePath!.split("/").last
                                  : "inconnue".toUpperCase(),
                              FontWeight.w800,
                              1),
                          h2(
                              music.trackArtistNames != null
                                  ? music.trackArtistNames!.join("")
                                  : "inconnue".toUpperCase(),
                              FontWeight.w500,
                              1),
                        ]),
                  )
                ],
              ),
            ),
          );
        }),
      ):
      Center(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: h1(
              "Liste vide",
              FontWeight.bold,
              2
          ),
        ),
      ),
    );
  }
}
