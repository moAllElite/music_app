// ignore: file_names
import 'package:flutter/services.dart' show Uint8List;
class Music{
   String? titre ;
   String? artiste;
   String? path;
   Uint8List? cover;

   Music(this.titre, this.artiste, this.path, this.cover);
}