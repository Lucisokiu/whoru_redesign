import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/pages/splash/splash.dart';

import 'src/pages/user/controller/language/app_localization.dart';
import 'src/pages/user/controller/language/bloc/language_bloc.dart';
import 'src/services/no_over_scoll.dart';
import 'src/services/certificate_verify_failed.dart';
import 'src/pages/user/controller/theme/get_theme.dart';
import 'src/pages/user/controller/language/language.dart';
import 'src/matherial/themes.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  LocalizationService.getLocale();
  ThemeController(ThemeMode.system);
  cameras = await availableCameras();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ThemeController(
                ThemeController.isDark ? ThemeMode.dark : ThemeMode.light)),
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
    final isDark = context.select((ThemeController bloc) => bloc.state);
    final locale = context.select((LanguageBloc bloc) => bloc.state.locale);
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
        themeMode: isDark,
        locale: locale,
        localizationsDelegates: const [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('vi', 'VN'),
        ],
        home: const SplashScreen(),
      );
    });
  }
}
