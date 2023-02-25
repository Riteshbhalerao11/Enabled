import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Notifications extends ConsumerStatefulWidget {
  const Notifications({super.key, required this.user});
  final UserModel user;

  @override
  ConsumerState<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends ConsumerState<Notifications> {
  void acceptReq(String otherUsername, String myUsername, String myUid) {
    setState(() {
      ref.read(authControllerProvider.notifier).acceptUserReq(
          otherUsername: otherUsername,
          myUsername: myUsername,
          ctx: context,
          myUid: myUid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Notifications"),
        ),
        body: Container(
          child: widget.user.friendreqs.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(bottom: 70.0),
                  child: Center(
                    child: Text(
                      "No notifications at this moment",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )
              : Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: widget.user.friendreqs.length == 1
                        ? BorderRadius.circular(40)
                        : BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.user.friendreqs.length,
                      itemBuilder: (context, index) {
                        final req = widget.user.friendreqs[index];
                        return ListTile(
                          tileColor: Colors.transparent,
                          title: GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                req,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: "Signika",
                                ),
                              ),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    widget.user.friendreqs.remove(req);
                                    acceptReq(
                                      req,
                                      widget.user.username,
                                      widget.user.uid,
                                    );
                                  },
                                  child: const Text(
                                    "Acccept",
                                    style: TextStyle(
                                      fontFamily: "PTSans",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                              const SizedBox(
                                width: 20,
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text("Decline",
                                      style: TextStyle(
                                        fontFamily: "PTSans",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      )))
                            ],
                          ),
                        );
                      }),
                ),
        ));
  }
}
