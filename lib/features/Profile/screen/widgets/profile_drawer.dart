import 'package:enabled_try_1/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key, required this.user});
  final UserModel user;
  Future<dynamic> logout(BuildContext context) async {
    Routemaster.of(context).popUntil((route) => false);
    await FirebaseAuth.instance.signOut();
  }

  void navigate() {}
  @override
  Widget build(BuildContext context) {
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
              logout(context);
            },
            splashColor: Theme.of(context).colorScheme.onPrimary,
            shape: const Border(bottom: BorderSide(color: Colors.blueGrey)),
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat",
                  letterSpacing: 1.2),
            ),
          ),
        ],
      ),
    );
  }
}
