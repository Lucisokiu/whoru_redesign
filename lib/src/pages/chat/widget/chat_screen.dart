import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/model/user.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: EdgeInsets.only(left: 14.0, right: 14),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 36,
                      )),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: Image.network(user.avt).image,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    'Danny Hopkins',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: ('Quicksand'),
                        color: Colors.white),
                  ),
                  Spacer(),
                  const Icon(
                    Icons.search_rounded,
                    color: Colors.white70,
                    size: 40,
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              const Center(
                child: Text(
                  '1 FEB 12:00',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: Image.network(user.avt).image,
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Container(
                    // width: 70.w,
                    constraints:
                        BoxConstraints(maxWidth: 70.w), // Độ dài tối đa

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xff373E4E)),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'I commented on Figma, I want to add sjdiw weosjwy cys sow woois ijwdwd wysxtajsd',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    // width: 70.w,
                    constraints:
                        BoxConstraints(maxWidth: 70.w), // Độ dài tối đa

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xff7A8194)),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'I commented on Figma, I want to add sjdiw weosjwy',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: Image.network(user.avt).image,
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xff373E4E)),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Next Month',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  '08:12',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    // width: 70.w,
                    constraints:
                        BoxConstraints(maxWidth: 70.w), // Độ dài tối đa

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xff7A8194)),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'I commented on Figma, I want to add sjdiw weosjwy',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    constraints:
                        BoxConstraints(maxWidth: 70.w), // Độ dài tối đa

                    // width: 70.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xff7A8194)),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        '?',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xff3D4354)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.white30,
                              borderRadius: BorderRadius.circular(50)),
                          child: Icon(Icons.camera_alt_outlined),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      const Text(
                        'Message',
                        style: TextStyle(color: Colors.white54),
                      ),
                      Spacer(),
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.send,
                          color: Colors.white54,
                        ),
                      ),
                    ],

                    ///thankyou alll of youuuuuu se you next tutorial
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
