import 'package:flutter/material.dart';

class InfoBar extends StatelessWidget {
  const InfoBar({super.key, required this.username, required this.friends});
  final String username;
  final String friends;
  @override
  Widget build(BuildContext context) {
    return Row(
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
                Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: Text(
                    username,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Signika",
                        fontSize: 16,
                        letterSpacing: 1.2),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: friends == '1'
                        ? Text("$friends Friend",
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: "Signika",
                                fontSize: 16,
                                letterSpacing: 1.2))
                        : Text("$friends Friends",
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: "Signika",
                                fontSize: 16,
                                letterSpacing: 1.2)),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Ink(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(20))),
            child: InkWell(
              onTap: () {},
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
        )
      ],
    );
  }
}
