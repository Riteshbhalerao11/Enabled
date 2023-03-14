import 'package:enabled_try_1/core/Common/error_text.dart';
import 'package:enabled_try_1/core/Common/loader.dart';
import 'package:enabled_try_1/features/Add_post/controller/post_controller.dart';
import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/features/Home/Screens/widgets/Buttons/nav_buttons.dart';
import 'package:enabled_try_1/features/Home/Screens/widgets/post_card.dart';
import 'package:enabled_try_1/features/Profile/screen/widgets/profile_drawer.dart';
import 'package:enabled_try_1/features/voice_commands/voice_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/Buttons/appbar_buttons.dart';

class HomePage extends ConsumerStatefulWidget {
  HomePage({super.key});
  bool isLoading = false;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController();

    // final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    // GlobalKey<RefreshIndicatorState>();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return ref.watch(futureGetUserData(uid!)).when(
        data: (data) {
          return Scaffold(
            drawer: const ProfileDrawer(),
            appBar: AppBar(
              elevation: 0,
              actions: [
                Semantics(
                  excludeSemantics: true,
                  label: "Notifications button",
                  hint: "Double tap to activate",
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: NotificationButton(
                      user: data,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: MessagesButton(
                    uid: uid.toString(),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewPadding.top -
                    56,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(flex: 2, child: Container()),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Focus(
                              autofocus: true,
                              child: Semantics(
                                excludeSemantics: true,
                                label:
                                    "Home screen button selected. You are on home screen",
                                hint:
                                    "Double tap to revert back to first page of posts",
                                child: TextButton(
                                  onPressed: () {
                                    _pageController
                                        .animateToPage(0,
                                            duration: const Duration(
                                                milliseconds: 200),
                                            curve: Curves.easeInOut)
                                        .then((value) => announce(
                                            "Reverted back to first page",
                                            TextDirection.ltr));
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.tertiary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    alignment: Alignment.center,
                                    fixedSize: const Size.fromWidth(110),
                                    elevation: 5,
                                  ),
                                  child: Text(
                                    "HOME",
                                    style: TextStyle(
                                        fontFamily: 'SecularOne',
                                        fontSize: 16,
                                        letterSpacing: 1.28,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Semantics(
                              excludeSemantics: true,
                              label: "Feed button",
                              hint: "Double tap to go to feed page",
                              child: NavButtons(
                                  "FEED", false, "/feed_page/$uid", data),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Semantics(
                              excludeSemantics: true,
                              label: "Profile button",
                              hint: "Double tap to go to profile page",
                              child: NavButtons(
                                  "PROFILE", false, "/profile/$uid", data),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: widget.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : data.friends.isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Semantics(
                                    excludeSemantics: true,
                                    label:
                                        "There are no posts on your home right now.",
                                    child: const Center(
                                      child: Text(
                                        "Nothing to show yet...",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                )
                              : ref.watch(userPostsProvider(data.friends)).when(
                                  data: (posts) => PageView.builder(
                                      controller: _pageController,
                                      itemCount: posts.length,
                                      itemBuilder: ((context, index) {
                                        final post = posts[index];
                                        return Semantics(
                                          label:
                                              "Image Post card by ${data.firstName}",
                                          hint:
                                              "Page ${index + 1}. Tap around to know more",
                                          explicitChildNodes: true,
                                          child: PostCard(
                                            myUsername: data.username,
                                            post: post,
                                          ),
                                        );
                                      })),
                                  error: (error, stacktrace) {
                                    return ErrorText(error: error.toString());
                                  },
                                  loading: () => const Loader()),
                    ),
                    const SizedBox(
                      height: 20,
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
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: VoiceButton(user: data, screen: "home"),
                          ),
                        ),
                        Flexible(child: Container()),
                        Semantics(
                          excludeSemantics: true,
                          label: "Refresh button",
                          hint: "Double tap to refresh screen",
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, bottom: 8),
                            child: FloatingActionButton(
                              heroTag: "refresh",
                              onPressed: () async {
                                return refresh(uid);
                              },
                              child: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        error: (error, stacktrace) => ErrorText(error: error.toString()),
        loading: () => const Loader());
  }
}
