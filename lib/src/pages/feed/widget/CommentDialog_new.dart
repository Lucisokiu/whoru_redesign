import 'package:flutter/material.dart';
import 'package:whoru/src/pages/feed/widget/CommentDialog.dart';
import '../../../api/comment.dart';
import '../../../model/CommentModel.dart';

Future<Object?> customCommentDialog(BuildContext contextScafford,
    List<CommentModel>? comments, int idFeed, int CurrentUser) {
  return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Sign up",
      context: contextScafford,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween = Tween(begin: Offset(0, -1), end: Offset.zero);
        return SlideTransition(
            position: tween.animate(
                CurvedAnimation(parent: animation, curve: Curves.easeIn)),
            child: child);
      },
      pageBuilder: (context, _, __) => CustomCommentDialog(
          contextScafford: contextScafford,
          comments: comments,
          idFeed: idFeed,
          currentUser: CurrentUser)).then((value) => null);
}

class CustomCommentDialog extends StatefulWidget {
  final BuildContext contextScafford;
  final List<CommentModel>? comments;
  final int idFeed;
  final int currentUser;

  CustomCommentDialog(
      {super.key,
      required this.contextScafford,
      required this.comments,
      required this.idFeed,
      required this.currentUser});

  @override
  State<CustomCommentDialog> createState() => _CustomCommentDialogState();
}

class _CustomCommentDialogState extends State<CustomCommentDialog> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width / 2,
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
                  Text("Comment"),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.comments!.length,
                  itemBuilder: (context, index) {
                    GlobalKey commentKey = GlobalKey();
                    return ListTile(
                      key: commentKey,
                      onLongPress: () {
                        if (widget.comments![index].idUser ==
                            widget.currentUser) {
                          showCommentContextMenu(
                              context, widget.comments![index], commentKey);
                        }
                      },
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.comments![index].avatar),
                      ),
                      title: Text(
                        widget.comments![index].content,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  },
                ),
              ),
              Focus(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your comment...',
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                  controller: _controller,
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  PostComment(widget.idFeed, _controller.text);
                  print('New Comment: ${_controller.text}');
                  Navigator.pop(context);
                },
                child: Text('Submit'),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
