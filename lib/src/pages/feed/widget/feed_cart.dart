import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/api/feed.dart';
import 'package:whoru/src/api/like.dart';
import 'package:whoru/src/model/feed.dart';
import 'package:whoru/src/pages/feed/controller/build_Image.dart';
import 'package:whoru/src/service/show_toast.dart';

class CardFeed extends StatefulWidget {
  FeedModel feed;

  CardFeed({super.key, required this.feed});

  @override
  State<CardFeed> createState() => _CardFeedState();
}

class _CardFeedState extends State<CardFeed> {
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
                        child: CircleAvatar(
                          radius: 30.0, // Set the radius based on your design
                          backgroundColor: Colors
                              .transparent, // Set background color to transparent
                          child: ClipOval(
                            child: Image.network(
                              widget.feed.avatar,
                              width: 60.0, // Set width based on your design
                              height: 60.0, // Set height based on your design
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        widget.feed.fullName,
                        style: const TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      // SizedBox(
                      //   width: 50.w,
                      //   child: Wrap(
                      //     children: [
                      //       Text(
                      //         widget.feedModel.title,
                      //         style: const TextStyle(
                      //           fontFamily: "Montserrat",
                      //           fontWeight: FontWeight.w400,
                      //           fontSize: 14,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        color:
                            Theme.of(context).buttonTheme.colorScheme!.primary,
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
                    widget.feed.content,
                    style: const TextStyle(fontFamily: "Inter", fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Stack(
                children: [
                  (widget.feed.imageUrls.length == 1)
                      ? buildSingleImage(context, widget.feed.imageUrls[0])
                      : (widget.feed.imageUrls.length == 2)
                          ? buildDoubleImage(context, widget.feed.imageUrls[0],
                              widget.feed.imageUrls[1])
                          : (widget.feed.imageUrls.length == 3)
                              ? buildTripleImage(
                                  context,
                                  widget.feed.imageUrls[0],
                                  widget.feed.imageUrls[1],
                                  widget.feed.imageUrls[2])
                              : buildMultipleImage(
                                  context, widget.feed.imageUrls)
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const SizedBox(width: 5.0),
                  BuildButtonFeed(
                    icon: PhosphorIcons.fill.heart,
                    label: widget.feed.likeCount,
                    onPressed: () {
                      likePost(widget.feed.idFeed);
                    },
                    isLike: false,
                  ),
                  const SizedBox(width: 5.0),
                  BuildButtonFeed(
                    icon: PhosphorIcons.fill.chatTeardrop,
                    label: widget.feed.commentCount,
                    onPressed: () {
                      likePost(widget.feed.idFeed);
                    },
                  ),
                  const Spacer(),
                  BuildButtonFeed(
                    icon: PhosphorIcons.fill.shareFat,
                    label: widget.feed.shareCount,
                    onPressed: () {
                      likePost(widget.feed.idFeed);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void call() {}
