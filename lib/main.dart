import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/matherial/themes.dart';
import 'package:whoru/src/pages/splash/splash.dart';
import 'package:whoru/src/pages/user/controller/language/app_localization.dart';
import 'package:whoru/src/pages/user/controller/language/bloc/language_bloc.dart';
import 'package:whoru/src/service/NoOverScoll.dart';
import 'package:whoru/src/service/certificate_verify_failed.dart';
import 'package:whoru/src/pages/user/controller/theme/get_theme.dart';
import 'package:whoru/src/pages/user/controller/language/language.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  LocalizationService.getLocale();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeController(ThemeMode.light)),
        BlocProvider(
            create: (context) => LanguageBloc(LanguageState.initial())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController theme =
        BlocProvider.of<ThemeController>(context, listen: true);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.blue, // Đặt màu sắc cho thanh trạng thái
    //   statusBarIconBrightness: Brightness
    //       .light, // Đặt màu sắc của các biểu tượng trạng thái (light hoặc dark)
    // ));
    return BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
      return Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
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
          themeMode: theme.isDark ? ThemeMode.dark : ThemeMode.light,
          locale: LocalizationService.locale,
          localizationsDelegates: [
            AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', 'US'),
            Locale('vi', 'VN'),
          ],
          home: const SplashScreen(),
        );
      });
    });
  }
}
