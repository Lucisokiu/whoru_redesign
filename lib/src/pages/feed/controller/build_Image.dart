import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

Widget buildSingleImage(BuildContext context, String urlImage) {
  final size = MediaQuery.of(context).size;

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: PhotoViewGallery.builder(
              itemCount: 1,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(urlImage),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 2,
                );
              },
              scrollPhysics: const BouncingScrollPhysics(),
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
              pageController: PageController(),
            ),
          ),
        ),
      );
    },

    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: SizedBox(
            height: size.height * 0.3,
            child: Image.network(
              urlImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildDoubleImage(
    BuildContext context, String urlImage1, String urlImage2) {
  final size = MediaQuery.of(context).size;

  return ClipRRect(
    borderRadius: BorderRadius.circular(16.0),
    child: Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhotoViewGallery.builder(
                    itemCount: 2,
                    builder: (context, index) {
                      return PhotoViewGalleryPageOptions(
                        imageProvider:
                            NetworkImage(index == 0 ? urlImage1 : urlImage2),
                        minScale: PhotoViewComputedScale.contained * 0.8,
                        maxScale: PhotoViewComputedScale.covered * 2,
                      );
                    },
                    scrollPhysics: const BouncingScrollPhysics(),
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    pageController: PageController(),
                  ),
                ),
              );
            },
            child: SizedBox(
              height: size.height * 0.38,
              child: Image.network(
                urlImage1,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 2.0),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhotoViewGallery.builder(
                    itemCount: 2,
                    builder: (context, index) {
                      return PhotoViewGalleryPageOptions(
                        imageProvider:
                            NetworkImage(index == 0 ? urlImage1 : urlImage2),
                        minScale: PhotoViewComputedScale.contained * 0.8,
                        maxScale: PhotoViewComputedScale.covered * 2,
                      );
                    },
                    scrollPhysics: const BouncingScrollPhysics(),
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    pageController: PageController(initialPage: 1),
                  ),
                ),
              );
            },
            child: SizedBox(
              height: size.height * 0.38,
              child: Image.network(
                urlImage2,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildTripleImage(BuildContext context, String urlImage1,
    String urlImage2, String urlImage3) {
  final size = MediaQuery.of(context).size;

  return ClipRRect(
    borderRadius: BorderRadius.circular(16.0),
    child: Row(
      children: [
        Expanded(
          flex: 6,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhotoViewGallery.builder(
                    itemCount: 1,
                    builder: (context, index) {
                      return PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(urlImage1),
                        minScale: PhotoViewComputedScale.contained * 0.8,
                        maxScale: PhotoViewComputedScale.covered * 2,
                      );
                    },
                    scrollPhysics: const BouncingScrollPhysics(),
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    pageController: PageController(),
                  ),
                ),
              );
            },
            child: SizedBox(
              height: size.height * 0.30,
              child: Image.network(
                urlImage1,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 2.0),
        Expanded(
          flex: 4,
          child: SizedBox(
            height: size.height * 0.30,
            child: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhotoViewGallery.builder(
                            itemCount: 1,
                            builder: (context, index) {
                              return PhotoViewGalleryPageOptions(
                                imageProvider: NetworkImage(urlImage2),
                                minScale:
                                    PhotoViewComputedScale.contained * 0.8,
                                maxScale: PhotoViewComputedScale.covered * 2,
                              );
                            },
                            scrollPhysics: const BouncingScrollPhysics(),
                            backgroundDecoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            pageController: PageController(),
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: size.width * 0.35,
                      child: Image.network(
                        urlImage2,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhotoViewGallery.builder(
                            itemCount: 1,
                            builder: (context, index) {
                              return PhotoViewGalleryPageOptions(
                                imageProvider: NetworkImage(urlImage3),
                                minScale:
                                    PhotoViewComputedScale.contained * 0.8,
                                maxScale: PhotoViewComputedScale.covered * 2,
                              );
                            },
                            scrollPhysics: const BouncingScrollPhysics(),
                            backgroundDecoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            pageController: PageController(),
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: size.width * 0.35,
                      child: Image.network(
                        urlImage3,
                        fit: BoxFit.cover,
                      ),
                    ),
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

Widget buildMultipleImage(BuildContext context, List<String> listImage) {
  final size = MediaQuery.of(context).size;

  return ClipRRect(
    borderRadius: BorderRadius.circular(16.0),
    child: Row(
      children: [
        Expanded(
          flex: 6,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhotoViewGallery.builder(
                    itemCount: 1,
                    builder: (context, index) {
                      return PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(listImage[0]),
                        minScale: PhotoViewComputedScale.contained * 0.8,
                        maxScale: PhotoViewComputedScale.covered * 2,
                      );
                    },
                    scrollPhysics: const BouncingScrollPhysics(),
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    pageController: PageController(),
                  ),
                ),
              );
            },
            child: SizedBox(
              height: size.height * 0.30,
              child: Image.network(
                listImage[0],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 2.0),
        Expanded(
          flex: 4,
          child: SizedBox(
            height: size.height * 0.30,
            child: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhotoViewGallery.builder(
                            itemCount: 1,
                            builder: (context, index) {
                              return PhotoViewGalleryPageOptions(
                                imageProvider: NetworkImage(listImage[1]),
                                minScale:
                                    PhotoViewComputedScale.contained * 0.8,
                                maxScale: PhotoViewComputedScale.covered * 2,
                              );
                            },
                            scrollPhysics: const BouncingScrollPhysics(),
                            backgroundDecoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            pageController: PageController(),
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: size.width * 0.35,
                      child: Image.network(
                        listImage[1],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhotoViewGallery.builder(
                            itemCount: listImage.length - 2,
                            builder: (context, index) {
                              return PhotoViewGalleryPageOptions(
                                imageProvider:
                                    NetworkImage(listImage[index + 2]),
                                minScale:
                                    PhotoViewComputedScale.contained * 0.8,
                                maxScale: PhotoViewComputedScale.covered * 2,
                              );
                            },
                            scrollPhysics: const BouncingScrollPhysics(),
                            backgroundDecoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            pageController: PageController(),
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Center(
                          child: SizedBox(
                            height: size.height * 0.20,
                            width: size.width * 0.35,
                            child: Image.network(
                              listImage[2],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            height: size.height * 0.15,
                            width: size.width * 0.35,
                            decoration: const BoxDecoration(
                              color: Colors.black26,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${listImage.length - 3}+',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: size.width / 16.0,
                                fontFamily: 'Lato',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

class BuildButtonFeed extends StatefulWidget {
  final IconData icon;
  final int label;
  final VoidCallback onPressed;
  final VoidCallback onLongPress;
  final bool? isLike;

  const BuildButtonFeed({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.onLongPress,
    this.isLike,
  });

  @override
  State<BuildButtonFeed> createState() => _BuildButtonFeedState();
}

class _BuildButtonFeedState extends State<BuildButtonFeed> {
  @override
  Widget build(BuildContext context) {
      int label = widget.label;
      bool? isLike = widget.isLike;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (isLike != null)
            ? GestureDetector(
                // Wrap IconButton with GestureDetector
                onLongPress: widget.onLongPress, // Add this line
                child: IconButton(
                  icon: Icon(widget.icon),
                  color: isLike ? Colors.red : null,
                  onPressed: () {
                    widget.onPressed();

                    setState(() {
                      if (isLike!) {
                        label--;
                      } else {
                        label++;
                      }
                      isLike = !isLike!;

                      print(isLike);
                    });
                  },
                ),
              )
            : GestureDetector(
                onLongPress: widget.onLongPress, // Add this line
                child: IconButton(
                  icon: Icon(widget.icon),
                  onPressed: () {
                    widget.onPressed();
                  },
                ),
              ),
        const SizedBox(width: 4),
        Text(label.toString()),
      ],
    );
  }
}
