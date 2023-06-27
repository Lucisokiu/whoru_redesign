import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/page/splash/splash.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const SplashScreen()));
                  },
                  icon: SizedBox(
                      height: 15.h,
                      width: 10.w,
                      child: Lottie.asset('assets/lottie/splash_cat.json'),
                  )
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const SplashScreen()));
                  },
                  icon: Text.rich(
                          TextSpan(
                              text: 'Whoru',
                              style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Lobster',
                              fontSize: 10.sp,
                              ),
                          ),
                        ),
                )
                
              ]
            ),
        // flexibleSpace: Container(
        //     decoration: const BoxDecoration(
        //         gradient: LinearGradient(
        //         begin: Alignment.topLeft,
        //         end: Alignment(0.8, 1),
        //         colors: <Color>[
        //         Colors.purple,
        //         Colors.orange,
        //       ],
        //     )
        //   )
        // ),
        // leading: <Widget>[
        //     IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.home),
        //   ),
        //     IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.home),
        //   ),
        //   ]
        actions: <Widget>[
          IconButton(
            icon: const Icon(PhosphorIcons.chats_circle_fill),
            tooltip: 'Show Snackbar',
            onPressed: () {},
          ),
          ]
      ),
        body: const Center(
        child: Text(
          'This is the home page',
          style: TextStyle(fontSize: 24),
        ),
      ),
      
    );
  }
}