import 'package:enabled_try_1/models/user_model.dart';
import 'package:enabled_try_1/utils/Theme/theme.dart';
import 'package:enabled_try_1/utils/snackbar_&_fp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  void showLogoutDialogBox(BuildContext ctx, String message) {
    showDialog(
        context: ctx,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              message,
              style: const TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                child: const Text('No', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
              TextButton(
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    Navigator.of(ctx).pop();

                    Routemaster.of(ctx).popUntil((route) => false);
                    await FirebaseAuth.instance.signOut();
                  }),
            ],
          );
        });
  }

  void toggleTheme(BuildContext context, WidgetRef ref) {
    ref.read(themeNotifierProvider.notifier).toggleTheme();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          const Divider(
            color: Colors.blueGrey,
            thickness: 1,
          ),
          ListTile(
            onTap: () {
              toggleTheme(context, ref);
            },
            splashColor: Theme.of(context).colorScheme.onPrimary,
            shape: const Border(bottom: BorderSide(color: Colors.blueGrey)),
            leading: Icon(
              Icons.colorize_outlined,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            title: Text(
              "Theme change",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontFamily: "Montserrat",
                  letterSpacing: 1.2),
            ),
          ),
          ListTile(
            onTap: () {
              showLogoutDialogBox(context, "Do you really want to logout ?");
            },
            splashColor: Theme.of(context).colorScheme.onPrimary,
            shape: const Border(bottom: BorderSide(color: Colors.blueGrey)),
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            title: Text(
              "Logout",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontFamily: "Montserrat",
                  letterSpacing: 1.2),
            ),
          ),
        ],
      ),
    );
  }
}
