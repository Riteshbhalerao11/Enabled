import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import 'package:enabled_try_1/utils/Theme/theme.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  void showLogoutDialogBox(BuildContext ctx, String message) {
    showDialog(
        context: ctx,
        builder: (ctx) {
          return AlertDialog(
            semanticLabel: "Logout alert box",
            title: Semantics(
              label: "Alert text",
              child: Text(
                message,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            actions: [
              Semantics(
                excludeSemantics: true,
                label: "'NO' Text button",
                hint: "Double tap to activate",
                child: TextButton(
                  child: Semantics(
                      excludeSemantics: true,
                      child: const Text('No',
                          style: TextStyle(color: Colors.black))),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
              ),
              Semantics(
                excludeSemantics: true,
                label: "'YES' Text button",
                hint: "Double tap to activate",
                child: TextButton(
                    child: Semantics(
                      excludeSemantics: true,
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(ctx).pop();

                      Routemaster.of(ctx).popUntil((route) => false);
                      await FirebaseAuth.instance.signOut();
                    }),
              ),
            ],
          );
        });
  }

  void toggleTheme(BuildContext context, WidgetRef ref) {
    ref.read(themeNotifierProvider.notifier).toggleTheme();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Semantics(
      explicitChildNodes: true,
      label: "Side drawer menu ",
      hint: "Tap in same column to locate tiles",
      child: Drawer(
        child: ListView(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Divider(
              color: Colors.blueGrey,
              thickness: 1,
            ),
            Semantics(
              excludeSemantics: true,
              label: "Toggle theme tile. List tile 1 of 2",
              hint: "Double tap to change theme",
              child: ListTile(
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
            ),
            Semantics(
              excludeSemantics: true,
              label: "Logout tile. List tile 2 of 2",
              hint: "Double tap to log out",
              child: ListTile(
                onTap: () {
                  showLogoutDialogBox(
                      context, "Do you really want to logout ?");
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
            ),
          ],
        ),
      ),
    );
  }
}
