import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/matherial/themes.dart';
import 'package:whoru/src/pages/splash/splash.dart';
import 'package:whoru/src/service/NoOverScoll.dart';
import 'package:whoru/src/service/certificate_verify_failed.dart';
import 'package:whoru/src/pages/user/controller/get_theme.dart';
import 'package:whoru/src/pages/user/controller/language.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController());
  HttpOverrides.global = MyHttpOverrides();
  LocalizationService.getLocale();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.blue, // Đặt màu sắc cho thanh trạng thái
    //   statusBarIconBrightness: Brightness
    //       .light, // Đặt màu sắc của các biểu tượng trạng thái (light hoặc dark)
    // ));
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        title: 'Whoru',
        theme: AppTheme.light().data,
        darkTheme: AppTheme.dark().data,
        locale: LocalizationService.locale,
        fallbackLocale: LocalizationService.fallbackLocale,
        translations: LocalizationService(),
        home: const SplashScreen(),
      );
    });
  }
}
