import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
/*
 * return text with scale 
 */
Text textWithScale(String data, double scale) {
  return Text(
    data,
    textScaleFactor: scale,
    textAlign: TextAlign.start,
    style: GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 20.0,
      ),
    ),
  );
}
/*
 *customize buttons (play,rewind and forward) 
 */
CircleAvatar circleWithAvatar(IconData icone, Color color,Color iconButtonColor, Function() action) {
  return CircleAvatar(
    backgroundColor: color,
    radius: 30,
    child: IconButton(
      icon: Icon(icone,size: 29.0,),
      color: iconButtonColor,
      onPressed: action,
    ),
  );
}
/*
 *music timeLine 
 */
Text timeStamp(String data) {
  return Text(
    data,
    style: GoogleFonts.lato(
      textStyle: const TextStyle(
        fontSize: 17.0,
      ),
    ),
  );
}

/*
 * return duration 
 */

String formatDuration(Duration duree) {
  return duree.toString().split(".").first;
}
/*
 * 
 */

/*
*icon button builder base on java
*/
IconButton iconButton(IconData? icon, Color iconColor, Function() action) {
  return IconButton(onPressed: action, icon: Icon(icon), color: iconColor);
}

// customize text  base  to html from h1-> h6 
Text h1(String data, FontWeight weight,double scale) {
  return Text(
    data,
    textScaleFactor: scale,
    style: GoogleFonts.lato(
        fontSize: 20, fontWeight: weight),
  );
}

Text h2(String data, FontWeight weight,double scale) {
  return Text(
    data,
    style: GoogleFonts.lato(
      fontSize: 17, fontWeight: weight),
  );
}

Text h3(String data, FontWeight weight,double scale) {
  return Text(
    data,
    textScaleFactor: scale,
    style: GoogleFonts.lato(
      fontSize: 15, fontWeight: weight),
  );
}
Text h4(String data, FontWeight weight,double scale) {
  return Text(
    data,
    textScaleFactor: scale,
    style: GoogleFonts.lato(
      fontSize: 12, fontWeight: weight),
  );
}
Text h5(String data, FontWeight weight,double scale) {
  return Text(
    data,
    textScaleFactor: scale,
    style: GoogleFonts.lato(
      fontSize: 10, fontWeight: weight),
  );
}
Text h6(String data, FontWeight weight,double scale) {
  return Text(
    data,
    textScaleFactor: scale,
    style: GoogleFonts.lato(
      fontSize: 8, fontWeight: weight
    ),
  );
}