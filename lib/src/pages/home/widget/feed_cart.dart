import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/model/feed.dart';
import 'dart:ui';

class CardFeed extends StatelessWidget {
  final FeedModel feedModel;
  const CardFeed({super.key, required this.feedModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, bottom: 10.0, top: 16.0),
          color: Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10.0), // Bán kính bo góc

              boxShadow: const [
                BoxShadow(
                  color: Colors.purple,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(2.0, 2.0),
                ),
                BoxShadow(
                  color: Colors.purple,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(-1.0, -1.0),
                ),
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 14.0, left: 15.0, right: 15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10.0, right: 16.0),
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        width: 60,
                        height: 60,
                        child: GestureDetector(
                          onTap: () {},
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(70),
                            child: Image.network(
                              feedModel.userModel.avt,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        feedModel.userModel.username,
                        style: const TextStyle(
                          fontSize: 18, // Kích thước chữ lớn hơn mặc định
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            color: Colors.black,
                            PhosphorIcons.fill.dotsThreeOutlineVertical,
                            // PhosphorIcons.chatCircleFill,

                            size: 20.0,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        feedModel.content,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Stack(
                    children: [
                      (feedModel.imageUrls.length == 1)
                          ? _buildSingleImage(context, feedModel.imageUrls[0])
                          : (feedModel.imageUrls.length == 2)
                              ? _buildDoubleImage(
                                  context,
                                  feedModel.imageUrls[0],
                                  feedModel.imageUrls[1])
                              : (feedModel.imageUrls.length == 3)
                                  ? _buildTripleImage(
                                      context,
                                      feedModel.imageUrls[0],
                                      feedModel.imageUrls[1],
                                      feedModel.imageUrls[2])
                                  : _buildMultipleImage(
                                      context, feedModel.imageUrls)
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(width: 5.0),
                      _buildButton(
                          PhosphorIcons.thin.heart,
                          // PhosphorIcons.chatCircleFill,
                          feedModel.likeCount.toString()),
                      SizedBox(width: 5.0),
                      _buildButton(
                          PhosphorIcons.thin.chatTeardrop,
                          // PhosphorIcons.chatCircleFill,
                          feedModel.commentCount.toString()),
                      Spacer(),
                      _buildButton(
                          PhosphorIcons.thin.shareFat,
                          // PhosphorIcons.chatCircleFill,
                          feedModel.shareCount.toString()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(IconData icon, String label) {
    return Container(
      // height: 50,
      // width: 50,
      child: InkWell(
        onTap: () {
          print("click");
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
            ),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleImage(context, urlImage) {
    final _size = MediaQuery.of(context).size;

    return Stack(
      // fit: StackFit.fill,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            // height: _size.height * .42,
            color: Colors.grey.withOpacity(0.1),
            alignment: Alignment.center,
            child: Image.network(
              urlImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Container(
        //     constraints: BoxConstraints(
        //       maxHeight: _size.height * .42,
        //       maxWidth: _size.width,
        //     ),
        //     alignment: Alignment.topCenter,
        //     child: Image.network(
        //       urlImage,
        //       fit: BoxFit.cover,
        //     )),
      ],
    );
  }

  Widget _buildDoubleImage(context, urlImage1, urlImage2) {
    final _size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
                height: _size.height * .38,
                child: Image.network(
                  urlImage1,
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(width: 2.0),
          Expanded(
            child: Container(
                height: _size.height * .38,
                child: Image.network(
                  urlImage2,
                  fit: BoxFit.cover,
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildTripleImage(context, urlImage1, urlImage2, urlImage3) {
    final _size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
                height: _size.height * .38,
                child: Image.network(
                  urlImage1,
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(width: 2.0),
          Expanded(
            flex: 4,
            child: Container(
              height: _size.height * .38,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                        child: Image.network(
                      urlImage2,
                      fit: BoxFit.cover,
                    )),
                  ),
                  SizedBox(height: 2.0),
                  Expanded(
                    child: Container(
                        child: Image.network(
                      urlImage3,
                      fit: BoxFit.cover,
                    )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMultipleImage(context, List listImage) {
    final _size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: GestureDetector(
              onTap: () => print('image 01'),
              child: Container(
                  height: _size.height * .30,
                  child: Image.network(
                    listImage[0],
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          SizedBox(width: 2.0),
          Expanded(
            flex: 4,
            child: Container(
              height: _size.height * .30,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                        child: Image.network(
                      listImage[1],
                      fit: BoxFit.cover,
                    )),
                  ),
                  SizedBox(height: 2.0),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                            height: _size.height * .30,
                            child: Image.network(
                              listImage[2],
                              fit: BoxFit.cover,
                            )),
                        Container(
                          // height: _size.height * .30,
                          // width: _size.width * .36,
                          decoration: BoxDecoration(
                            color: Colors.black26,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${listImage.length - 3}+',
                            style: TextStyle(
                              color: (Colors.white),
                              fontWeight: FontWeight.w400,
                              fontSize: _size.width / 16.0,
                              fontFamily: 'Lato',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
