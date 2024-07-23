import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/models/location_models.dart';

import '../../../models/user_model.dart';
import '../../../socket/web_socket_service.dart';
import '../../../utils/shared_pref/location_note.dart';
import '../../app.dart';
import '../../splash/splash.dart';

class CustomizeMarker extends StatefulWidget {
  final LatLng latLng;
  final int userId;
  final String avt;
  final String note;

  const CustomizeMarker(
      {super.key,
      required this.latLng,
      required this.userId,
      required this.avt,
      required this.note});

  @override
  State<CustomizeMarker> createState() => _CustomizeMarkerState();
}

class _CustomizeMarkerState extends State<CustomizeMarker> {
  late String note;

  void showMenu(BuildContext context) {
    WebSocketService webSocketService = WebSocketService();

    final TextEditingController titleController = TextEditingController();
    // Function to load the note and set the controller's text
    Future<void> loadNote() async {
      titleController.text = note;
    }

    void checkSensitiveWords() {
      final text = titleController.text;
      final sanitizedText =
          text.replaceAllMapped(sensitiveWordPattern, (match) {
        return '*' * match.group(0)!.length;
      });

      if (text != sanitizedText) {
        titleController.value = titleController.value.copyWith(
          text: sanitizedText,
          selection: TextSelection.fromPosition(
            TextPosition(offset: sanitizedText.length),
          ),
        );
      }
    }

    loadNote();
    showDialog(
      context: context,
      builder: (BuildContext contextDialog) {
        return AlertDialog(
          title: Text('Show your feelings',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color)),
          content: TextField(
            style: Theme.of(context).textTheme.bodyMedium,
            controller: titleController,
            decoration: const InputDecoration(hintText: "Enter your text here"),
            onChanged: (value) {
              checkSensitiveWords();
            },
          ),
          actions: [
            if (note.isNotEmpty)
              TextButton(
                onPressed: () {
                  deleteNote().then((value) => fetchNote());
                  Navigator.of(context).pop();
                },
                child: const Text('Delete'),
              ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  webSocketService.sendMessageSocket(
                      "SendNote", [localIdUser, titleController.text]);
                  saveNote(titleController.text).then((value) => setState(() {
                        fetchNote();
                      }));
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(contextDialog).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter your feelings'),
                    ),
                  );
                }
              },
              child: Text('POST',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('CANCEL',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color)),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    note = widget.note;

    super.initState();
  }

  fetchNote() async {
    final result = await getNote();
    setState(() {
      note = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MarkerLayer(
          markers: [
            Marker(
              rotate: true,
              point: widget.latLng,
              width: 45.w,
              height: 18.h,
              builder: (context) {
                return Stack(
                  children: [
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: widget.avt,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        imageBuilder: (context, imageProvider) =>
                            CircleAvatar(backgroundImage: imageProvider),
                      ),
                    ),
                    note.isEmpty
                        ? widget.userId == localIdUser
                            ? Positioned(
                                left: 23.w,
                                bottom: 10.h,
                                child: GestureDetector(
                                  onTap: () {
                                    showMenu(context);
                                  },
                                  child: const Icon(
                                    Icons.add_circle,
                                    size: 24,
                                    color: Colors.blue,
                                  ),
                                ),
                              )
                            : Container()
                        : Positioned(
                            left: 25.w,
                            bottom: 11.h,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              constraints: BoxConstraints(
                                minWidth: 5.w,
                                maxWidth: 20.w,
                                maxHeight: 10.h,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(0),
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  if (widget.userId == localIdUser) {
                                    showMenu(context);
                                  }
                                },
                                child: Text(
                                  widget.note,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                          ),
                  ],
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
