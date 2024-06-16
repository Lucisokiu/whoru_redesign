import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../screens/pick_image_screen.dart';

Widget addStory(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 24),
    child: Column(
      children: [
        GestureDetector(
          child: SizedBox(
            width: 70,
            height: 70,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Icon(PhosphorIconsFill.plusCircle,
                  color: Theme.of(context).iconTheme.color),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ImageUploadScreen(),
              ),
            );
          },
        ),
        const SizedBox(
          height: 6,
        ),
        const Text(
          "Add story",
          style: TextStyle(
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}
