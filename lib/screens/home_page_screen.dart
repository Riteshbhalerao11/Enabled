import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/Buttons/appbar_buttons.dart';
import '../widgets/Buttons/nav_buttons.dart';

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
                onPressed: () async {
                  await FirebaseAuth.instance.signOut().then((_) =>
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login', (Route route) => false));
                },
                child: const Text(
                  "Sign out",
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              elevation: 0,
              actions: [
                Flexible(flex: 2, child: Container()),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: NavButtons("HOME", true, "null"),
                ),
                Flexible(flex: 2, child: Container()),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: NavButtons("FEED", false, "null"),
                ),
                Flexible(flex: 2, child: Container()),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: NavButtons("PROFILE", false, "/profile_page"),
                ),
                Flexible(flex: 2, child: Container()),
              ],
            )
          ],
        ));
  }
}
