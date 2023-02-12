import 'package:flutter/material.dart';

class Tagline extends StatelessWidget {
  const Tagline({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Share your story",
      style: TextStyle(
        height: 0.5,
        fontFamily: 'Merriweather',
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: Theme.of(context).textTheme.titleLarge?.color,
      ),
    );
  }
}
