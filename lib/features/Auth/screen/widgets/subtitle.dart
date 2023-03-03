import 'package:flutter/material.dart';

class Tagline extends StatelessWidget {
  const Tagline({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Share your story",
      style: TextStyle(
          height: 0.5,
          fontFamily: 'Merriweather',
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: Colors.white),
    );
  }
}
