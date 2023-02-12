import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:enabled_try_1/features/Home/widgets/Buttons/nav_buttons.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: Text(
          user?.username ?? "--",
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Column(children: [
        Row(
          children: [
            Flexible(flex: 2, child: Container()),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: NavButtons("HOME", false, "/"),
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
