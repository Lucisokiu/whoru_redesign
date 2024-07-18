import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:whoru/src/pages/navigation/navigation.dart';
import 'package:whoru/src/utils/shared_pref/token.dart';

import '../../api/user_info.dart';
import '../../models/user_model.dart';
import '../../utils/shared_pref/iduser.dart';
import '../app.dart';
import '../login/login_screen.dart';

late int localIdUser;
late UserModel localUser;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  String? token;
  int? _id;

  Future<void> _loadToken() async {
    final String? result = await getToken();
    setState(() {
      token = result;
    });
  }

  Future<bool> getUser() async {
    _id = await getIdUser();
    print('_id: $_id');
    if(_id == null){
      return false;
    }
    return await getInfoUserById(_id!).then((value) {
      if (value == null) {
        deleteToken();
        deleteIdUser();
        return false;
      } else {
        localIdUser = value.id;
        localUser = value;
        return true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _loadToken();

    getUser().then((value) {
      if (value) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) =>
                  token != null ? const App() : const LoginScreen(),
            ),
          );
        });
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false);
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
            child: Column(
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
            )),
      ),
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
