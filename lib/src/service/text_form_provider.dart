import 'package:flutter/material.dart';

class TextFormFieldProvider extends ChangeNotifier {
  String text = '';

  void setText(String value) {
    text = value;
    notifyListeners();
  }
}