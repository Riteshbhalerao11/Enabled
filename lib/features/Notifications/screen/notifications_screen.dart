import 'package:enabled_try_1/core/Common/error_text.dart';
import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/features/voice_commands/voice_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Notifications extends ConsumerStatefulWidget {
  Notifications({super.key, required this.uid});
  final String uid;
  bool isLoading = false;

  @override
  ConsumerState<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends ConsumerState<Notifications> {
  Future<void> announce(String message, TextDirection textDirection,
      {Assertiveness assertiveness = Assertiveness.polite}) async {
    final AnnounceSemanticsEvent event = AnnounceSemanticsEvent(
        message, textDirection,
        assertiveness: assertiveness);
    await SystemChannels.accessibility.send(event.toMap());
  }

  Future<void> announceRefreshComplete() async {
    await announce('Refresh complete', TextDirection.ltr);
  }

  Future<void> refresh(String uid) async {
    setState(() {
      widget.isLoading = true;
    });
    await Future.delayed((const Duration(seconds: 1)), () {
      ref.refresh(futureGetUserData(uid));
      announceRefreshComplete();
    });
    setState(() {
      widget.isLoading = false;
    });
  }

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
        title: Focus(
            autofocus: true,
            child: Semantics(
                excludeSemantics: true,
                label: "Appbar title",
                hint: "Notifications",
                child: const Text("Notifications"))),
      ),
      body: Container(
        child: ref.watch(futureGetUserData(widget.uid)).when(
              data: (user) {
                if (user.friendreqs.isEmpty) {
                  return widget.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Column(
                          children: [
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 70.0),
                                child: Center(
                                  child: Text(
                                    "No notifications at this moment",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              // mainAxisSize: MainAxisSize.min,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(child: Container()),
                                const SizedBox(
                                  width: 70,
                                ),
                                Semantics(
                                  excludeSemantics: true,
                                  label: "Voice commands button",
                                  hint: "Double tap and speak on beep",
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 40.0),
                                    child: VoiceButton(
                                        user: user, screen: "notifications"),
                                  ),
                                ),
                                Flexible(child: Container()),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 12.0, bottom: 0),
                                  child: Semantics(
                                    excludeSemantics: true,
                                    label: "Refresh button",
                                    hint: "Double tap to refresh screen",
                                    child: FloatingActionButton(
                                      heroTag: "refresh",
                                      onPressed: () async {
                                        return refresh(widget.uid);
                                      },
                                      child: const Icon(
                                        Icons.refresh,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                }
                return widget.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: user.friendreqs.length == 1
                                    ? BorderRadius.circular(40)
                                    : BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: user.friendreqs.length,
                                  itemBuilder: (context, index) {
                                    final req = user.friendreqs[index];
                                    return ListTile(
                                      tileColor: Colors.transparent,
                                      title: GestureDetector(
                                        onTap: () {},
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
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
                                                user.friendreqs.remove(req);
                                                acceptReq(
                                                  req,
                                                  user.username,
                                                  user.uid,
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
                          ),
                          Row(
                            // mainAxisSize: MainAxisSize.min,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(child: Container()),
                              const SizedBox(
                                width: 70,
                              ),
                              Semantics(
                                excludeSemantics: true,
                                label: "Voice commands button",
                                hint: "Double tap and speak on beep",
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 40.0),
                                  child: VoiceButton(
                                      user: user, screen: "notifications"),
                                ),
                              ),
                              Flexible(child: Container()),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 12.0, bottom: 0),
                                child: Semantics(
                                  excludeSemantics: true,
                                  label: "Refresh button",
                                  hint: "Double tap to refresh screen",
                                  child: FloatingActionButton(
                                    heroTag: "refresh",
                                    onPressed: () async {
                                      return refresh(widget.uid);
                                    },
                                    child: const Icon(
                                      Icons.refresh,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
              },
              error: (error, st) => ErrorText(error: error.toString()),
              loading: () => const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
      ),
    );
  }
}
