import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/models/feed_model.dart';
import 'package:whoru/src/pages/feed/screens/single_feed_screen.dart';

import '../../../api/feed.dart';
import '../../../utils/token.dart';

class PhotoProfile1 extends StatefulWidget {
  const PhotoProfile1({super.key});

  @override
  State<PhotoProfile1> createState() => _PhotoProfile1State();
}

class _PhotoProfile1State extends State<PhotoProfile1>
    with AutomaticKeepAliveClientMixin {
  List<FeedModel> allPost = [];
  int page = 1;
  bool _isLoading = false;
  bool isMaxPage = false;
  fetchData() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    print("page $page");
    int? idUser = await getIdUser();
    List<FeedModel>? result = await getAllPostById(idUser!, page++);

    if (result != null) {
      if (mounted) {
        if (result.isEmpty) {
          setState(() {
            isMaxPage = true;
          });
        }
        allPost.addAll(result);
        print("added");
      }
    }
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return allPost.isEmpty && _isLoading
        ? Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).dividerColor,
                color: Colors.black,
              ),
            ),
          )
        : GridView.builder(
            addAutomaticKeepAlives: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 2.0,
              // childAspectRatio: 1.1,
            ),
            itemBuilder: (BuildContext context, int index) {
              if (!isMaxPage) {
                if (index == allPost.length) {
                  if (_isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return TextButton(
                        onPressed: () {
                          fetchData();
                        },
                        child: Row(
                          children: [
                            Icon(PhosphorIcons.plus()),
                            const Text("Load More"),
                          ],
                        ));
                  }
                }
              }

              for (final imageUrl in allPost[index].imageUrls) {
                return Padding(
                  padding: const EdgeInsets.only(left: 1),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SingleFeedScreen(),
                        ),
                      );
                    },
                    child: yourPicture(context, imageUrl),
                  ),
                );
              }
              return null;
            },
            itemCount: allPost.length + (isMaxPage ? 0 : 1),
          );
  }

  @override
  bool get wantKeepAlive => true;
}

Widget yourPicture(BuildContext context, urlImage) {
  return CachedNetworkImage(
    imageUrl: urlImage,
    placeholder: (context, url) =>
        const Center(child: CircularProgressIndicator()),
    errorWidget: (context, url, error) => const Icon(Icons.error),
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 0.2.w,
        ),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.fill,
        ),
      ),
      // height: 10.5.h,
    ),
  );
}
