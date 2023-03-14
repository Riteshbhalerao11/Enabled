import 'package:enabled_try_1/features/Add_post/controller/post_controller.dart';
import 'package:enabled_try_1/features/Home/Screens/widgets/caption_box.dart';
import 'package:enabled_try_1/features/Profile/screen/widgets/profile_pic.dart';
import 'package:enabled_try_1/models/post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class PostCard extends ConsumerWidget {
  PostCard({super.key, required this.post, required this.myUsername});
  final String myUsername;
  final Post post;

  final uid = FirebaseAuth.instance.currentUser!.uid;
  void likePost(WidgetRef ref) async {
    ref.read(postControllerProvider.notifier).likePost(post, uid);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TopBar(post: post, myUsername: myUsername),
          NetworkPicture(
            img: post.link,
            altText: post.altText,
          ),
          InfoBar(post: post),
          CaptionBox(caption: post.caption)
        ],
      ),
    );
  }
}

class InfoBar extends ConsumerWidget {
  InfoBar({super.key, required this.post});

  final Post post;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  void likePost(WidgetRef ref) async {
    ref.read(postControllerProvider.notifier).likePost(post, uid);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        color: Theme.of(context).cardColor,
        height: 45,
        child: Semantics(
          explicitChildNodes: true,
          label: "Post information bar",
          hint:
              "${post.likes.length} likes on this image. Tap and hold to like image",
          child: Row(
            children: [
              Semantics(
                excludeSemantics: true,
                label: "${post.likes.length} likes on this image",
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "${post.likes.length} likes",
                    style: const TextStyle(
                        fontFamily: "SecularOne",
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ),
              Flexible(child: Container()),
              Semantics(
                excludeSemantics: true,
                label: "Like button",
                hint: post.likes.contains(uid)
                    ? "Double tap to dislike image"
                    : "Double tap to like image",
                child: GestureDetector(
                  onTap: () => likePost(ref),
                  child: Icon(
                    Icons.favorite,
                    size: 32,
                    color: post.likes.contains(uid) ? Colors.red : Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
                child: Container(),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.comment,
                  size: 32,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ));
  }
}

class TopBar extends StatelessWidget {
  TopBar({super.key, required this.post, required this.myUsername});
  final String myUsername;
  final Post post;

  final uid = FirebaseAuth.instance.currentUser!.uid;
  void disLikePost(bool isLike, WidgetRef ref) {
    ref.read(postControllerProvider.notifier).disLikePost(post, uid);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: Theme.of(context).cardColor,
      ),
      child: Semantics(
        explicitChildNodes: true,
        label: "Top bar of post card.",
        hint: "Tap around in same row to know more",
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 16),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blueGrey,
                backgroundImage: post.profilepic.length < 2
                    ? null
                    : NetworkImage(
                        post.profilepic,
                      ),
                child: post.profilepic.length < 2
                    ? const Icon(Icons.person)
                    : null,
              ),
            ),
            GestureDetector(
              onTap: () {
                Routemaster.of(context)
                    .push("/user_page/$myUsername/${post.username}/home");
              },
              child: Semantics(
                excludeSemantics: true,
                // label: "Post author name : $firstName",
                label: "username is : ${post.username}",
                hint: "Double tap to go to user profile",
                child: Text(
                  post.username,
                  style: const TextStyle(
                      fontFamily: "SecularOne",
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
            Flexible(
              child: Container(),
            ),
            Semantics(
              label: "Report button",
              hint: "Double tap to report user",
              child: const Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: Icon(
                  Icons.announcement,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
