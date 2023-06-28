import 'package:flutter/material.dart';
import 'package:whoru/src/page/appbar/appbar.dart';
// import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
// import 'package:lottie/lottie.dart';
// import 'package:sizer/sizer.dart';
// import 'package:whoru/src/page/appbar/appbar.dart';
// import 'package:whoru/src/page/splash/splash.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      appBar: MyAppBar(),
        body: Center(
        child: Text(
          'This is the home page',
          style: TextStyle(fontSize: 24),
        ),
      ),
      
    );
  }

}