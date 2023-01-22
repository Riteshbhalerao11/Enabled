import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/Buttons/appbar_buttons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const AddButton(),
        actions: [
          const MessagesButton(),
          const NotificationButton(),
          const SettingsButton(),
          TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Text(
                "Sign out",
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
      body: Row(children: [

        ],),
      )
  }
}
