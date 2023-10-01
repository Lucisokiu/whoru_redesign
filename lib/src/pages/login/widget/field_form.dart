import 'package:flutter/material.dart';

Widget TextFormFieldBox(String myhintText, IconData myIcons, bool canObscure,
    TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50.00),
    child: TextFormField(
      style: const TextStyle(color: Colors.white),
      obscureText: canObscure,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(40.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(40.0),
        ),
        prefixIcon: Icon(myIcons, color: Colors.white),
        hintText: myhintText,
        hintStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: const Color.fromRGBO(81, 165, 243, 1),
      ),
    ),
  );
}
