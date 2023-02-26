import 'package:enabled_try_1/features/Home/widgets/caption_box.dart';
import 'package:enabled_try_1/features/Profile/screen/widgets/profile_pic.dart';
import 'package:enabled_try_1/models/post_model.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TopBar(post: post),
        NetworkPicture(
          img: post.link,
          altText: post.altText,
        ),
        InfoBar(post: post),
        CaptionBox(caption: post.caption)
      ],
    );
  }
}

class InfoBar extends StatelessWidget {
  const InfoBar({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        color: const Color(0xFf333333),
        height: 45,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "${post.likes.length} likes",
                style: const TextStyle(
                    fontFamily: "SecularOne",
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
            Flexible(child: Container()),
            Icon(
              Icons.favorite,
              size: 32,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            SizedBox(
              child: Container(),
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.comment,
                size: 32,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            )
          ],
        ));
  }
}

class TopBar extends StatelessWidget {
  const TopBar({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: Color(0xFf333333),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 16),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black,
              backgroundImage: NetworkImage(
                post.profilepic,
              ),
            ),
          ),
          Text(
            post.username,
            style: TextStyle(fontFamily: "SecularOne", fontSize: 16),
          ),
          Flexible(
            child: Container(),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: Icon(
              Icons.announcement,
              size: 32,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
