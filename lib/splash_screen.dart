import 'package:flutter/material.dart';
import 'package:music_app/my_home_page.dart';

class SplachScreen extends StatefulWidget{
  const SplachScreen({super.key});
  @override
  State<StatefulWidget> createState()=>_SplashScrenState();

}


class _SplashScrenState  extends State<SplachScreen>{
  @override
  void initState(){
    super.initState();
      goToHome();
  }
  goToHome(){
    Future.delayed(const Duration(seconds: 3)).then(
            (value) =>Navigator.pushReplacement(
                context, MaterialPageRoute(
                builder:
                ((context)
                {
                  return const MyHomePage();
                })
              )
            )
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Image.asset("images/img-4.jpg"),
      ),
    );
  }

}