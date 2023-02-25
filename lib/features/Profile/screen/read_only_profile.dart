import 'package:enabled_try_1/core/Common/error_text.dart';
import 'package:enabled_try_1/core/Common/loader.dart';
import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/features/Profile/screen/widgets/bio_box.dart';
import 'package:enabled_try_1/features/Profile/screen/widgets/info_bar.dart';
import 'package:enabled_try_1/features/Profile/screen/widgets/profile_buttons.dart';

import 'package:enabled_try_1/features/Profile/screen/widgets/profile_pic.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewOnlyProfilePage extends ConsumerWidget {
  final String username;
  const ViewOnlyProfilePage({super.key, required this.username});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getUserDataByName(username)).when(
          data: (user) {
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.primary,
              appBar: AppBar(
                title: Text(
                  user.firstName,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              body: Column(
                children: [
                  if (user.profilepic.length == 1) const ProfilePicture(),
                  if (user.profilepic.length != 1)
                    FilledPictureUrl(url: user.profilepic),
                  const SizedBox(
                    height: 16,
                  ),
                  InfoBar(
                    username: user.username,
                    points: user.points.toString(),
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
                    children: const [
                      MediaButton(path: "path", title: "Images"),
                      SizedBox(
                        width: 25,
                      ),
                      MediaButton(path: "path", title: "Videos"),
                    ],
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
