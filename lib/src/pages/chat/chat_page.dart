import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../model/user.dart';
import 'widget/chat_screen.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.black,
                      size: 36,
                    )),
                const Text(
                  'Messages',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: ('Quicksand'),
                      fontSize: 30,
                      color: Colors.black),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 36,
                    ))
              ],
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Container(
                padding: EdgeInsets.fromLTRB(1.w, 0, 1.w, 0),

            child: Text(
              'R E C E N T',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: SizedBox(
                height: 12.h,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: Image.network(user.avt).image,
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            'Barry',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: Image.network(user.avt).image,
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            'Perez',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: Image.network(user.avt).image,
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            'Alvin',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: Image.network(user.avt).image,
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            'Dan',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: Image.network(user.avt).image,
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            'Fresh',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: Image.network(user.avt).image,
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            'Dish',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )
                        ],
                      ),
                    ]),
              ),
            ),
            
            SizedBox(
              height: 0.5.h,
            ),
            Flexible(
              child: Container(
                // height: 70.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.purple,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(2.0, 2.0),
                    ),
                    BoxShadow(
                      color: Colors.purple,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(-1.0, -1.0),
                    ),
                  ],
                ),
                child: ListView(
                    padding: EdgeInsets.only(bottom: 16), // Đặt khoảng cách theo chiều ngang
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen()));
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 26.0, top: 30, right: 10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: Image.network(user.avt).image,
                            ),
                            SizedBox(
                              width: 1.h,
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Danny Hopkins',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: ('Quicksand'),
                                          fontSize: 17),
                                    ),
                                    SizedBox(
                                      width: 100,
                                    ),
                                    Text(
                                      '08:43',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'dannylove@gmail.com',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 26.0, top: 30, right: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: Image.network(user.avt).image,
                          ),
                          SizedBox(
                            width: 1.h,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Bobby LangFod',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: ('Quicksand'),
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  Text(
                                    'Tue',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Will do,suer,thank you',
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 26.0, top: 30, right: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: Image.network(user.avt).image,
                          ),
                          SizedBox(
                            width: 1.h,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'William Wiles',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: ('Quicksand'),
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 120,
                                  ),
                                  Text(
                                    'Sun',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Uploded File',
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 26.0, top: 30, right: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: Image.network(user.avt).image,
                          ),
                          SizedBox(
                            width: 1.h,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'James Edlen',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: ('Quicksand'),
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 120,
                                  ),
                                  Text(
                                    '23 Mar',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Were is another tutorial",
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 26.0, top: 30, right: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: Image.network(user.avt).image,
                          ),
                          SizedBox(
                            width: 1.h,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'James Edlen',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: ('Quicksand'),
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 120,
                                  ),
                                  Text(
                                    '23 Mar',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Were is another tutorial",
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 26.0, top: 30, right: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: Image.network(user.avt).image,
                          ),
                          SizedBox(
                            width: 1.h,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'James Edlen',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: ('Quicksand'),
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 120,
                                  ),
                                  Text(
                                    '23 Mar',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Were is another tutorial",
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 26.0, top: 30, right: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: Image.network(user.avt).image,
                          ),
                          SizedBox(
                            width: 1.h,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'James Edlen',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: ('Quicksand'),
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 120,
                                  ),
                                  Text(
                                    '23 Mar',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Were is another tutorial",
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 26.0, top: 30, right: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: Image.network(user.avt).image,
                          ),
                          SizedBox(
                            width: 1.h,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'James Edlen',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: ('Quicksand'),
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 120,
                                  ),
                                  Text(
                                    '23 Mar',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Were is another tutorial",
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 26.0, top: 30, right: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: Image.network(user.avt).image,
                          ),
                          SizedBox(
                            width: 1.h,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'James Edlen',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: ('Quicksand'),
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 120,
                                  ),
                                  Text(
                                    '23 Mar',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Were is another tutorial",
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
