import 'package:enabled_try_1/features/Home/widgets/Buttons/nav_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/Buttons/appbar_buttons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
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
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              actions: [
                Flexible(flex: 2, child: Container()),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: NavButtons("HOME", true, 'null'),
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
