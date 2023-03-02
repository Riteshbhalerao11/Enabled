import 'package:enabled_try_1/features/My_story/Screen/my_story.dart';
import 'package:enabled_try_1/features/Profile/screen/friends_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class ViewOnlyInfoBar extends StatelessWidget {
  const ViewOnlyInfoBar(
      {super.key,
      required this.otherUid,
      required this.otherUsername,
      required this.myUsername,
      required this.friends,
      required this.myUid});

  final String myUsername;
  final String otherUsername;
  final String otherUid;
  final String myUid;
  final List<String> friends;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Semantics(
          excludeSemantics: true,
          explicitChildNodes: true,
          label: "User information bar",
          hint: "Tap in same row to know more",
          child: Expanded(
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
                    hint: otherUsername,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Text(
                        otherUsername,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Signika",
                            fontSize: 16,
                            letterSpacing: 1.2),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Semantics(
                      excludeSemantics: true,
                      label: "Friends count",
                      hint:
                          "Currently user has ${friends.length} friends. Double tap to activate",
                      child: Padding(
                        padding: const EdgeInsets.only(right: 14.0),
                        child: friends.length == 1
                            ? TextButton(
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FriendsScreen(friends: friends)),
                                ),
                                child: Text("${friends.length} Friend",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Signika",
                                        fontSize: 16,
                                        letterSpacing: 1.2)),
                              )
                            : TextButton(
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
                ],
              ),
            ),
          ),
        ),
        Semantics(
          excludeSemantics: true,
          label: "My story button",
          hint: "Double tap to view user's story",
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Ink(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(20))),
              child: InkWell(
                onTap: () {
                  Routemaster.of(context).push(
                      '/feed_page/$myUid/user_page/$myUsername/$otherUsername/$otherUid/my_story_page');
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
                  child: Row(
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
        )
      ],
    );
  }
}
