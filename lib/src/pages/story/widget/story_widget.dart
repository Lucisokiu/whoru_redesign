import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sizer/sizer.dart';

import '../../../models/story_model.dart';
import 'add_story.dart';

Widget storywidget(
    BuildContext context, List<Story> storyList, bool isLoading) {
  return Container(
      height: 13.h,
      width: 100.w,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(2.0, 2.0),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: storyList.isEmpty
          ? Row(
              children: [
                addStory(context),
                Container(
                  height: 10.h,
                  child: Lottie.asset('assets/lottie/playing_cat.json'),
                ),
              ],
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  addStory(context),
                  if (storyList.isNotEmpty)
                    for (int i = 0; i < storyList.length; i++)
                      yourStory(
                          context, storyList[i].imageUrl, storyList[i].name),
                  SizedBox(width: 10.w),
                  if (isLoading)
                    Padding(
                      padding: EdgeInsets.only(bottom: 3.h),
                      child: CircularProgressIndicator(),
                    ),
                  SizedBox(
                    width: 2.w,
                  )
                ],
              ),
            ));
}

Widget yourStory(BuildContext context, urlImage, userName) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: PhotoViewGallery.builder(
              itemCount: 1,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: CachedNetworkImageProvider(
                    urlImage,
                  ),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 2,
                );
              },
              scrollPhysics: const BouncingScrollPhysics(),
              backgroundDecoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              pageController: PageController(),
            ),
          ),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              border: GradientBoxBorder(
                gradient: LinearGradient(
                  colors: [
                    Color(0xffFBAA47),
                    Color(0xffD91A46),
                    Color(0xffA60F93),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.centerRight,
                ),
                width: 2,
              ),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(2),
            child: CachedNetworkImage(
              imageUrl: urlImage,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageBuilder: (context, imageProvider) => ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: Image.network(
                  urlImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            userName,
            style: const TextStyle(
              fontSize: 11,
            ),
          ),
        ],
      ),
    ),
  );
}
