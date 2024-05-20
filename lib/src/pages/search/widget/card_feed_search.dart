import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/api/comment.dart';
import 'package:whoru/src/api/like.dart';
import 'package:whoru/src/api/share.dart';
import 'package:whoru/src/models/feed_model.dart';
import 'package:whoru/src/pages/feed/controller/build_image.dart';
import 'package:whoru/src/pages/feed/widget/list_like_dialog.dart';
import 'package:whoru/src/pages/profile/profile_screen.dart';

import '../../feed/widget/comment_dialog_new.dart';

class CardFeedSearch extends StatefulWidget {
  final FeedModel feed;
  final int currentUser;
  final BuildContext parentContext; // Thêm parentContext vào constructor

  const CardFeedSearch(
      {super.key,
      required this.feed,
      required this.currentUser,
      required this.parentContext});

  @override
  State<CardFeedSearch> createState() => _CardFeedSearchState();
}

class _CardFeedSearchState extends State<CardFeedSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: 16.0, right: 16.0, bottom: 10.0, top: 16.0),
      color: Theme.of(widget.parentContext).scaffoldBackgroundColor,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(widget.parentContext).cardTheme.color,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Theme.of(widget.parentContext).shadowColor,
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(2.0, 2.0),
            ),
            BoxShadow(
              color: Theme.of(widget.parentContext).shadowColor,
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
                        if (widget.currentUser != widget.feed.idUser) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => ProfilePage(
                                        idUser: widget.feed.idUser,
                                        isMy: widget.currentUser ==
                                                widget.feed.idUser
                                            ? true
                                            : false,
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
                      child: CachedNetworkImage(
                        imageUrl: widget.feed.avatar,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: imageProvider,
                          radius: 30,
                        ),
                      ),
                    ),
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
                      onPressed: () {
                        if (widget.currentUser == widget.feed.idUser) {}
                      },
                      icon: Icon(
                        color: Theme.of(widget.parentContext)
                            .buttonTheme
                            .colorScheme!
                            .primary,
                        PhosphorIconsFill.dotsThreeOutlineVertical,
                        size: 20.0,
                      )),
                ],
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Container(
                margin: const EdgeInsets.only(top: 8, left: 10, right: 10),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.feed.content,
                      style: const TextStyle(fontFamily: "Inter", fontSize: 16),
                    )),
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
                    onLongPress: () {
                      // List<Map<String, dynamic>> listLike =
                      //     await getListLike(widget.feed.idFeed);
                      // showListDialog(context, listLike);

                      getListLike(widget.feed.idFeed).then(
                          (listLike) => showListDialog(context, listLike));
                    },
                    isLike: widget.feed.isLike,
                  ),
                  const SizedBox(width: 5.0),
                  BuildButtonFeed(
                    icon: PhosphorIconsFill.chatTeardrop,
                    label: widget.feed.commentCount,
                    onPressed: () {
                      // List<CommentModel>? sampleComments =
                      //     await getCommentByIdFeed(widget.feed.idFeed);
                      // await customCommentDialog(context, sampleComments,
                      //     widget.feed.idFeed, widget.currentUser);
                      getCommentByIdFeed(widget.feed.idFeed).then(
                          (sampleComments) => customCommentDialog(
                              context,
                              sampleComments,
                              widget.feed.idFeed,
                              widget.currentUser));

                      Future.delayed(const Duration(milliseconds: 800), () {});
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
                    onLongPress: () {
                      getListShare(widget.feed.idFeed).then(
                          (listShare) => showListDialog(context, listShare));
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
