import 'package:enabled_try_1/features/Add_post/screens/add_post_screen.dart';
import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/features/Notifications/screen/notifications_screen.dart';
import 'package:enabled_try_1/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class AddButton extends ConsumerWidget {
  const AddButton({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: IconButton(
          onPressed: () {
            ref.read(userProvider.notifier).update((state) => user);
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
        size: 35,
      ),
      color: Theme.of(context).appBarTheme.iconTheme?.color,
    );
  }
}

// class SettingsButton extends StatelessWidget {
//   const SettingsButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: () {},
//       icon: const Icon(
//         Icons.settings,
//       ),
//       color: Theme.of(context).appBarTheme.iconTheme?.color,
//     );
//   }
// }

class MessagesButton extends StatelessWidget {
  final String uid;
  const MessagesButton({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Routemaster.of(context).push('/chatlist');
      },
      icon: const Icon(
        Icons.message,
        size: 35,
      ),
      color: Theme.of(context).appBarTheme.iconTheme?.color,
    );
    ;
  }
}
