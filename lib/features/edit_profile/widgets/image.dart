import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/features/Profile/screen/widgets/profile_pic.dart';
import 'package:enabled_try_1/models/user_model.dart';
import 'package:enabled_try_1/utils/snackbar_&_fp.dart';

class ProfilePic extends ConsumerStatefulWidget {
  const ProfilePic({super.key, required this.uid, required this.user});
  final String uid;
  final UserModel user;
  @override
  ConsumerState<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends ConsumerState<ProfilePic> {
  File? profilePic;
  void selectProfileImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        profilePic = File(res.files.first.path!);
      });
    }
  }

  void save(File profilepic) async {
    ref.read(signupAuthControllerProvider.notifier).editUser(
        user: widget.user,
        uid: widget.uid,
        profilepic: profilepic,
        ctx: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(signupAuthControllerProvider);
    return Column(
      children: [
        Stack(
          children: [
            if (profilePic != null)
              GestureDetector(
                  onLongPress: selectProfileImage,
                  child: FilledPicture(img: profilePic!)),
            if (profilePic == null)
              GestureDetector(
                  onLongPress: selectProfileImage,
                  child: const ProfilePicture()),
            Positioned(
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.only(right: 30, bottom: 8),
                child: ClipOval(
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      splashColor: Colors.white.withOpacity(0.5),
                      onTap: selectProfileImage,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          //
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        if (isLoading)
          const CircularProgressIndicator(
            color: Colors.white,
          ),
        if (!isLoading)
          ElevatedButton(
            onPressed: () {
              if (profilePic != null) {
                save(profilePic!);
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
              child: Text("Save Image",
                  style: TextStyle(
                      fontFamily: "Signika",
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      letterSpacing: 1.2)),
            ),
          )
      ],
    );
  }
}
