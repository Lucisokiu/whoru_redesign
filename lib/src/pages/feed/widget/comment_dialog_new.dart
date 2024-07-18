import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/pages/app.dart';
import 'package:whoru/src/pages/profile/profile_screen.dart';
import '../../../api/comment.dart';
import '../../../models/comment_model.dart';
import '../../splash/splash.dart';

Future<Object?> customCommentDialog(
    BuildContext contextScafford, int idFeed, int currentUser) {
  return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Comment",
      context: contextScafford,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween =
            Tween(begin: const Offset(0, -1), end: Offset.zero);
        return SlideTransition(
            position: tween.animate(
                CurvedAnimation(parent: animation, curve: Curves.easeIn)),
            child: child);
      },
      pageBuilder: (context, _, __) => CustomCommentDialog(
          contextScafford: contextScafford,
          idFeed: idFeed,
          currentUser: currentUser));
}

class CustomCommentDialog extends StatefulWidget {
  final BuildContext contextScafford;
  final int idFeed;
  final int currentUser;

  const CustomCommentDialog(
      {super.key,
      required this.contextScafford,
      required this.idFeed,
      required this.currentUser});

  @override
  State<CustomCommentDialog> createState() => _CustomCommentDialogState();
}

class _CustomCommentDialogState extends State<CustomCommentDialog> {
  final TextEditingController _controller = TextEditingController();
  List<CommentModel> comments = [];
  int page = 1;
  bool isFull = false;
  bool sendButton = false;

  @override
  void initState() {
    super.initState();
    fetchData();
    _controller.addListener(() {
      _checkSensitiveWords();
      checkMaxTitle();
    });
  }

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

  fetchData() async {
    List<CommentModel> commentsPage =
        (await getCommentByIdFeed(widget.idFeed, page++));
    if (commentsPage.isEmpty) isFull = true;

    comments.addAll(commentsPage);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width * 0.9,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Comment",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 24),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      GlobalKey commentKey = GlobalKey();
                      if (isFull == false && index == comments.length) {
                        fetchData();
                        return const CircularProgressIndicator();
                      }
                      return ListTile(
                        key: commentKey,
                        onLongPress: () {
                          if (comments[index].idUser == widget.currentUser) {
                            showCommentContextMenu(
                                context, comments[index], commentKey);
                          }
                        },
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => ProfilePage(
                                isMy: comments[index].idUser ==
                                    widget.currentUser,
                                idUser: comments[index].idUser,
                              ),
                            ),
                          );
                        },
                        leading: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => ProfilePage(
                                  isMy: comments[index].idUser == localIdUser,
                                  idUser: comments[index].idUser,
                                ),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(comments[index].avatar),
                          ),
                        ),
                        title: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comments[index].fullName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontSize: 18),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                comments[index].content,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 32.w,
                      child: Card(
                        margin:
                            const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 0, top: 0, left: 20.0),
                          child: TextFormField(
                            style: Theme.of(context).textTheme.bodyMedium,
                            controller: _controller,
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
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type a message",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
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
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: const Color(0xFF128C7E),
                        child: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            postComment(widget.idFeed, _controller.text);

                            if (sendButton) {
                              setState(() {
                                _controller.text = '';
                                sendButton = false;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

void showCommentContextMenu(
    BuildContext context, CommentModel comment, GlobalKey commentKey) async {
  final RenderBox renderBox =
      commentKey.currentContext!.findRenderObject() as RenderBox;
  final Offset offset = renderBox.localToGlobal(Offset.zero);

  final result = await showMenu(
    context: context,
    position: RelativeRect.fromRect(
      Rect.fromPoints(
        offset,
        Offset(offset.dx * 2 + renderBox.size.width,
            offset.dy + renderBox.size.height),
      ),
      Offset.zero & MediaQuery.of(context).size,
    ),
    items: [
      const PopupMenuItem(
        value: 'delete',
        child: Text('Delete'),
      ),
    ],
  );

  // Handle the selected option
  if (result == 'delete') {
    deleteComment(comment.idComment);
    print('Deleting comment: ${comment.content}');
  }
}
