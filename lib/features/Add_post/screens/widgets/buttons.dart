import 'package:enabled_try_1/features/Add_post/screens/add_image_screen.dart';
import 'package:enabled_try_1/models/user_model.dart';
import 'package:flutter/material.dart';

class AddPostButton extends StatelessWidget {
  final String title;
  final bool isVideo;
  final UserModel user;
  const AddPostButton(
      {super.key,
      required this.title,
      required this.isVideo,
      required this.user});

  @override
  Widget build(BuildContext context) {
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
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddImageScreen(user: user)));
        } else {}
      },
    );
  }
}
