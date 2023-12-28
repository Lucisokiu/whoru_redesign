import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/api/comment.dart';
import 'package:whoru/src/api/feed.dart';
import 'package:whoru/src/api/like.dart';
import 'package:whoru/src/api/share.dart';
import 'package:whoru/src/model/CommentModel.dart';
import 'package:whoru/src/model/Feed.dart';
import 'package:whoru/src/pages/feed/controller/build_Image.dart';
import 'package:whoru/src/pages/feed/widget/CommentDialog.dart';
import 'package:whoru/src/pages/feed/widget/ListDialog.dart';
import 'package:whoru/src/pages/location/widget/map_widget.dart';
import 'package:whoru/src/pages/profile/profile_screen.dart';
import 'package:whoru/src/service/show_toast.dart';

class CardFeed extends StatefulWidget {
  FeedModel feed;
  final int CurrentUser;

  CardFeed({super.key, required this.feed, required this.CurrentUser});

  @override
  State<CardFeed> createState() => _CardFeedState();
}

class _CardFeedState extends State<CardFeed> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10.0, right: 5.0),
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    width: 60,
                    height: 60,
                    child: GestureDetector(
                        onTap: () {
                          if (widget.CurrentUser != widget.feed.idUser) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => ProfilePage(
                                          idUser: widget.feed.idUser,
                                          isMy: false,
                                        )));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => ProfilePage(
                                          idUser: widget.feed.idUser,
                                          isMy: true,
                                        )));
                          }
                        },
                        child: CircleAvatar(
                          radius: 30.0,
                          // Set the radius based on your design
                          backgroundColor: Colors.transparent,
                          // Set background color to transparent
                          child: ClipOval(
                            child: Image.network(
                              widget.feed.avatar,
                              width: 45.0, // Set width based on your design
                              height: 45.0, // Set height based on your design
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                  ),
                  Text(
                    widget.feed.fullName,
                    style: const TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        color:
                            Theme.of(context).buttonTheme.colorScheme!.primary,
                        PhosphorIconsFill.dotsThreeOutlineVertical,
                        size: 20.0,
                      )),
                ],
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Container(
                margin: EdgeInsets.only(top: 8,left: 10, right: 10), // Điều này sẽ tạo khoảng cách giữa Container và các widget trước đó

                child: Align(
                  alignment: Alignment.topLeft,
                    child: Text(
                      widget.feed.content,
                      style: const TextStyle(fontFamily: "Inter", fontSize: 16),
                    )
                ),
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
                    icon: PhosphorIconsFill.heart,
                    label: widget.feed.likeCount,
                    onPressed: () {
                      likePost(widget.feed.idFeed);
                    },
                    onLongPress: () async {
                      List<Map<String, dynamic>> listLike =
                          await getListLike(widget.feed.idFeed);
                      showListDialog(context, listLike);
                    },
                    isLike: widget.feed.isLike,
                  ),
                  const SizedBox(width: 5.0),
                  BuildButtonFeed(
                    icon: PhosphorIconsFill.chatTeardrop,
                    label: widget.feed.commentCount,
                    onPressed: () async {
                      List<CommentModel>? sampleComments =
                          await getCommentByIdFeed(widget.feed.idFeed);
                      showCommentDialog(context, sampleComments,
                          widget.feed.idFeed, widget.CurrentUser!);
                    },
                    onLongPress: () {},
                  ),
                  const Spacer(),
                  BuildButtonFeed(
                    icon: PhosphorIconsFill.shareFat,
                    label: widget.feed.shareCount,
                    onPressed: () {
                      sharePost(widget.feed.idFeed);
                    },
                    onLongPress: () async {
                      List<Map<String, dynamic>> listShare =
                          await getListShare(widget.feed.idFeed);
                      showListDialog(context, listShare);
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
