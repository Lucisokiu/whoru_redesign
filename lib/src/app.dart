import 'package:flutter/material.dart';
import 'package:whoru/src/pages/navigation/navigation.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Scaffold(

      body:SafeArea(
        child: Center(child: Navigation())
        ),
    ));
  }
}
