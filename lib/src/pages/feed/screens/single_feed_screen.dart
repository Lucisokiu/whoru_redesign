import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/models/feed_model.dart';

import '../../../api/comment.dart';
import '../../../api/feed.dart';
import '../../../models/comment_model.dart';
import '../controller/build_image.dart';

class SingleFeedScreen extends StatefulWidget {
  final FeedModel? feedModel;
  final List<CommentModel>? commentModel;

  final int idPost;

  const SingleFeedScreen(
      {super.key, required this.idPost, this.commentModel, this.feedModel});

  @override
  State<SingleFeedScreen> createState() => _SingleFeedScreenState();
}

class _SingleFeedScreenState extends State<SingleFeedScreen> {
  FeedModel? feed;
  List<CommentModel>? commentList;
  int page = 1;

  Future<void> fetchData(int id) async {
    feed = widget.feedModel ?? await getPostById(id);
    commentList = widget.commentModel ?? await getCommentByIdFeed(id, page++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single Feed'),
      ),
      body: FutureBuilder(
          future: fetchData(widget.idPost),
          builder: (contextFutureBuilder, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).dividerColor,
                      color: Colors.black,
                    ),
                  ));
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User information
                    CachedNetworkImage(
                      imageUrl: feed!.avatar,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      imageBuilder: (context, imageProvider) => Padding(
                        padding: EdgeInsets.all(2.h),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: imageProvider,
                            ),
                            SizedBox(width: 2.h),
                            Text(feed!.fullName),
                          ],
                        ),
                      ),
                    ),
                    // Post image

                    Stack(
                      children: [
                        (feed!.imageUrls.length == 1)
                            ? buildSingleImage(context, feed!.imageUrls[0])
                            : (feed!.imageUrls.length == 2)
                                ? buildDoubleImage(context, feed!.imageUrls[0],
                                    feed!.imageUrls[1])
                                : (feed!.imageUrls.length == 3)
                                    ? buildTripleImage(
                                        context,
                                        feed!.imageUrls[0],
                                        feed!.imageUrls[1],
                                        feed!.imageUrls[2])
                                    : buildMultipleImage(
                                        context, feed!.imageUrls)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.thumb_up),
                          const SizedBox(width: 5),
                          Text('${feed!.likeCount} Likes'),
                          const SizedBox(width: 20),
                          const Icon(Icons.comment),
                          const SizedBox(width: 5),
                          Text('${feed!.commentCount} Comments'),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: commentList!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(commentList![index].avatar),
                          ),
                          title: Text(commentList![index].fullName),
                          subtitle: Text(commentList![index].content),
                        );
                      },
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
