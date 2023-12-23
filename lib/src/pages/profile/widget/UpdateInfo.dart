import 'package:flutter/material.dart';

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
            // Text field for fullName
            TextField(
              controller: fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            SizedBox(height: 16),

            // Text field for description
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16),

            // Text field for work
            TextField(
              controller: workController,
              decoration: InputDecoration(labelText: 'Work'),
            ),
            SizedBox(height: 16),

            // Text field for study
            TextField(
              controller: studyController,
              decoration: InputDecoration(labelText: 'Study'),
            ),
            SizedBox(height: 16),

            // Button to post API
            ElevatedButton(
              onPressed: () {
                // Post API using the values from text fields
                postApi();
              },
              child: Text('Update Info'),
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

    // Perform API request using requestData
    // Replace this with your actual API integration code
    print(requestData);
  }
}