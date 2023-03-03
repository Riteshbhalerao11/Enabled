import 'package:enabled_try_1/core/Common/error_text.dart';
import 'package:enabled_try_1/core/Common/loader.dart';
import 'package:enabled_try_1/features/Add_post/controller/post_controller.dart';
import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/features/Home/Screens/widgets/Buttons/nav_buttons.dart';
import 'package:enabled_try_1/features/Search_users/controller/search_users_controller.dart';
import 'package:enabled_try_1/features/voice_commands/voice_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedScreen extends ConsumerStatefulWidget {
  FeedScreen({super.key, required this.uid});
  final String uid;
  bool isLoading = false;

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
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
      ref.refresh(fetchPostsProvider);
      announceRefreshComplete();
    });
    setState(() {
      widget.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Semantics(
            excludeSemantics: true,
            label: "App bar title",
            hint: "Feed screen",
            child: const Text(
              "Feed",
            ),
          ),
          elevation: 0,
          actions: [
            Semantics(
              excludeSemantics: true,
              label: "Search button",
              hint: "Double tap to go to search page",
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                onPressed: () {
                  showSearch(
                      context: context, delegate: SearchUserDelegate(ref));
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).viewPadding.top -
                kToolbarHeight,
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(flex: 2, child: Container()),
                    Semantics(
                      excludeSemantics: true,
                      label: "Home button",
                      hint: "Double tap to go to home page",
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: NavButtons("HOME", false, '/', null),
                      ),
                    ),
                    Flexible(flex: 2, child: Container()),
                    Semantics(
                      excludeSemantics: true,
                      label: "Feed button",
                      hint: "You are on feed page",
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: NavButtons(
                            "FEED", true, "/feed_page/${widget.uid}", null),
                      ),
                    ),
                    Flexible(flex: 2, child: Container()),
                    Semantics(
                      excludeSemantics: true,
                      label: "Profile button",
                      hint: "Double tap to go to profile page",
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: NavButtons(
                            "PROFILE", false, "/profile/${widget.uid}", null),
                      ),
                    ),
                    Flexible(flex: 2, child: Container()),
                  ],
                ),
                if (!widget.isLoading)
                  Expanded(
                    child: ref.watch(fetchPostsProvider).when(
                          data: (posts) => PageView.builder(
                            itemCount: (posts.length / 12)
                                .ceil(), // Create pages with 10 posts each
                            itemBuilder: (context, index) {
                              // Calculate start and end indexes for current page
                              final start = index * 12;
                              final end = (index + 1) * 12;

                              // Get posts for current page
                              final pagePosts = posts.sublist(start,
                                  end < posts.length ? end : posts.length);

                              // Create GridView with posts for current page
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 6),
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 6,
                                          mainAxisSpacing: 6),
                                  itemCount: pagePosts.length,
                                  itemBuilder: (context, index) {
                                    final post = pagePosts[index];
                                    return Semantics(
                                      excludeSemantics: true,
                                      label: "Post tile in grid",
                                      hint: "description : ${post.altText}",
                                      child: GridTile(
                                        child: Container(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer,
                                            child: Image.network(
                                              post.link,
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          error: (er, st) => ErrorText(error: er.toString()),
                          loading: () => const Loader(),
                        ),
                  ),
                if (widget.isLoading)
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                Row(
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
                        child: VoiceButton(
                            user: ref.read(userProvider)!, screen: "feed"),
                      ),
                    ),
                    Flexible(child: Container()),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Semantics(
                        excludeSemantics: true,
                        label: "Refresh button",
                        hint: "Double tap to refresh screen",
                        child: FloatingActionButton(
                          heroTag: "feedrefresh",
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
            ),
          ),
        ));
  }
}
