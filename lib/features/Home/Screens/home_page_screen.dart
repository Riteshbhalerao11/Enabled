import 'package:enabled_try_1/core/Providers/firebase.dart';
import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/features/Home/widgets/Buttons/nav_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/Buttons/appbar_buttons.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
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
                  await FirebaseAuth.instance.signOut();
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: NavButtons("PROFILE", false, "/profile/$uid"),
                ),
                Flexible(flex: 2, child: Container()),
              ],
            )
          ],
        ));
  }
}
