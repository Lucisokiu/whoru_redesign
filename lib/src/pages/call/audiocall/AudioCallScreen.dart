import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/pages/call/widget/RoundedButton.dart';


class AudioCallScreen extends StatefulWidget {
  final String avatar;
  final String fullName;
  const AudioCallScreen({super.key, required this.avatar, required this.fullName
  });

  @override
  State<AudioCallScreen> createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image or Color
        // ...

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                // Centered CircleAvatar
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.35,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 84,
                        backgroundColor: Colors.blueGrey[200],
                        child: ClipOval(
                          child: Image.network(
                            widget.avatar,
                            height: 168, // Kích thước ảnh đã nhân đôi bán kính của CircleAvatar
                            width: 168,  // Kích thước ảnh đã nhân đôi bán kính của CircleAvatar
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(height: 1.h,),
                      Text(
                        widget.fullName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 3.h, // Thay đổi kích thước font ở đây
                        ),
                      ),

                    ],
                  ),
                ),
                Spacer(),
                // Row of RoundedButtons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundedButton(
                      press: () {},
                      iconSrc: "assets/icons/Icon Mic.svg",
                    ),
                    RoundedButton(
                      press: () {
                        Navigator.pop(context);
                      },
                      color: Colors.red,
                      iconColor: Colors.white,
                      iconSrc: "assets/icons/call_end.svg",
                    ),
                    RoundedButton(
                      press: () {},

                      iconSrc: "assets/icons/Icon Volume.svg",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

