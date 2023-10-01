import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/pages/login/widget/field_form.dart';
import 'package:whoru/src/pages/login/widget/zoom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    // Đặt lắng nghe sự thay đổi của các TextFormField
    _usernameController.addListener(checkButtonState);
    _passwordController.addListener(checkButtonState);
  }

  void checkButtonState() {
    setState(() {


      isButtonEnabled = _passwordController.text.isNotEmpty &&
          _usernameController.text.isNotEmpty;

      print('isButtonEnabled $isButtonEnabled');
    });
  }

  @override
  void dispose() {
    // Loại bỏ lắng nghe khi widget bị huỷ
    _usernameController.removeListener(checkButtonState);
    _passwordController.removeListener(checkButtonState);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SizedBox(height: 5.h),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Login Form",
                style: TextStyle(
                  fontFamily: "Lora",
                  fontStyle: FontStyle.italic,
                  fontSize: 36.0,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            TextFormFieldBox(
                "Username", Icons.person, false, _usernameController),
            SizedBox(height: 2.h),
            TextFormFieldBox("Password", Icons.lock, true, _passwordController),
            SizedBox(height: 2.h),
            zoomButton(isButtonEnabled, 'Login', 'right', 1,context),
            SizedBox(height: 0.5.h),
            zoomButton(isButtonEnabled, 'Register', 'left', 2,context),
          ],
        ),
      ),
    );
  }
}
