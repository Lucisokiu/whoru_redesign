import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class IOSSettingsButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Icon icon;
  final bool isEnd;
  final bool isFirst;
  final bool isBottom;

  const IOSSettingsButton(
      {super.key, required this.title,
      required this.onPressed,
      required this.icon,
      this.isEnd = false,
      this.isFirst = false,
      this.isBottom = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: isFirst ? 8.0 : 0.0, left: 16.0, right: 16.0, bottom: isEnd ? 8.0 : 0.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.vertical(
                  top: isFirst ? const Radius.circular(10.0) : Radius.zero,
                  bottom: isBottom ? const Radius.circular(10.0) : Radius.zero,
                ),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  ),
                  icon,
                ],
              ),
            ),
            if (!isEnd) divider
          ],
        ),
      ),
    );
  }
}

final Divider divider = Divider(
  height: 1.sp,
);
