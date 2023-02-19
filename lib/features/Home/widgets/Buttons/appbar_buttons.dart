import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Routemaster.of(context).push('/add_post');
        },
        icon: const Icon(
          Icons.add_circle,
          color: Colors.black,
        ));
  }
}

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
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
  final String uid;
  const MessagesButton({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Routemaster.of(context).push('/chat/$uid');
        },
      icon: const Icon(
        Icons.message,
      ),
      color: Theme.of(context).appBarTheme.iconTheme?.color,
    );
  }
}
