import 'package:enabled_try_1/features/voice_commands/voice_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:enabled_try_1/core/Common/error_text.dart';
import 'package:enabled_try_1/core/Common/loader.dart';
import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/features/Home/Screens/widgets/Buttons/appbar_buttons.dart';
import 'package:enabled_try_1/features/Home/Screens/widgets/Buttons/nav_buttons.dart';
import 'package:enabled_try_1/features/Profile/screen/widgets/bio_box.dart';
import 'package:enabled_try_1/features/Profile/screen/widgets/info_bar.dart';
import 'package:enabled_try_1/features/Profile/screen/widgets/profile_buttons.dart';
import 'package:enabled_try_1/features/Profile/screen/widgets/profile_pic.dart';
import 'package:enabled_try_1/utils/snackbar_&_fp.dart';

class ProfilePage extends ConsumerWidget {
  final String uid;
  const ProfilePage({super.key, required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authRepoGetUserData(uid)).when(
          data: (user) {
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.primary,
              appBar: AppBar(
                leading: AddButton(user: user),
                title: Text(
                  user.firstName,
                  style: TextStyle(
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer),
                ),
              ),
              body: Column(
                children: [
                  NavigationButtons(uid: uid),
                  if (user.profilepic.length == 1)
                    GestureDetector(
                        onLongPress: () {
                          HapticFeedback.heavyImpact();
                          showDialogBox(
                              context, "Edit Profile ? ", uid, user, ref);
                        },
                        child: const ProfilePicture()),
                  if (user.profilepic.length != 1)
                    GestureDetector(
                        onLongPress: () {
                          HapticFeedback.heavyImpact();
                          showDialogBox(
                              context, "Edit Profile ? ", uid, user, ref);
                        },
                        child: FilledPictureUrl(url: user.profilepic)),
                  const SizedBox(
                    height: 16,
                  ),
                  InfoBar(
                    username: user.username,
                    friends: user.friends,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BioBox(bio: user.bio),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MediaButton(
                          path: '/profile/$uid/user_images_page',
                          title: "Images"),
                      const SizedBox(
                        width: 25,
                      ),
                      const MediaButton(path: "path", title: "Videos"),
                    ],
                  ),
                  Flexible(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: VoiceButton(
                      user: user,
                      screen: 'profile',
                    ),
                  )
                ],
              ),
            );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: (() => const Loader()),
        );
  }
}

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({
    super.key,
    required this.uid,
  });

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(flex: 2, child: Container()),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: NavButtons("HOME", false, "/"),
        ),
        Flexible(flex: 2, child: Container()),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: NavButtons("FEED", false, "/feed_page/$uid"),
        ),
        Flexible(flex: 2, child: Container()),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: NavButtons("PROFILE", true, "/profile_page"),
        ),
        Flexible(flex: 2, child: Container()),
      ],
    );
  }
}
