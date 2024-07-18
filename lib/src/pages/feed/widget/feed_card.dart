import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/api/like.dart';
import 'package:whoru/src/api/share.dart';
import 'package:whoru/src/models/feed_model.dart';
import 'package:whoru/src/pages/feed/controller/build_image.dart';
import 'package:whoru/src/pages/feed/widget/list_like_dialog.dart';
import 'package:whoru/src/pages/feed/widget/update_post.dart';
import 'package:whoru/src/pages/profile/profile_screen.dart';
import 'package:whoru/src/pages/splash/splash.dart';

import '../../../api/feed.dart';
import '../../../api/follow.dart';
import '../../app.dart';
import 'comment_dialog_new.dart';

class CardFeed extends StatefulWidget {
  final FeedModel feed;

  const CardFeed({super.key, required this.feed});

  @override
  State<CardFeed> createState() => _CardFeedState();
}

class _CardFeedState extends State<CardFeed> {
  bool isLoading = false;
  bool isFollow = false;
  bool isShare = false;
  bool isSave = false;

  void callAPI() {
    customCommentDialog(context, widget.feed.idFeed, localIdUser);
  }

  @override
  void initState() {
    setState(() {
      isFollow = widget.feed.isFollow;
      isShare = widget.feed.isShare;
      isSave = widget.feed.isSave;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, bottom: 10.0, top: 16.0),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(10.0),
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
              padding:
                  const EdgeInsets.only(bottom: 5.0, left: 15.0, right: 15.0),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => ProfilePage(
                                          idUser: widget.feed.idUser,
                                          isMy:
                                              localIdUser == widget.feed.idUser
                                                  ? true
                                                  : false,
                                        )));
                          },
                          child: CachedNetworkImage(
                            imageUrl: widget.feed.avatar,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
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
                      localIdUser != widget.feed.idUser
                          ? ElevatedButton(
                              onPressed: () {
                                if (isFollow) {
                                  unFollowUser(widget.feed.idUser);
                                  setState(() {
                                    isFollow = !isFollow;
                                  });
                                } else {
                                  followUser(widget.feed.idUser);
                                  setState(() {
                                    isFollow = !isFollow;
                                  });
                                }
                              },
                              child: Icon(
                                isFollow ? Icons.person_off : Icons.person_add,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            )
                          : PopupMenuButton<String>(
                              onSelected: (String value) {
                                if (value == 'update') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) =>
                                          UpdatePost(feedModel: widget.feed),
                                    ),
                                  );
                                } else if (value == 'delete') {
                                  delete(widget.feed.idFeed);
                                }
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'update',
                                  child: Text('Update'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'delete',
                                  child: Text('Delete'),
                                ),
                              ],
                              icon: Icon(
                                PhosphorIconsFill.dotsThreeOutlineVertical,
                                color: Theme.of(context)
                                    .buttonTheme
                                    .colorScheme!
                                    .primary,
                                size: 20.0,
                              ),
                              offset: Offset(-5.w, 5.h),
                            )
                    ],
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8, left: 10, right: 10),
                    // Điều này sẽ tạo khoảng cách giữa Container và các widget trước đó

                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.feed.content,
                          style: const TextStyle(
                              fontFamily: "Inter", fontSize: 16),
                        )),
                  ),
                  const SizedBox(height: 16),
                  Stack(
                    children: [
                      (widget.feed.imageUrls.length == 1)
                          ? buildSingleImage(context, widget.feed.imageUrls[0])
                          : (widget.feed.imageUrls.length == 2)
                              ? buildDoubleImage(
                                  context,
                                  widget.feed.imageUrls[0],
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
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BuildButtonFeed(
                        icon: PhosphorIconsFill.heart,
                        label: widget.feed.likeCount,
                        onPressed: () {
                          likePost(widget.feed.idFeed);
                        },
                        onLongPress: () {
                          setState(() {
                            isLoading = true;
                          });
                          getListLike(widget.feed.idFeed, 1).then((listLike) {
                            setState(() {
                              isLoading = false;
                            });
                            showListDialog(context, listLike, "Like List");
                          });
                        },
                        isLike: widget.feed.isLike,
                        likeButton: true,
                      ),
                      BuildButtonFeed(
                        icon: PhosphorIconsFill.chatTeardrop,
                        label: widget.feed.commentCount,
                        onPressed: () {
                          customCommentDialog(
                              context, widget.feed.idFeed, localIdUser);
                        },
                        onLongPress: () {},
                        commentButton: true,
                      ),
                      BuildButtonFeed(
                        icon: PhosphorIconsFill.shareFat,
                        label: widget.feed.shareCount,
                        onPressed: () {
                          if (localIdUser != widget.feed.idUser) {
                            if (isShare) {
                              unSharePost(widget.feed.idFeed);
                              setState(() {
                                isShare = !isShare;
                              });
                            } else {
                              sharePost(widget.feed.idFeed);
                              setState(() {
                                isShare = !isShare;
                              });
                            }
                          }
                        },
                        onLongPress: () {
                          setState(() {
                            isLoading = true;
                          });
                          getListShare(widget.feed.idFeed, 1).then((listShare) {
                            showListDialog(context, listShare, "Share List");
                            setState(() {
                              isLoading = false;
                            });
                          });
                        },
                        isShare: isShare,
                        shareButton: true,
                        isMy: localIdUser == widget.feed.idUser,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ],
    );
  }
}
