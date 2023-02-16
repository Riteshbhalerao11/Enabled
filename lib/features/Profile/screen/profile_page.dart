import 'package:enabled_try_1/core/Common/error_text.dart';
import 'package:enabled_try_1/core/Common/loader.dart';
import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:enabled_try_1/features/Home/widgets/Buttons/nav_buttons.dart';

class ProfilePage extends ConsumerWidget {
  final String uid;
  const ProfilePage({super.key, required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: ref.watch(authRepoGetUserData(uid)).when(
              data: (data) {
                return Text(data.username,
                    style: const TextStyle(color: Colors.black));
              },
              error: (error, stackTrace) => ErrorText(error: error.toString()),
              loading: (() => Container()),
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
