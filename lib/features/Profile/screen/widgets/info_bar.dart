import 'package:enabled_try_1/features/My_story/Screen/my_story.dart';
import 'package:enabled_try_1/features/Profile/screen/friends_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class InfoBar extends StatelessWidget {
  const InfoBar(
      {super.key,
      required this.username,
      required this.friends,
      required this.uid});

  final String username;
  final String uid;
  final List<String> friends;
  @override
  Widget build(BuildContext context) {
    return Semantics(
      explicitChildNodes: true,
      label: "User information bar",
      hint: "Tap in same row to know more",
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 16),
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(20),
                ),
                color: Theme.of(context).colorScheme.onBackground,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Semantics(
                    excludeSemantics: true,
                    label: "username text",
                    hint: username,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          username,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Signika",
                              fontSize: 16,
                              letterSpacing: 1.2),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Flexible(
                      child: Semantics(
                        excludeSemantics: true,
                        label: "Friends count",
                        hint:
                            "Currently you have ${friends.length} friends. Double tap to activate",
                        child: friends.length == 1
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: FittedBox(
                                  child: TextButton(
                                    onPressed: () {
                                      Routemaster.of(context)
                                          .push('/profile/$uid/my_story');
                                    },
                                    child: Text("${friends.length} Friend",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Signika",
                                            fontSize: 20,
                                            letterSpacing: 1.2)),
                                  ),
                                ),
                              )
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: TextButton(
                                  onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FriendsScreen(friends: friends)),
                                  ),
                                  child: Text("${friends.length} Friends",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Signika",
                                          fontSize: 16,
                                          letterSpacing: 1.2)),
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Semantics(
            excludeSemantics: true,
            label: "My story button",
            hint: "Double tap to edit your story",
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Ink(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(20))),
                child: InkWell(
                  onTap: () {
                    // Routemaster.of(context).push('/profile/$uid/my_story');
                    Routemaster.of(context).push("/profile/$uid/my_story");
                  },
                  focusColor: Colors.white,
                  borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(0), right: Radius.circular(20)),
                  splashColor: Colors.purpleAccent,
                  splashFactory: InkRipple.splashFactory,
                  child: Container(
                    height: 40,
                    width: 115,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(20),
                        ),
                        color: Colors.transparent),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Icon(Icons.edit_note),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 12.0),
                              child: Text(
                                "My Story",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Signika",
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
