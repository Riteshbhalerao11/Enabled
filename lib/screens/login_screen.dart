import 'package:flutter/material.dart';
import 'dart:ui';

import '/widgets/text_fields.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text(
              "Enabled",
              style: TextStyle(
                  height: 0.5,
                  fontSize: 72,
                  color: Colors.white,
                  fontFamily: 'Pacifico',
                  shadows: [
                    Shadow(
                      offset: Offset(0, 5),
                      blurRadius: 4,
                      color: Colors.black26,
                    )
                  ]),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "Share your story",
              style: TextStyle(
                  height: 0.5,
                  fontFamily: 'Merriweather',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 32,
            ),
            const LoginForm(),
          ],
        ),
      )),
    );
  }
}
