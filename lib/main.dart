
import 'package:flutter/material.dart';
import 'package:music_app/pallette_color.dart';
import 'package:music_app/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apple Music',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme:const AppBarTheme(
          color: appBarColor,
        ),
        sliderTheme:const SliderThemeData(
          thumbShape: RoundSliderThumbShape(
            enabledThumbRadius: 5.5,
          ),
          trackHeight: 10,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: textColor,
          ),
        ),
      ),
      darkTheme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: purWhite,
          ),
        ),
        sliderTheme:const SliderThemeData(
          thumbShape: RoundSliderThumbShape(
            enabledThumbRadius: 5.5,
          ),
          trackHeight: 10,
        ),
        appBarTheme:const AppBarTheme(
            backgroundColor: dark
         ),
        scaffoldBackgroundColor: dark,
      ),
      home: const SplachScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}



