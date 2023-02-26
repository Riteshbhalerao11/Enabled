import 'dart:io';

import 'package:enabled_try_1/features/Add_post/screens/add_description.dart';
import 'package:enabled_try_1/features/Profile/screen/widgets/profile_pic.dart';
import 'package:enabled_try_1/models/user_model.dart';
import 'package:enabled_try_1/utils/snackbar_&_fp.dart';
import 'package:flutter/material.dart';

class AddImageScreen extends StatefulWidget {
  const AddImageScreen({super.key, required this.user});
  final UserModel user;
  @override
  State<AddImageScreen> createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {
  File? profilePic;

  void selectProfileImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        profilePic = File(res.files.first.path!);
      });
    }
  }

  void navigateNext(File? profilepic) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddDescription(
              profilepic: profilepic,
              user: widget.user,
            )));
  }

  void discardImage() {
    setState(() {
      profilePic = null;
    });
  }

  void navigateBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showGeneralDialogBox(context,
            "Unsaved changes will be discarded. Continue ?", navigateBack);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Post image",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  splashColor: Colors.blueGrey,
                  elevation: 2,
                  onPressed: () {
                    showGeneralDialogBox(
                        context, "Discard image ? ", discardImage);
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                SizedBox(
                  height: 20,
                  child: Container(),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (profilePic != null) {
                      navigateNext(profilePic!);
                    } else {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      showSnackBar(context, "Post is empty", false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 50),
                    child: Text(
                      "Next",
                      style: TextStyle(
                          fontFamily: "Signika",
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          fontSize: 18,
                          letterSpacing: 1.2),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
