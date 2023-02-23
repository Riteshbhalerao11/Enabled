import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: IconButton(
          onPressed: () {
            Routemaster.of(context).push('/add_post');
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
