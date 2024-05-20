  import 'package:flutter/material.dart';

void showPopupMenu(BuildContext context) async {
    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        const PopupMenuItem(
          value: 'item1',
          child: Text('Mục 1'),
        ),
        const PopupMenuItem(
          value: 'item2',
          child: Text('Mục 2'),
        ),
        const PopupMenuItem(
          value: 'item3',
          child: Text('Mục 3'),
        ),
      ],
      elevation: 8.0,
    );
  }