import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class NavButtons extends ConsumerWidget {
  final UserModel? user;
  final String title;
  final bool isSelected;
  final String page;
  const NavButtons(this.title, this.isSelected, this.page, this.user,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        if (title == "FEED") {
          ref.read(userProvider.notifier).update((state) => user);
        }
        isSelected ? Null : Routemaster.of(context).push(page);
      },
      style: TextButton.styleFrom(
        backgroundColor: isSelected
            ? Theme.of(context).colorScheme.tertiary
            : Theme.of(context).colorScheme.onPrimaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        fixedSize: const Size.fromWidth(110),
        elevation: 5,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'SecularOne',
          fontSize: 16,
          letterSpacing: 1.28,
          color: isSelected
              ? Theme.of(context).colorScheme.onPrimaryContainer
              : Theme.of(context).colorScheme.onSecondaryContainer,
        ),
      ),
    );
  }
}
