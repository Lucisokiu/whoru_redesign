  import 'package:flutter/material.dart';

void showPopupMenu(BuildContext context) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        PopupMenuItem(
          child: Text('Mục 1'),
          value: 'item1',
        ),
        PopupMenuItem(
          child: Text('Mục 2'),
          value: 'item2',
        ),
        PopupMenuItem(
          child: Text('Mục 3'),
          value: 'item3',
        ),
      ],
      elevation: 8.0,
    );
  }