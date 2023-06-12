import 'package:music_app/pallette_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text textWithStyle(String data, double scale) {
  return Text(
    data,
    textScaleFactor: scale,
    textAlign: TextAlign.center,
    style: GoogleFonts.lato(
      textStyle: const TextStyle(
          color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600),
    ),
  );
}

CircleAvatar circleWithAvatar(IconData icone, Color color, Function() action) {
  return CircleAvatar(
    backgroundColor: color,
    radius: 30,
    child: IconButton(
      icon: Icon(icone),
      color: Colors.grey[200],
      onPressed: action,
    ),
  );
}

Text timeStamp(String data) {
  return Text(
    data,
    style: GoogleFonts.lato(
      textStyle: const TextStyle(
        color: whiteFont,
        fontSize: 17.0,
      ),
    ),
  );
}

String formatDuration(Duration duree) {
  return duree.toString().split(".").first;
}

IconButton iconButton(IconData? icon,Color iconColor, Function() action) {
  return IconButton(onPressed: action, icon:Icon(icon),color: iconColor);
}
