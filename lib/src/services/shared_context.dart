import 'package:flutter/material.dart';

class SharedContext extends InheritedWidget {
  final BuildContext context;

  const SharedContext({super.key, 
    required this.context,
    required Widget child,
  }) : super(child: child);

  static SharedContext? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SharedContext>();
  }

  @override
  bool updateShouldNotify(SharedContext oldWidget) {
    return false;
  }
}