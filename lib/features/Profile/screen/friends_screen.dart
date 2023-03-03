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
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: friends.length,
                  itemBuilder: (context, index) => ListTile(
                        title: Text(
                          friends[index],
                          style: TextStyle(
                              fontFamily: "PTSans",
                              fontSize: 20,
                              color: Colors.black),
                        ),
                      )),
            ),
          );
  }
}
