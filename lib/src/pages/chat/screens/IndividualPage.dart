import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whoru/src/api/chat.dart';
import 'package:whoru/src/model/MessageModel.dart';
import 'package:whoru/src/model/UserChat.dart';
import 'package:whoru/src/pages/call/audiocall/AudioCallScreen.dart';
import 'package:whoru/src/pages/call/videocall/VideoCallScreen.dart';
import 'package:whoru/src/pages/chat/widget/OwnMessengerCard.dart';
import 'package:whoru/src/pages/chat/widget/ReplyCard.dart';
import 'package:whoru/src/socket/WebSocketService.dart';

class IndividualPage extends StatefulWidget {
  const IndividualPage(
      {super.key,
      required this.webSocketService,
      required this.user,
      required this.currentId});

  final WebSocketService webSocketService;
  final UserChat user;
  final int currentId;

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  List<MessageModel> messages = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  late StreamSubscription<dynamic> messageSubscription;


  @override
  void initState() {
    super.initState();
    getChat();
    connect();
    focusNode.addListener(() {
      if(focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () =>
        _scrolldown()
        );
      }
    });
  }

  void getChat() async {
    messages = await getAllChat(widget.user.idUser);
      setState(() {
        _scrolldown();
        print("_scrolldown success");
      });
  }
  void _scrolldown(){
    _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
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
    messageSubscription = widget.webSocketService.onMessage.listen(
      (event) {
        var receivedMessage = event.replaceAll(String.fromCharCode(0x1E), '');
        Map<dynamic, dynamic> jsonData = jsonDecode(receivedMessage);
        print("jsonData $jsonData");
        int type = jsonData['type'];
        if (type == 1) {
          String? target = jsonData['target'];
          if (target == "ReceiveMessage") {
            List<dynamic>? arguments = jsonData['arguments'];
            String message = arguments![0];
            int userSend = arguments[1];
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
        preferredSize: Size.fromHeight(60),
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
                Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 24,
                ),
                CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      widget.user.avatar,
                      height: 36,
                      width: 36,
                    ),
                  ),
                  radius: 20,
                  backgroundColor: Colors.blueGrey,
                ),
              ],
            ),
          ),
          title: InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.fullName,
                    style: TextStyle(
                      fontSize: 18.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
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
                icon: Icon(Icons.videocam),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoCallScreen(
                        idUser: widget.user.idUser,
                        currentId: widget.currentId,
                        webSocketService: widget.webSocketService,
                      ),
                    ),
                  );
                }),
            IconButton(
                icon: Icon(Icons.call),
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
              padding: EdgeInsets.all(0),
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext contesxt) {
                return [
                  PopupMenuItem(
                    child: Text("View Contact"),
                    value: "View Contact",
                  ),
                  PopupMenuItem(
                    child: Text("Media, links, and docs"),
                    value: "Media, links, and docs",
                  ),
                  PopupMenuItem(
                    child: Text("Whatsapp Web"),
                    value: "Whatsapp Web",
                  ),
                  PopupMenuItem(
                    child: Text("Search"),
                    value: "Search",
                  ),
                  PopupMenuItem(
                    child: Text("Mute Notification"),
                    value: "Mute Notification",
                  ),
                  PopupMenuItem(
                    child: Text("Wallpaper"),
                    value: "Wallpaper",
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
                        position: RelativeRect.fromLTRB(0, 0, 0, 0),
                        items: [
                          PopupMenuItem(
                            child: GestureDetector(
                              onTap: () {
                                // deleteCard(index);
                                Navigator.pop(
                                    context); // Ẩn pop-up menu
                              },
                              child: Text("Xóa"),
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
              physics:
                  BouncingScrollPhysics(), // Sử dụng BouncingScrollPhysics
            ),
          ),
          Container(
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 60,
                      child: Card(
                        margin: EdgeInsets.only(
                            left: 2, right: 2, bottom: 8),
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
                            if (value.length > 0) {
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
                            hintStyle: TextStyle(color: Colors.grey),
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
                                  icon: Icon(Icons.attach_file),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        backgroundColor:
                                            Colors.transparent,
                                        context: context,
                                        builder: (builder) =>
                                            bottomSheet());
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.camera_alt),
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
                            contentPadding: EdgeInsets.all(5),
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
                        backgroundColor: Color(0xFF128C7E),
                        child: IconButton(
                          icon: Icon(
                            sendButton ? Icons.send : Icons.mic,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (sendButton) {
                              sendMessage(
                                  widget.webSocketService,
                                  _controller.text,
                                  widget.currentId,
                                  widget.user.idUser);
                              _scrolldown();
                              setState(() {
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
    return Container(
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
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.location_pin, Colors.teal, "Location"),
                  SizedBox(
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
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
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
