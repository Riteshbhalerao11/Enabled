// ignore: file_names

import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/features/edit_profile/screens/edit_profile_screen.dart';
import 'package:enabled_try_1/models/user_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

void showSnackBar(BuildContext ctx, String message, bool isError) {
  ScaffoldMessenger.of(ctx).showSnackBar(
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

void showDialogBox(BuildContext ctx, String message, String uid, UserModel user,
    WidgetRef ref) {
  ref.read(userProvider.notifier).update(
        (state) => user,
      );
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
                  Routemaster.of(ctx).push('/profile/$uid/edit_profile_screen');
                }),
          ],
        );
      });
}

void showGeneralDialogBox(BuildContext ctx, String message, Function function) {
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
                  function();
                }),
          ],
        );
      });
}
