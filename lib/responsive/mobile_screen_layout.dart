import 'package:flutter/material.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text('This is mobile',
              style: TextStyle(
                color: Colors.white,
              ))),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}
