import 'package:enabled_try_1/features/voice_commands/voice_button.dart';
import 'package:enabled_try_1/models/user_model.dart';
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
                leading: Semantics(
                    excludeSemantics: true,
                    label: "Add post button",
                    hint: "Double tap to activate",
                    child: AddButton(user: user)),
                title: Focus(
                  autofocus: true,
                  child: Semantics(
                    excludeSemantics: true,
                    label: "Profile page",
                    hint: "You are on your profile",
                    child: Text(
                      user.firstName,
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer),
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).viewPadding.top,
                  child: Column(
                    children: [
                      NavigationButtons(
                        uid: uid,
                        user: user,
                      ),
                      if (user.profilepic.length == 1)
                        Semantics(
                          excludeSemantics: true,
                          label: "Empty Profile picture card",
                          hint: "Double tap and hold to edit profile",
                          child: GestureDetector(
                              onLongPress: () {
                                HapticFeedback.heavyImpact();
                                showDialogBox(
                                    context, "Edit Profile ? ", uid, user, ref);
                              },
                              child: const ProfilePicture()),
                        ),
                      if (user.profilepic.length != 1)
                        Semantics(
                          excludeSemantics: true,
                          label: "Your profile picture card",
                          hint: "Double tap and hold to edit profile",
                          child: GestureDetector(
                              onLongPress: () {
                                HapticFeedback.heavyImpact();
                                showDialogBox(
                                    context, "Edit Profile ? ", uid, user, ref);
                              },
                              child: FilledPictureUrl(url: user.profilepic)),
                        ),
                      const SizedBox(
                        height: 16,
                      ),
                      InfoBar(
                        uid: user.uid,
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
                          Semantics(
                            excludeSemantics: true,
                            label: "Images button",
                            hint: "double tap to see posted images by user",
                            child: MediaButton(
                                path: '/profile/$uid/user_images_page',
                                title: "Images"),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Semantics(
                              excludeSemantics: true,
                              label: "Videos button",
                              hint: "double tap to see posted videos by user",
                              child: const MediaButton(
                                  path: "path", title: "Videos")),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Semantics(
                        excludeSemantics: true,
                        label: "Voice commands button",
                        hint: "Double tap and speak on beep",
                        child: VoiceButton(
                          user: user,
                          screen: 'profile',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: (() => const Loader()),
        );
  }
}

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({super.key, required this.uid, required this.user});

  final String uid;
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(flex: 2, child: Container()),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Semantics(
              excludeSemantics: true,
              label: "Home button",
              hint: "Double tap to go to home page",
              child: NavButtons("HOME", false, "/", user)),
        ),
        Flexible(flex: 2, child: Container()),
        Semantics(
          excludeSemantics: true,
          label: "Feed button",
          hint: "Double tap to go to feed page",
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: NavButtons("FEED", false, "/feed_page/$uid", user),
          ),
        ),
        Flexible(flex: 2, child: Container()),
        Semantics(
          excludeSemantics: true,
          label: "Profile button",
          hint: "You are on profile page",
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: NavButtons("PROFILE", true, "/profile_page", user),
          ),
        ),
        Flexible(flex: 2, child: Container()),
      ],
    );
  }
}
