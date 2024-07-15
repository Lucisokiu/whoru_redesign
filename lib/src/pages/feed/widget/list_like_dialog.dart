import 'package:flutter/material.dart';

void showListDialog(
    BuildContext context, List<Map<String, dynamic>> list, String title) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return Dialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Flexible(
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        GlobalKey commentKey = GlobalKey();
                        return ListTile(
                          key: commentKey,
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(list[index]['avatar']),
                          ),
                          title: Text(
                            list[index]['fullName'],
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    },
  );
}
