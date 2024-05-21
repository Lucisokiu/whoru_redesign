import 'package:flutter/material.dart';
import 'package:whoru/src/models/feed_model.dart';

Widget photoProfile(BuildContext context, List<FeedModel>? feed) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      crossAxisSpacing: 1.0,
      mainAxisSpacing: 2.0,
      // childAspectRatio: 1.1,
    ),
    itemBuilder: (BuildContext context, int index) {
      for (final imageUrl in feed[index].imageUrls) {
        return Padding(
          padding: const EdgeInsets.only(left: 1),
          child: yourPicture(context, imageUrl),
        );
      }
      return null;
    },
    itemCount: feed!.length,
  );
}

Widget yourPicture(BuildContext context, urlImage) {
  return Image.network(
    urlImage,
    fit: BoxFit.fill,
    // height: 10.5.h,
  );
}
