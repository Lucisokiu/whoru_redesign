import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whoru/src/pages/login/login_screen.dart';
import 'package:whoru/src/pages/profile/profile_screen.dart';
import 'package:whoru/src/pages/user/controller/theme/get_theme.dart';
import 'package:whoru/src/pages/user/controller/language/language.dart';
import 'package:whoru/src/utils/token.dart';

import '../face_detection/ML/view/face_register_view.dart';
import 'controller/language/app_localization.dart';
import 'controller/language/bloc/language_bloc.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late bool darkMode;
  late String selectedLanguage;

  getTheme() {
    setState(() {
      darkMode = ThemeController.isDark;
    });
  }

  getLanguage() {
    setState(() {
      selectedLanguage = LocalizationService.locale!.languageCode;
      print(selectedLanguage);
    });
  }

  @override
  void initState() {
    super.initState();
    getLanguage();
    getTheme();
    print(darkMode);
  }

  var list = <DropdownMenuItem<String>>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My account', // Add a label
                      style: TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios_outlined),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => ProfilePage(isMy: true)));
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.color_lens,
                size: 24.0,
              ),
              label: Row(
                children: [
                  Text(
                    'Change Theme',
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  IconButton(
                    icon: darkMode
                        ? Icon(Icons.toggle_on)
                        : Icon(Icons.toggle_off_outlined),
                    onPressed: () {
                      setState(() {
                        darkMode = !darkMode;
                        BlocProvider.of<ThemeController>(context)
                            .toggleDarkMode();
                      });
                    },
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.language, // Choose an appropriate icon
                size: 24.0,
              ),
              label: Row(
                children: [
                  Text(
                    AppLocalization.of(context).getTranslatedValues('language'),
                    style: const TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  DropdownButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    value: selectedLanguage,
                    items: _buildDropdownMenuItems(),
                    onChanged: (String? newValue) {
                      setState(() {
                        print("newValue ${newValue!}");
                        selectedLanguage = newValue;
                        LocalizationService.changeLocale(newValue);
                        BlocProvider.of<LanguageBloc>(context)
                            .add(LoadLanguage(Locale('$newValue')));
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: TextButton.icon(
              onPressed: () async {
                deleteToken();
                deleteIdUser();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => LoginScreen()),
                    (route) => false);
              },
              icon: Icon(
                Icons.account_circle, // Choose an appropriate icon
                size: 24.0,
              ),
              label: Row(
                children: [
                  Text(
                    'Log out',
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.logout_outlined),
                    onPressed: () async {
                      deleteToken();
                      deleteIdUser();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => LoginScreen()),
                          (route) => false);
                    },
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.color_lens,
                size: 24.0,
              ),
              label: Row(
                children: [
                  Text(
                    'Face Dectection(Test)',
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => RegistrationScreen()));
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool get updateKeepAlive => true;

  List<DropdownMenuItem<String>> _buildDropdownMenuItems() {
    var list = <DropdownMenuItem<String>>[];
    LocalizationService.langs.forEach((key, value) {
      list.add(DropdownMenuItem<String>(
        value: key,
        child: Text(
          value,
          style:
              TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
        ),
      ));
    });
    return list;
  }
}
