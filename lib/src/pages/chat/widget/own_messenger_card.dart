import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({super.key, required this.message, required this.time,required this.id});
  final int id;
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        final RenderBox overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;
        final RenderBox card = context.findRenderObject() as RenderBox;

        final Offset cardBottomLeft =
            card.localToGlobal(Offset.zero, ancestor: overlay);
        final Offset cardBottomRight = card.localToGlobal(
            card.size.bottomRight(Offset.zero),
            ancestor: overlay);
        print(card.size.width);
        final RelativeRect position = RelativeRect.fromLTRB(
          cardBottomLeft.dx + card.size.width,
          cardBottomLeft.dy + card.size.height,
          cardBottomRight.dx,
          cardBottomRight.dy,
        );
        showMenu(
          context: context,
          position: position,
          items: [
            PopupMenuItem(
              child: GestureDetector(
                onTap: () {
                  // Thực hiện hành động khi nhấn "Xóa"
                  Navigator.pop(context); // Ẩn pop-up menu
                },
                child: const Text("Xóa"),
              ),
            ),
          ],
        );
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            // color: Color(0xffdcf8c6),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  child: Text(
                    message,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                // Positioned(
                //   bottom: 4,
                //   right: 10,
                //   child: Row(
                //     children: [

                //       Text(
                //         time,
                //         style: TextStyle(
                //           fontSize: 13,
                //           color: Colors.grey[600],
                //         ),
                //       ),
                //       // const SizedBox(
                //       //   width: 5,
                //       // ),
                //       // const Icon(
                //       //   Icons.done_all,
                //       //   size: 20,
                //       // ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
