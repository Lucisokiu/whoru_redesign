import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/page/appbar/appbar.dart';
import 'package:whoru/src/page/home/widget/feed_cart.dart';
import 'package:whoru/src/page/home/widget/story_widget.dart';
// import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
// import 'package:lottie/lottie.dart';
// import 'package:sizer/sizer.dart';
// import 'package:whoru/src/page/appbar/appbar.dart';
// import 'package:whoru/src/page/splash/splash.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        children: [
          Expanded(child: Builder(builder: (context) {
            return ListView(
              scrollDirection: Axis.vertical,
              children: [
                storywidget(context),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                const CardFeed(),
              ],
            );
          })),
        ],
      ),
    );
  }
}


//   Widget _buildActionHome(context, title, icon) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 2.sp),
//       padding: EdgeInsets.all(11.sp),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
// color: Colors.blueAccent,
//               border: Border.all(width: 10,color: Colors.red,),
//                 borderRadius: BorderRadius.horizontal(left: Radius.circular(50),right: Radius.circular(10))
//       ),
//       child: Icon(
//         icon,
//         size: 18.sp,
//         color: Colors.black,
//       ),
//     );
//   }

  // Widget _buildActiveFriend(context) {
  //   return Container(
  //     child: Column(
  //       children: [
  //         Container(
  //           height: 65.sp,
  //           width: 100.w,
  //           child: ListView.builder(
  //             padding: EdgeInsets.symmetric(horizontal: 2.w),
  //             physics: BouncingScrollPhysics(),
  //             scrollDirection: Axis.horizontal,
  //             itemCount: chats.length,
  //             itemBuilder: (context, index) {
  //               return ActiveFriendCard(
  //                 blurHash: chats[index].blurHash,
  //                 urlToImage: chats[index].image,
  //                 fullName: chats[index].fullName,
  //               );
  //             },
  //           ),
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(top: 2.h, bottom: .5.h),
  //           child: Divider(
  //             height: .2,
  //             thickness: .2,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
