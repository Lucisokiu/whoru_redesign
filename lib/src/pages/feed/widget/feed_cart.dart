import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/model/feed.dart';
import 'package:whoru/src/pages/feed/controller/build_Image.dart';

class CardFeed extends StatelessWidget {
  final FeedModel feedModel;
  const CardFeed({super.key, required this.feedModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: 16.0, right: 16.0, bottom: 10.0, top: 16.0),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,

          borderRadius: BorderRadius.circular(10.0), // Bán kính bo góc

          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(2.0, 2.0),
            ),
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(-1.0, -1.0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 14.0, left: 15.0, right: 15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10.0, right: 14.0),
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    width: 60,
                    height: 60,
                    child: GestureDetector(
                      onTap: () {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                        child: Image.network(
                          feedModel.userModel.avt,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        feedModel.userModel.username,
                        style: const TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 50.w,
                        child: Wrap(
                          children: [
                            Text(
                              feedModel.title,
                              style: const TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        color: Theme.of(context).buttonTheme.colorScheme!.primary,
                        PhosphorIcons.fill.dotsThreeOutlineVertical,
                        size: 20.0,
                      )),
                ],
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Wrap(
                children: [
                  Text(
                    feedModel.content,
                    style: const TextStyle(fontFamily: "Inter", fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Stack(
                children: [
                  (feedModel.imageUrls.length == 1)
                      ? buildSingleImage(context, feedModel.imageUrls[0])
                      : (feedModel.imageUrls.length == 2)
                          ? buildDoubleImage(context, feedModel.imageUrls[0],
                              feedModel.imageUrls[1])
                          : (feedModel.imageUrls.length == 3)
                              ? buildTripleImage(
                                  context,
                                  feedModel.imageUrls[0],
                                  feedModel.imageUrls[1],
                                  feedModel.imageUrls[2])
                              : buildMultipleImage(context, feedModel.imageUrls)
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const SizedBox(width: 5.0),
                  buildButton(
                      PhosphorIcons.thin.heart, feedModel.likeCount.toString()),
                  const SizedBox(width: 5.0),
                  buildButton(PhosphorIcons.thin.chatTeardrop,
                      feedModel.commentCount.toString()),
                  const Spacer(),
                  buildButton(PhosphorIcons.thin.shareFat,
                      feedModel.shareCount.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
