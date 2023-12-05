import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    backgroundColor: Colors.red, // Màu nền đỏ
    textColor: Colors.black, // chữ đen
    fontSize: 16.0,
    timeInSecForIosWeb: 1,
    webShowClose: false,
  );
}