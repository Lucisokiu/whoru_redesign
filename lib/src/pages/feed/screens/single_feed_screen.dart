import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/models/feed_model.dart';
import 'package:whoru/src/pages/app.dart';

import '../../../api/comment.dart';
import '../../../api/like.dart';
import '../../../models/comment_model.dart';
import '../../profile/profile_screen.dart';
import '../../splash/splash.dart';
import '../controller/build_image.dart';
import '../widget/comment_dialog_new.dart';

class SingleFeedScreen extends StatefulWidget {
  final FeedModel feedModel;

  const SingleFeedScreen({super.key, required this.feedModel});

  @override
  State<SingleFeedScreen> createState() => _SingleFeedScreenState();
}

class _SingleFeedScreenState extends State<SingleFeedScreen> {
  late FeedModel feed;
  List<CommentModel> commentList = [];
  int page = 1;
  bool isLoadingComment = true;
  final TextEditingController _controller = TextEditingController();
  bool sendButton = false;
  int likeCount = 0;
  int commentCount = 0;

  void _checkSensitiveWords() {
    final text = _controller.text;
    final sanitizedText = text.replaceAllMapped(sensitiveWordPattern, (match) {
      return '*' * match.group(0)!.length;
    });

    if (text != sanitizedText) {
      _controller.value = _controller.value.copyWith(
        text: sanitizedText,
        selection: TextSelection.fromPosition(
          TextPosition(offset: sanitizedText.length),
        ),
      );
    }
  }

  void checkMaxTitle() {
    int maxWords = 2000;
    print(_controller.text);
    if (_controller.text.length > maxWords) {
      setState(() {
        int caretPosition = _controller.selection.end;
        _controller.text = _controller.text.substring(0, maxWords);
        _controller.selection = TextSelection.fromPosition(
            TextPosition(offset: min(caretPosition, _controller.text.length)));
      });
    }
  }

  Future<void> fetchData(int id) async {
    feed = widget.feedModel;
    final results = await getCommentByIdFeed(id, page++);
    commentList.addAll(results);
    if (mounted) {
      setState(() {
        isLoadingComment = false;
      });
    }
  }

  @override
  void initState() {
    likeCount = widget.feedModel.likeCount;
    commentCount = widget.feedModel.commentCount;
    fetchData(widget.feedModel.idFeed);
    _controller.addListener(() {
      _checkSensitiveWords();
      checkMaxTitle();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CachedNetworkImage(
              imageUrl: feed.avatar,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageBuilder: (context, imageProvider) => Padding(
                padding: EdgeInsets.only(right: 2.w),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: imageProvider,
                    ),
                  ],
                ),
              ),
            ),
            Text(feed.fullName),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(7.sp),
                    child: Text(feed.content,style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20),),
                  ),
                  Stack(
                    children: [
                      (feed.imageUrls.length == 1)
                          ? buildSingleImage(context, feed.imageUrls[0])
                          : (feed.imageUrls.length == 2)
                              ? buildDoubleImage(
                                  context, feed.imageUrls[0], feed.imageUrls[1])
                              : (feed.imageUrls.length == 3)
                                  ? buildTripleImage(context, feed.imageUrls[0],
                                      feed.imageUrls[1], feed.imageUrls[2])
                                  : buildMultipleImage(context, feed.imageUrls)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.thumb_up,
                              color: feed.isLike ? Colors.red : null,
                            ),
                            onPressed: () {
                              likePost(feed.idFeed);
                              setState(() {
                                feed.isLike = !feed.isLike;
                                feed.likeCount += (feed.isLike ? 1 : -1);
                                print(feed.likeCount);
                              });
                            }),
                        const SizedBox(width: 5),
                        Text('${feed.likeCount} Likes'),
                        const SizedBox(width: 20),
                        const Icon(Icons.comment),
                        const SizedBox(width: 5),
                        Text('${feed.commentCount} Comments'),
                      ],
                    ),
                  ),
                  isLoadingComment
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: commentList.length,
                          itemBuilder: (context, index) {
                            GlobalKey commentKey = GlobalKey();
                            return ListTile(
                              onLongPress: () {
                                if (commentList[index].idUser == localIdUser) {
                                  showCommentContextMenu(
                                      context, commentList[index], commentKey);
                                }
                              },
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (builder) => ProfilePage(
                                      isMy: commentList[index].idUser ==
                                          localIdUser,
                                      idUser: commentList[index].idUser,
                                    ),
                                  ),
                                );
                              },
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(commentList[index].avatar),
                              ),
                              title: Text(
                                commentList[index].fullName,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
                              ),
                              subtitle: Text(commentList[index].content),
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                child: Card(
                  margin: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyMedium,
                    controller: _controller,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    minLines: 1,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          sendButton = true;
                        });
                      } else {
                        setState(() {
                          sendButton = false;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type a message",
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.only(
                          left: 4.w,
                          bottom: 1.5.h), // Adjust the padding value as needed
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                  right: 2,
                  left: 2,
                ),
                child: Visibility(
                  visible: sendButton,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color(0xFF128C7E),
                    child: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (sendButton) {
                          postComment(feed.idFeed,_controller.text);
                          CommentModel comment = CommentModel(
                              idComment: -1,
                              content: _controller.text,
                              idUser: localUser.id,
                              fullName: localUser.fullName,
                              avatar: localUser.avt);
                          commentList.add(comment);
                          setState(() {
                            ++feed.commentCount;
                            _controller.text = '';
                            sendButton = false;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
