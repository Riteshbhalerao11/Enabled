import 'package:flutter/material.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post video",
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
      ),
    );
  }
}
