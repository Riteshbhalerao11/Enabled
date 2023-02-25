import 'package:enabled_try_1/core/Common/error_text.dart';
import 'package:enabled_try_1/core/Common/loader.dart';
import 'package:enabled_try_1/features/Add_post/controller/post_controller.dart';
import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/features/Home/widgets/Buttons/nav_buttons.dart';
import 'package:enabled_try_1/features/Home/widgets/Buttons/post_card.dart';
import 'package:enabled_try_1/features/Profile/screen/widgets/profile_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/Buttons/appbar_buttons.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return ref.watch(authRepoGetUserData(uid!)).when(
        data: (data) {
          return Scaffold(
            drawer: const ProfileDrawer(),
            appBar: AppBar(
              elevation: 0,
              actions: [
                const MessagesButton(),
                NotificationButton(
                  user: data,
                ),
                const SettingsButton(),
              ],
            ),
            body: Column(
              children: [
                Row(
                  children: [
                    Flexible(flex: 2, child: Container()),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: NavButtons("HOME", true, '/'),
                    ),
                    Flexible(flex: 2, child: Container()),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: NavButtons("FEED", false, "/feed_page/$uid"),
                    ),
                    Flexible(flex: 2, child: Container()),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: NavButtons("PROFILE", false, "/profile/$uid"),
                    ),
                    Flexible(flex: 2, child: Container()),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ref.watch(userPostsProvider(data.friends)).when(
                      data: (posts) => PageView.builder(
                          itemCount: posts.length,
                          itemBuilder: ((context, index) {
                            final post = posts[index];
                            return PostCard(
                              post: post,
                            );
                          })),
                      error: (error, stacktrace) {
                        return ErrorText(error: error.toString());
                      },
                      loading: () => const Loader()),
                ),
              ],
            ),
          );
        },
        error: (error, stacktrace) => ErrorText(error: error.toString()),
        loading: () => const Loader());
  }
}
