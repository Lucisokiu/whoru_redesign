import 'package:flutter/material.dart';

import '../../../models/comment_model.dart';

class SingleFeedScreen extends StatefulWidget {
  const SingleFeedScreen({Key? key}) : super(key: key);

  @override
  State<SingleFeedScreen> createState() => _SingleFeedScreenState();
}

class _SingleFeedScreenState extends State<SingleFeedScreen> {
  // Sample data
  final String userName = 'John Doe';
  final String userAvatarUrl = 'https://via.placeholder.com/150';
  final String postImageUrl = 'https://via.placeholder.com/400';
  final int likes = 10;
  final List<CommentModel> commentList = [
    CommentModel(
      idComment: 1,
      content: 'Great post!',
      idUser: 1,
      fullName: 'Jane Smith',
      avatar: 'https://via.placeholder.com/50',
    ),
    CommentModel(
      idComment: 2,
      content: 'I love it!',
      idUser: 2,
      fullName: 'Michael Johnson',
      avatar: 'https://via.placeholder.com/50',
    ),
    CommentModel(
      idComment: 3,
      content: 'Keep up the good work!',
      idUser: 3,
      fullName: 'Emily Brown',
      avatar: 'https://via.placeholder.com/50',
    ),
    CommentModel(
      idComment: 3,
      content: 'Keep up the good work!',
      idUser: 3,
      fullName: 'Emily Brown',
      avatar: 'https://via.placeholder.com/50',
    ),
    CommentModel(
      idComment: 3,
      content: 'Keep up the good work!',
      idUser: 3,
      fullName: 'Emily Brown',
      avatar: 'https://via.placeholder.com/50',
    ),
    CommentModel(
      idComment: 3,
      content: 'Keep up the good work!',
      idUser: 3,
      fullName: 'Emily Brown',
      avatar: 'https://via.placeholder.com/50',
    ),
    CommentModel(
      idComment: 3,
      content: 'Keep up the good work!',
      idUser: 3,
      fullName: 'Emily Brown',
      avatar: 'https://via.placeholder.com/50',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single Feed'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User information
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(userAvatarUrl),
              ),
              title: Text(userName),
            ),
            // Post image
            Image.network(postImageUrl),
            // Like and comment count
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(Icons.thumb_up),
                  const SizedBox(width: 5),
                  Text('$likes Likes'),
                  const SizedBox(width: 20),
                  const Icon(Icons.comment),
                  const SizedBox(width: 5),
                  Text('${commentList.length} Comments'),
                ],
              ),
            ),
            // Comment section
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: commentList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(commentList[index].avatar),
                  ),
                  title: Text(commentList[index].fullName),
                  subtitle: Text(commentList[index].content),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
