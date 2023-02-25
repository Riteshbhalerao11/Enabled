import 'package:flutter/material.dart';
import 'widgets/buttons.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Post",
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: AddPostButton(
              title: "Post image",
              isVideo: false,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: AddPostButton(
              title: 'Post Video',
              isVideo: true,
            ),
          )
        ],
      ),
    );
  }
}
