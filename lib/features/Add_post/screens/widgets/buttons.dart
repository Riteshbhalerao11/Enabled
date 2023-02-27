import 'package:enabled_try_1/core/Providers/firebase.dart';
import 'package:enabled_try_1/features/Add_post/screens/add_image_screen.dart';
import 'package:enabled_try_1/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class AddPostButton extends StatelessWidget {
  final String title;
  final bool isVideo;

  const AddPostButton({
    super.key,
    required this.title,
    required this.isVideo,
  });

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          isVideo
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.video_collection_sharp,
                    size: kToolbarHeight - 25,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.add_photo_alternate_outlined,
                    size: kToolbarHeight - 25,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
          const SizedBox(
            width: 120,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).colorScheme.onSecondaryContainer),
          ),
          Flexible(
            flex: 1,
            child: Container(),
          )
        ],
      ),
      onPressed: () {
        if (!isVideo) {
          Routemaster.of(context)
              .push('/profile/$uid/add_posts_screen/add_image_screen');
        } else {}
      },
    );
  }
}
