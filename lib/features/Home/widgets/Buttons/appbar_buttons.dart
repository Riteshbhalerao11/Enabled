import 'package:enabled_try_1/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: IconButton(
          onPressed: () {
            Routemaster.of(context)
                .push("/profile/${user.uid}/add_posts_screen");
          },
          icon: Icon(
            Icons.add_circle,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            size: 30,
          )),
    );
  }
}

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Routemaster.of(context).push("/notifications/${user.uid}");
      },
      icon: const Icon(
        Icons.notifications,
      ),
      color: Theme.of(context).appBarTheme.iconTheme?.color,
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.settings,
      ),
      color: Theme.of(context).appBarTheme.iconTheme?.color,
    );
  }
}

class MessagesButton extends StatelessWidget {
  const MessagesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.message,
      ),
      color: Theme.of(context).appBarTheme.iconTheme?.color,
    );
    ;
  }
}
