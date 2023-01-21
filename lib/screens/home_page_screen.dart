import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Text(
                "Sign out",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: const Center(
        child: Text("home page"),
      ),
    );
  }
}
