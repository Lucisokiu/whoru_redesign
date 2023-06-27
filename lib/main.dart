import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/page/splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      //   useMaterial3: true,
      // ),
      theme: ThemeData.dark(),

      home: Sizer(
          builder: (context, orientation, deviceType) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Sizer',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
                useMaterial3: true,
              ),
              home: const SplashScreen() ,
              // home: const MyHomePage() ,

            );
          }
      )
      // const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

