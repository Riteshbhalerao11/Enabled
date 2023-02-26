import 'package:enabled_try_1/core/Common/error_text.dart';
import 'package:enabled_try_1/core/Common/loader.dart';
import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/features/Profile/screen/widgets/bio_box.dart';
import 'package:enabled_try_1/features/Profile/screen/widgets/info_bar.dart';
import 'package:enabled_try_1/features/Profile/screen/widgets/profile_buttons.dart';
import 'package:enabled_try_1/features/Profile/screen/widgets/profile_pic.dart';
import 'package:enabled_try_1/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewOnlyProfilePage extends ConsumerWidget {
  final String otherUsername;
  final String myUsername;
  ViewOnlyProfilePage(
      {super.key, required this.otherUsername, required this.myUsername});

  void sendFriendReq(
      WidgetRef ref, String myUid, String otherUid, BuildContext ctx) {
    ref
        .read(authControllerProvider.notifier)
        .sendFriendReq(otherUid: otherUid, username: myUsername, ctx: ctx);
  }

  void unFriend(WidgetRef ref, String myUid, String otherUid, BuildContext ctx,
      String myUsername, String otherUsername) {
    ref.read(authControllerProvider.notifier).unFriend(
        myUid: myUid,
        otherUid: otherUid,
        ctx: ctx,
        myUsername: myUsername,
        otherUsername: otherUsername);
  }

  void cancelRequest(WidgetRef ref, String otherUid, BuildContext ctx) {
    print("object");
    ref.read(authControllerProvider.notifier).cancelFriendRequest(
        otherUid: otherUid, username: myUsername, ctx: ctx);
  }

  void showDialogBox(
      BuildContext ctx, WidgetRef ref, String otherUid, String myUid) {
    showDialog(
        context: ctx,
        builder: (ctx) {
          return AlertDialog(
            title: const FittedBox(
              child: Text(
                "Do you really wanna befriend ?",
                style: TextStyle(color: Colors.black),
              ),
            ),
            actions: [
              TextButton(
                child: const Text('No', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
              TextButton(
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    unFriend(
                        ref, myUid, otherUid, ctx, myUsername, otherUsername);
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myUid = FirebaseAuth.instance.currentUser!.uid;
    return ref.watch(getUserDataByName(otherUsername)).when(
          data: (user) {
            return Scaffold(
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
                  if (user.uid != myUid)
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () {
                          if (user.friends.contains(myUsername)) {
                            showDialogBox(context, ref, user.uid, myUid);
                            // unFriend(ref, myUid, user.uid, context);
                          } else if (user.friendreqs.contains(myUsername)) {
                            cancelRequest(ref, user.uid, context);
                          } else {
                            sendFriendReq(ref, myUid, user.uid, context);
                          }
                        },
                        child: FriendButton(
                          username: myUsername,
                          user: user,
                        )),
                  if (user.uid != myUid)
                    const SizedBox(
                      height: 16,
                    ),
                  InfoBar(username: user.username, friends: user.friends),
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
                          path: "/profile/${user.uid}/user_images_page",
                          title: "Images"),
                      const SizedBox(
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

class FriendButton extends StatelessWidget {
  const FriendButton({super.key, required this.username, required this.user});

  final String username;
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    if (user.friends.contains(username)) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          "Friends",
          style: TextStyle(
              fontFamily: "Signika",
              fontSize: 18,
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
      );
    } else if (user.friendreqs.contains(username)) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          "Requested",
          style: TextStyle(
              fontFamily: "Signika",
              fontSize: 18,
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        "Befriend",
        style: TextStyle(
            fontFamily: "Signika",
            fontSize: 18,
            color: Theme.of(context).colorScheme.onSecondaryContainer),
      ),
    );
  }
}
