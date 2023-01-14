import 'package:flutter/material.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
            child: Text('This is web',
                style: TextStyle(
                  color: Colors.white,
                ))),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}
