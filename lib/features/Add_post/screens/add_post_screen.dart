import 'package:enabled_try_1/models/user_model.dart';
import 'package:flutter/material.dart';

import 'widgets/buttons.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Post",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AddPostButton(
                title: "Post image",
                isVideo: false,
                user: user,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AddPostButton(
                title: "Post video",
                isVideo: true,
                user: user,
              ),
            )
          ],
        ),
      ),
    );
  }
}
