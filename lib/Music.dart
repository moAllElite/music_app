// ignore_for_file: file_names
import "package:flutter/services.dart";

class Music {
  String? titre;
  String? artiste;
  String? path;
  Uint8List? cover;

  Music(this.titre, this.artiste, this.path, this.cover);
}
