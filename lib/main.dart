import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:movie_mojo/screens/authRegister.dart';
import 'package:movie_mojo/screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return MaterialApp(
      title: 'Movie Mojo',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor:const Color.fromARGB(255, 13, 17, 67),),
        useMaterial3: true,
      ),
      home: AnimatedSplashScreen(splash: 'assets/images/Movie_Mojo_final.png',
      nextScreen:AuthRegisterScreen(),
      splashTransition: SplashTransition.rotationTransition,
      backgroundColor: Color.fromARGB(255, 13, 17, 67,),
      splashIconSize:height/2,
      animationDuration: Duration(seconds: 2),
      ),
    );
  }
}