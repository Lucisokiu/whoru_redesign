import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/main.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:whoru/src/page/home/page/post_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const PostPage(),
        ),
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
            Color(0xff1f005c),
            Color(0xff5b0060),
            Color(0xff870160),
            Color(0xffac255e),
            Color(0xffca485c),
            Color(0xffe16b5c),
            Color(0xfff39060),
            Color(0xffffb56b),
          ],
            )),
            child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 55.h,
                      width: 55.w,
                      child: Lottie.asset('assets/lottie/splash_cat.json'),
                  ),
                  // SizedBox(height: 5.h),  Hello $_user_name => để lời chào user 
                  //nếu đã đăng nhập ( phiên đăng nhập )
                  Text.rich(
                    TextSpan(
                        text: 'Whoru Social',
                        style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Lobster',
                        fontSize: 20.sp,
                        ),
                    ),
                  ),
                ],
              )

            ),
          // nextScreen: const MyHomePage(),
        );
  }
}

// Container(
// decoration: const BoxDecoration(
// gradient: LinearGradient(
// begin: Alignment.topLeft,
// end: Alignment(0.8, 1),
// colors: <Color>[
// Color(0xff1f005c),
// Color(0xff5b0060),
// Color(0xff870160),
// Color(0xffac255e),
// Color(0xffca485c),
// Color(0xffe16b5c),
// Color(0xfff39060),
// Color(0xffffb56b),
// ],
// )
// ),
// )
