import 'package:flutter/material.dart';

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
          children: [
            Text(
              "Enabled",
              style: TextStyle(
                  height: 0.5,
                  fontSize: 72,
                  color: Colors.white,
                  fontFamily: 'Pacifico'),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              "Share your story",
              style: TextStyle(
                  height: 0.5,
                  fontFamily: 'Merriweather',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            LoginForm(),
          ],
        ),
      )),
    );
  }
}
