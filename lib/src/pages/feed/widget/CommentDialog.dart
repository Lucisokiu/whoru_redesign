import 'package:flutter/material.dart';
import 'package:whoru/src/api/comment.dart';
import 'package:whoru/src/model/CommentModel.dart';

void showCommentDialog(BuildContext context, List<CommentModel>? comments,
    int idFeed, int CurrentUser) {
  final FocusNode focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return Dialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                      itemCount: comments!.length,
                      itemBuilder: (context, index) {
                        GlobalKey commentKey = GlobalKey();
                        return ListTile(
                          key: commentKey,
                          onLongPress: () {
                            if (comments[index].idUser == CurrentUser) {
                              showCommentContextMenu(
                                  context, comments[index], commentKey);
                            }
                          },
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(comments[index].avatar),
                          ),
                          title: Text(
                            comments[index].content,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Focus(
                    focusNode: focusNode,
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
                      PostComment(idFeed, _controller.text);
                      print('New Comment: ${_controller.text}');
                      Navigator.pop(context);
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    },
  );

  FocusScope.of(context).requestFocus(focusNode);
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
      PopupMenuItem(
        value: 'delete',
        child: Text('Delete'),
      ),
    ],
  );

  // Handle the selected option
  if (result == 'delete') {
    DeleteComment(comment.idComment);
    print('Deleting comment: ${comment.content}');
  }
}
