// ignore: file_names

import 'package:enabled_try_1/features/edit_profile/screens/edit_profile_screen.dart';
import 'package:enabled_try_1/models/user_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext ctx, String message, bool isError) {
  ScaffoldMessenger.of(ctx)
    ..hideCurrentSnackBar
    ..showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
              color: isError ? Colors.white : Colors.black, fontSize: 16),
        ),
        backgroundColor: isError ? Colors.red : Colors.white,
        padding: const EdgeInsetsDirectional.all(24),
      ),
    );
}

Future<FilePickerResult?> pickImage() async {
  final image = await FilePicker.platform.pickFiles(type: FileType.image);
  return image;
}

void showDialogBox(
    BuildContext ctx, String message, UserModel user, String uid) {
  showDialog(
      context: ctx,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            message,
            style: const TextStyle(color: Colors.black),
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
                  Navigator.of(ctx).push(MaterialPageRoute(
                    builder: (context) =>
                        EditProfileScreen(user: user, uid: uid),
                  ));
                }),
          ],
        );
      });
}
