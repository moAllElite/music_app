
import 'package:flutter/material.dart';
import 'package:music_app/my_home_page.dart';

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



