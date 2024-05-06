import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MySkeletonLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30,
              ),
              title: Container(
                height: 16,
                width: double.infinity,
                color: Colors.white,
              ),
              subtitle: Container(
                height: 12,
                width: double.infinity,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}