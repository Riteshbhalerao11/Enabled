import 'dart:io';

// import 'package:enabled_try_1/features/Add%20post/screens/add_video.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:enabled_try_1/features/Add post/screens/confirm_video.dart';

class AddPostButton extends StatelessWidget {
  final String title;
  final bool isVideo;
  const AddPostButton({super.key, required this.title, required this.isVideo});

  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ConfirmScreen(
            videoFile: File(video.path),
            videoPath: video.path,
          ),
        ),
      );
    }
  }

  showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.gallery, context),
            child: Row(
              children: const [
                Icon(Icons.image),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Gallery',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.camera, context),
            child: Row(
              children: const [
                Icon(Icons.camera_alt),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text('Camera',
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(),
            child: Row(
              children: const [
                Icon(Icons.cancel),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
      onPressed: () => showOptionsDialog(context),
    );
  }
}
// onPressed: () {
//         Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => showOptionsDialog(context)()));
//       }