
import 'package:flutter/material.dart';
import 'package:music_app/my_home_page.dart';
import 'package:music_app/pallette_color.dart';

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
        appBarTheme:const AppBarTheme(
          color: appBarColor
        ),
        sliderTheme:const SliderThemeData(
          thumbShape: RoundSliderThumbShape(
            enabledThumbRadius: 5.5,
          ),
          trackHeight: 10
        ),
      ),
      home: const MyHomePage(title: 'Music App'),
      debugShowCheckedModeBanner: false,
    );
  }
}



