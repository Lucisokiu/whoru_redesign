import 'package:flutter/material.dart';
import 'package:whoru/src/api/user_info.dart';

class UpdateInfo extends StatefulWidget {
  const UpdateInfo({super.key});

  @override
  State<UpdateInfo> createState() => _UpdateInfoState();
}

class _UpdateInfoState extends State<UpdateInfo> {
    // Controllers for text fields
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController workController = TextEditingController();
  final TextEditingController studyController = TextEditingController();

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    fullNameController.dispose();
    descriptionController.dispose();
    workController.dispose();
    studyController.dispose();
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
              controller: fullNameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: workController,
              decoration: const InputDecoration(labelText: 'Work'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: studyController,
              decoration: const InputDecoration(labelText: 'Study'),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                      postApi();
                      Navigator.pop(context);
                },
                child: const Text('Update Info'),
              ),
            ),
          ],
        ),
    );
  }
    void postApi() {
    final Map<String, String> requestData = {
      "fullName": fullNameController.text,
      "description": descriptionController.text,
      "work": workController.text,
      "study": studyController.text,
    };
    updateInfoUser(requestData);
    print(requestData);
  }
}
