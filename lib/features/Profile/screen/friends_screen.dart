import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key, required this.friends});

  final List<String> friends;

  @override
  Widget build(BuildContext context) {
    return friends.isEmpty
        ? Scaffold(
            appBar: AppBar(
              title: const Text("Friends"),
            ),
            body: const Padding(
              padding: EdgeInsets.only(bottom: 60),
              child: Center(
                child: Text(
                  "No friends at this moment",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text("Friends"),
            ),
            body: ListView.builder(
                itemCount: friends.length,
                itemBuilder: (context, index) => ListTile(
                      title: Text(friends[index]),
                    )),
          );
  }
}
