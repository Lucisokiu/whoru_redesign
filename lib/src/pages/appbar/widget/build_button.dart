import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/pages/chat/chat_page.dart';
import 'package:whoru/src/pages/feed/widget/create_post.dart';
import 'package:whoru/src/pages/search/controller/search_bar.dart';

import '../../../utils/shared_pref/iduser.dart';

Widget buildActionHome(context, title, icon) {
  return InkWell(
      onTap: () async {
        if (title == "Create") {
          // customCreatePostDialog(context);
        
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreatePost(),
            ),
          );
        }
        if (title == "Search") {
          showSearch(
            context: context,
            delegate: CustomSearch(),
          );
        }
        if (title == "Chat") {
          int? id = await getIdUser();
          print(id);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(currentId: id!),
            ),
          );
        }
      },
      child: Container(
        width: 8.w,
        margin: EdgeInsets.only(bottom: 2.sp),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 23.sp,
          // color: Theme.of(context).buttonTheme.colorScheme!.primary,
        ),
      ));
}
