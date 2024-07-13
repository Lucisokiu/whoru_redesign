import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/models/location_models.dart';

import '../../../models/user_model.dart';
import '../../../socket/web_socket_service.dart';
import '../../app.dart';

class CustomizeMarker extends StatelessWidget {
  final LatLng latLng;
  final int userId;
  final String avt;
  final String? note;

  const CustomizeMarker(
      {super.key,
      required this.latLng,
      required this.userId,
      required this.avt,
      this.note});

  void showMenu(BuildContext context) {
    WebSocketService webSocketService = WebSocketService();

    final TextEditingController titleController = TextEditingController();
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
    Future<void> _saveNote(text) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('note',text);
    }
    showDialog(
      context: context,
      builder: (BuildContext contextDialog) {
        return AlertDialog(
          title: const Text('Show your feelings'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: "Enter your text here"),
            onChanged: (value) {
              checkSensitiveWords();
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  webSocketService.sendMessageSocket(
                      "SendNote", [localIdUser, titleController.text]);
                  _saveNote(titleController.text);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(contextDialog).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter your feelings'),
                    ),
                  );
                }
              },
              child: const Text('POST'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CANCEL'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MarkerLayer(
          markers: [
            Marker(
              rotate: true,
              point: latLng,
              width: 45.w,
              height: 18.h,
              builder: (context) {
                return Stack(
                  children: [
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: avt,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        imageBuilder: (context, imageProvider) =>
                            CircleAvatar(backgroundImage: imageProvider),
                      ),
                    ),
                    note == null
                        ? userId == localIdUser
                            ? Positioned(
                                left: 23.w,
                                bottom: 10.h,
                                child: GestureDetector(
                                  onTap: () {
                                    showMenu(context);
                                    print(note);
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
                              child: Text(
                                note!,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                                softWrap: true,
                                overflow: TextOverflow.visible,
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
