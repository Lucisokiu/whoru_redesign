import 'package:flutter/material.dart';

void showCommentDialog(
    BuildContext context, List<Map<String, dynamic>> comments) {
  final FocusNode focusNode = FocusNode();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      GlobalKey commentKey = GlobalKey();
                      return ListTile(
                        key: commentKey,
                        onLongPress: () {
                          showCommentContextMenu(
                              context, comments[index], commentKey);
                        },
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(comments[index]['avatar']),
                        ),
                        title: Text(
                          comments[index]['comment'],
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
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Implement the logic to handle the new comment submission
                    // For now, let's just print the entered comment
                    print('New Comment: ${focusNode.hasFocus}');
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  FocusScope.of(context).requestFocus(focusNode);
}

void showCommentContextMenu(BuildContext context, Map<String, dynamic> comment,
    GlobalKey commentKey) async {
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
    // Implement the logic to delete the comment
    print('Deleting comment: ${comment['comment']}');
  }
}
