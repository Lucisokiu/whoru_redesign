import 'package:flutter/material.dart';
import 'package:whoru/src/api/userInfo.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  // Controllers for text fields
  final TextEditingController oldPass = TextEditingController();
  final TextEditingController newPass = TextEditingController();
  final TextEditingController confirmPass = TextEditingController();

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    oldPass.dispose();
    newPass.dispose();
    confirmPass.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: oldPass,
            decoration: InputDecoration(labelText: 'Old Password'),
          ),
          SizedBox(height: 16),

          TextField(
            controller: newPass,
            decoration: InputDecoration(labelText: 'New Password'),
          ),
          SizedBox(height: 16),

          TextField(
            controller: confirmPass,
            decoration: InputDecoration(labelText: 'Confirm Password'),
          ),
          SizedBox(height: 16),


          // Button to post API
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                // postApi();
              },
              child: Text('Change Pass'),
            ),
          ),
        ],
      ),
    );
  }
  void postApi() {
    // final Map<String, String> requestData = {
    //   "fullName": fullNameController.text,
    //   "description": descriptionController.text,
    //   "work": workController.text,
    //   "study": studyController.text,
    // };
    // updateInfoUser(requestData);
    // print(requestData);
  }
}
