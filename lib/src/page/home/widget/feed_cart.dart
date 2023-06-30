import 'package:flutter/material.dart';
import 'package:whoru/src/model/feed.dart';

class CardFeed extends StatelessWidget {
  const CardFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (FeedModel feed in feedList)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    feed.content,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (String imageUrl in feed.imageUrls)
                          SizedBox(
                            width: 200, // Kích thước ảnh
                            height: 200, // Kích thước ảnh
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildButton(Icons.thumb_up, feed.likeCount.toString()),
                      _buildButton(
                          Icons.comment, feedList[0].commentCount.toString()),
                      _buildButton(
                          Icons.share, feedList[0].shareCount.toString()),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildButton(IconData icon, String label) {
    return Expanded(
      child: InkWell(
        onTap: () {
          // TODO: Implement button action
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
      ),
    );
  }
}
