import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/models/feed_model.dart';

import '../../../api/feed.dart';
import '../../../models/comment_model.dart';
import '../controller/build_image.dart';

class SingleFeedScreen extends StatefulWidget {
  late final FeedModel? feedModel;
  final int? idPost;

  SingleFeedScreen({super.key, this.feedModel, this.idPost}) {
    if (feedModel == null) {
      fetchData(idPost!);
      print(feedModel!.idFeed);
    }
  }

  Future<FeedModel?> fetchData(int id) async {
    feedModel = await getPostById(id);
    return feedModel;
  }

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
            CachedNetworkImage(
              imageUrl: widget.feedModel!.avatar,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageBuilder: (context, imageProvider) => Padding(
                padding: EdgeInsets.all(2.h),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: imageProvider,
                    ),
                    SizedBox(width: 2.h),
                    Text(widget.feedModel!.fullName),
                  ],
                ),
              ),
            ),
            // Post image

            Stack(
                children: [
                  (widget.feedModel!.imageUrls.length == 1)
                      ? buildSingleImage(context, widget.feedModel!.imageUrls[0])
                      : (widget.feedModel!.imageUrls.length == 2)
                          ? buildDoubleImage(context, widget.feedModel!.imageUrls[0],
                              widget.feedModel!.imageUrls[1])
                          : (widget.feedModel!.imageUrls.length == 3)
                              ? buildTripleImage(
                                  context,
                                  widget.feedModel!.imageUrls[0],
                                  widget.feedModel!.imageUrls[1],
                                  widget.feedModel!.imageUrls[2])
                              : buildMultipleImage(
                                  context, widget.feedModel!.imageUrls)
                ],
              ),
            // CachedNetworkImage(
            //   imageUrl: widget.feedModel!.imageUrls,
            //   placeholder: (context, url) =>
            //       const Center(child: CircularProgressIndicator()),
            //   errorWidget: (context, url, error) => const Icon(Icons.error),
            //   imageBuilder: (context, imageProvider) =>
            //       Image.network(postImageUrl),
            // ),
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
