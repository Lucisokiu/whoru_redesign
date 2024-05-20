import 'package:flutter/material.dart';
import 'package:whoru/src/api/log.dart';

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
            decoration: const InputDecoration(labelText: 'Old Password'),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: newPass,
            decoration: const InputDecoration(labelText: 'New Password'),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: confirmPass,
            decoration: const InputDecoration(labelText: 'Confirm Password'),
          ),
          const SizedBox(height: 16),


          // Button to post API
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                if(newPass.text == confirmPass.text){
                postApi(newPass.text);
                Navigator.pop(context);
                }
              },
              child: const Text('Change Pass'),
            ),
          ),
        ],
      ),
    );
  }
  void postApi(newPass) {
    changePass(newPass);
  }
}
