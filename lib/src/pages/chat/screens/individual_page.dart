import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whoru/src/api/chat.dart';
import 'package:whoru/src/models/message_model.dart';
import 'package:whoru/src/models/user_chat.dart';
import 'package:whoru/src/pages/call/audiocall/audio_call_screen.dart';
import 'package:whoru/src/pages/call/videocall/video_call_creen.dart';
import 'package:whoru/src/pages/chat/widget/own_messenger_card.dart';
import 'package:whoru/src/pages/chat/widget/reply_card.dart';
import 'package:whoru/src/socket/web_socket_service.dart';


class IndividualPage extends StatefulWidget {
  const IndividualPage(
      {super.key, required this.user, required this.currentId});

  final UserChat user;
  final int currentId;

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  List<MessageModel> messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late StreamSubscription<dynamic> messageSubscription;
  WebSocketService webSocketService = WebSocketService();
  int page = 0;

  @override
  void initState() {
    super.initState();
    getChat();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () => _scrolldown());
      }
    });
  }

  void getChat() async {
    messages = await getAllChat(widget.user.idUser,++page);
    setState(() {
      _scrolldown();
      print("_scrolldown success");
    });
  }

  void _scrolldown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    _controller.clear();
    disconnect();
    super.dispose();
  }

  void connect() {


    messageSubscription = webSocketService.onMessage.listen(
      (event) {
        Map<dynamic, dynamic> jsonData = event;
        print("jsonData $jsonData");
        int type = jsonData['type'];
        if (type == 1) {
          String? target = jsonData['target'];
          if (target == "ReceiveMessage") {
            List<dynamic>? arguments = jsonData['arguments'];
            String message = arguments![0];
            int userSend = arguments[1];
            print("jsonData userSend $userSend");
            if (userSend == widget.user.idUser) {
              setMessage(message, userSend, widget.currentId);
              _scrolldown();
            }
          }
        }
      },
      onDone: () {
        debugPrint('ws channel closed');
      },
      onError: (error) {
        debugPrint('ws error $error');
      },
    );
  }

  void disconnect() {
    print("disconnect IndividualScreen");
    messageSubscription.cancel();
  }

  void sendMessage(WebSocketService webSocketService, String message,
      int sourceId, int targetId) {
    webSocketService
        .sendMessageSocket("SendMessage", [sourceId, targetId, message]);
    setMessage(message, widget.currentId, widget.user.idUser);
  }

  void setMessage(String message, int currentId, int idReceiver) {
    TimeOfDay now = TimeOfDay.now();

    MessageModel messageModel = MessageModel(
      date: "${now.hour}:${now.minute}",
      message: message,
      type: "Message",
      userSend: currentId,
      userReceive: idReceiver,
    );

    setState(() {
      messages.add(messageModel);
      print("setState");
    });
  }

  @override
  Widget build(BuildContext context) {
    // Image.network(
    //   "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/Group_font_awesome.svg/768px-Group_font_awesome.svg.png",
    //   height: MediaQuery.of(context).size.height,
    //   width: MediaQuery.of(context).size.width,
    //   fit: BoxFit.cover,
    // ),
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leadingWidth: 70,
          titleSpacing: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 24,
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blueGrey,
                  child: ClipOval(
                    child: Image.network(
                      widget.user.avatar,
                      height: 36,
                      width: 36,
                    ),
                  ),
                ),
              ],
            ),
          ),
          title: InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.fullName,
                    style: const TextStyle(
                      fontSize: 18.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Online",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  )
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
                icon: const Icon(Icons.videocam),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoCallScreen(
                        idUser: widget.user.idUser,
                        currentId: widget.currentId,
                      ),
                    ),
                  );
                }),
            IconButton(
                icon: const Icon(Icons.call),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AudioCallScreen(
                        avatar: widget.user.avatar,
                        fullName: widget.user.fullName,
                      ),
                    ),
                  );
                }),
            PopupMenuButton<String>(
              padding: const EdgeInsets.all(0),
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext contesxt) {
                return [
                  const PopupMenuItem(
                    value: "View Contact",
                    child: Text("View Contact"),
                  ),
                  const PopupMenuItem(
                    value: "Media, links, and docs",
                    child: Text("Media, links, and docs"),
                  ),
                  const PopupMenuItem(
                    value: "Whatsapp Web",
                    child: Text("Whatsapp Web"),
                  ),
                  const PopupMenuItem(
                    value: "Search",
                    child: Text("Search"),
                  ),
                  const PopupMenuItem(
                    value: "Mute Notification",
                    child: Text("Mute Notification"),
                  ),
                  const PopupMenuItem(
                    value: "Wallpaper",
                    child: Text("Wallpaper"),
                  ),
                ];
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                if (messages[index].userSend == widget.currentId) {
                  return GestureDetector(
                    onLongPress: () {
                      showMenu(
                        context: context,
                        position: const RelativeRect.fromLTRB(0, 0, 0, 0),
                        items: [
                          PopupMenuItem(
                            child: GestureDetector(
                              onTap: () {
                                // deleteCard(index);
                                Navigator.pop(context); // Ẩn pop-up menu
                              },
                              child: const Text("Xóa"),
                            ),
                          ),
                        ],
                      );
                    },
                    child: OwnMessageCard(
                      message: messages[index].message,
                      time: messages[index].date,
                    ),
                  );
                } else {
                  return ReplyCard(
                    message: messages[index].message,
                    time: messages[index].date,
                  );
                }
              },
              physics: const BouncingScrollPhysics(), // Sử dụng BouncingScrollPhysics
            ),
          ),
          SizedBox(
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      child: Card(
                        margin: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextFormField(
                          controller: _controller,
                          focusNode: focusNode,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          minLines: 1,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                sendButton = true;
                              });
                            } else {
                              setState(() {
                                sendButton = false;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message",
                            hintStyle: const TextStyle(color: Colors.grey),
                            prefixIcon: IconButton(
                              icon: Icon(
                                show
                                    ? Icons.keyboard
                                    : Icons.emoji_emotions_outlined,
                              ),
                              onPressed: () {
                                if (!show) {
                                  focusNode.unfocus();
                                  focusNode.canRequestFocus = false;
                                }
                                setState(() {
                                  show = !show;
                                });
                              },
                            ),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.attach_file),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (builder) => bottomSheet());
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.camera_alt),
                                  onPressed: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (builder) =>
                                    //             CameraApp()));
                                  },
                                ),
                              ],
                            ),
                            contentPadding: const EdgeInsets.all(5),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                        right: 2,
                        left: 2,
                      ),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: const Color(0xFF128C7E),
                        child: IconButton(
                          icon: Icon(
                            sendButton ? Icons.send : Icons.mic,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (sendButton) {
                              sendMessage(webSocketService, _controller.text,
                                  widget.currentId, widget.user.idUser);
                              _scrolldown();
                              setState(() {
                                _controller.text = '';
                                sendButton = false;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                // show ? emojiSelect() : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return SizedBox(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Document"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.location_pin, Colors.teal, "Location"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icons, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }

//   Widget emojiSelect() {
//     return EmojiPicker(
// textEditingController: _controller,
//         onEmojiSelected: (emoji, category) {
//           print(emoji);
//           setState(() {
//             _controller.text = _controller.text + emoji;
//           });
//         });
//   }
}
