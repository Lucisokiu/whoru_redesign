import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SuggestionCard extends StatefulWidget {
  final int id;
  final String name;
  final String avt;
  const SuggestionCard(
      {super.key, required this.id, required this.name, required this.avt});

  @override
  State<SuggestionCard> createState() => _SuggestionCardState();
}

class _SuggestionCardState extends State<SuggestionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.h,
      padding: const EdgeInsets.only(
          left: 16.0, right: 16.0, bottom: 10.0, top: 16.0),
      // color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(2.0, 2.0),
            ),
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(-1.0, -1.0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 14.0, left: 15.0, right: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10.0, right: 5.0),
                decoration: const BoxDecoration(shape: BoxShape.circle),
                width: 60,
                height: 60,
                child: GestureDetector(
                  onTap: () {},
                  child: CachedNetworkImage(
                    imageUrl: widget.avt,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: imageProvider,
                      radius: 30,
                    ),
                  ),
                ),
              ),
              Text(
                widget.name,
                style: const TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              ElevatedButton(
                style: Theme.of(context).iconButtonTheme.style,
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.person_add,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text(
                      "Follow",
                      style:
                          TextStyle(color: Theme.of(context).iconTheme.color),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
