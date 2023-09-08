import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/model/locationModels.dart';
import 'package:whoru/src/pages/splash/splash.dart';
import 'package:whoru/src/service/location_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
        create: (context) => LocationService().locationStream,
        initialData: UserLocation(),
        
      // builder: (context) => LocationService().locationStream,
      child: MaterialApp(
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
                title: 'Sizer',
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
                  useMaterial3: true,
                ),
                home: const SplashScreen(),
                // home: EntryPoint(),
    
              );
            }
        )
      ),
    );
  }
}

