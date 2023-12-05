import 'package:flutter/material.dart';

Widget buildSingleImage(context, urlImage) {
  // final size = MediaQuery.of(context).size;

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
    ],
  );
}

Widget buildDoubleImage(context, urlImage1, urlImage2) {
  final size = MediaQuery.of(context).size;

  return ClipRRect(
    borderRadius: BorderRadius.circular(16.0),
    child: Row(
      children: [
        Expanded(
          child: SizedBox(
              height: size.height * .38,
              child: Image.network(
                urlImage1,
                fit: BoxFit.cover,
              )),
        ),
        const SizedBox(width: 2.0),
        Expanded(
          child: SizedBox(
              height: size.height * .38,
              child: Image.network(
                urlImage2,
                fit: BoxFit.cover,
              )),
        ),
      ],
    ),
  );
}

Widget buildTripleImage(context, urlImage1, urlImage2, urlImage3) {
  final size = MediaQuery.of(context).size;
  return ClipRRect(
    borderRadius: BorderRadius.circular(16.0),
    child: Row(
      children: [
        Expanded(
          flex: 6,
          child: SizedBox(
              height: size.height * .38,
              child: Image.network(
                urlImage1,
                fit: BoxFit.cover,
              )),
        ),
        const SizedBox(width: 2.0),
        Expanded(
          flex: 4,
          child: SizedBox(
            height: size.height * .38,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                      child: Image.network(
                    urlImage2,
                    fit: BoxFit.cover,
                  )),
                ),
                const SizedBox(height: 2.0),
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

Widget buildMultipleImage(context, List listImage) {
  final size = MediaQuery.of(context).size;
  return ClipRRect(
    borderRadius: BorderRadius.circular(16.0),
    child: Row(
      children: [
        Expanded(
          flex: 6,
          child: GestureDetector(
            onTap: () => print('image 01'),
            child: SizedBox(
                height: size.height * .30,
                child: Image.network(
                  listImage[0],
                  fit: BoxFit.cover,
                )),
          ),
        ),
        const SizedBox(width: 2.0),
        Expanded(
          flex: 4,
          child: SizedBox(
            height: size.height * .30,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                      child: Image.network(
                    listImage[1],
                    fit: BoxFit.cover,
                  )),
                ),
                const SizedBox(height: 2.0),
                Expanded(
                  child: Stack(
                    children: [
                      SizedBox(
                          height: size.height * .30,
                          child: Image.network(
                            listImage[2],
                            fit: BoxFit.cover,
                          )),
                      Container(
                        // height: _size.height * .30,
                        // width: _size.width * .36,
                        decoration: const BoxDecoration(
                          color: Colors.black26,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${listImage.length - 3}+',
                          style: TextStyle(
                            color: (Colors.white),
                            fontWeight: FontWeight.w400,
                            fontSize: size.width / 16.0,
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

class BuildButtonFeed extends StatefulWidget {
  IconData icon;
  int label;
  VoidCallback onPressed;
  bool? isLike;
  BuildButtonFeed({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isLike,
  });

  @override
  State<BuildButtonFeed> createState() => _BuildButtonFeedState();
}

class _BuildButtonFeedState extends State<BuildButtonFeed> {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (widget.isLike != null)
              ? IconButton(
                  icon: Icon(widget.icon),
                  color: widget.isLike! ? Colors.red : null,
                  onPressed: () {
                    widget.onPressed();
                    setState(() {
                      if (widget.isLike!) {
                        widget.label--;
                      } else {
                        widget.label++;
                      }
                      widget.isLike = !widget.isLike!;

                      print(widget.isLike);
                    });
                  },
                )
              : IconButton(
                  icon: Icon(widget.icon),
                  onPressed: () {
                    widget.onPressed;
                  },
                ),
          const SizedBox(width: 4),
          Text(widget.label.toString()),
        ],
    );
  }
}