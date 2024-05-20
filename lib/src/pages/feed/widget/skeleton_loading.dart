import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MySkeletonLoadingWidget extends StatelessWidget {
  const MySkeletonLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            leading: const CircleAvatar(
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
    );
  }
}