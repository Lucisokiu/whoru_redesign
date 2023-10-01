import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/pages/splash/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Whoru',
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        //   useMaterial3: true,
        // ),
        theme: ThemeData.dark(),
    
        home: Sizer(
            builder: (context, orientation, deviceType) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Whoru',
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
                  useMaterial3: true,
                ),
                home: 
                // LoginScreen(),
                const SplashScreen(),
                // home: EntryPoint(),
    
              );
            }
        )
    );
  }
}

