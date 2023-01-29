import 'package:flutter/material.dart';

import '../widgets/Buttons/nav_buttons.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text(
          "Myself",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        Row(
          children: [
            Flexible(flex: 2, child: Container()),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: NavButtons("HOME", false, "/home_page"),
            ),
            Flexible(flex: 2, child: Container()),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: NavButtons("FEED", false, "null"),
            ),
            Flexible(flex: 2, child: Container()),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: NavButtons("PROFILE", true, "/profile_page"),
            ),
            Flexible(flex: 2, child: Container()),
          ],
        )
      ]),
    );
  }
}
