import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/features/Profile/screen/widgets/bio_box.dart';
import 'package:enabled_try_1/features/edit_profile/repository/edit_provider.dart';
import 'package:enabled_try_1/features/edit_profile/widgets/bio_edit.dart';
import 'package:enabled_try_1/features/edit_profile/widgets/editable_bio_box.dart';
import 'package:enabled_try_1/features/edit_profile/widgets/image.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider.notifier).state;
    var bio = user!.bio;
    final isEdit = ref.watch(editProvider);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Your Profile",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProfilePic(
                user: user,
                uid: user.uid,
              ),
              const SizedBox(
                height: 50,
              ),
              if (!isEdit)
                Stack(children: [BioBox(bio: bio), const EditButton()]),
              if (isEdit)
                EditBioBox(
                  user: user,
                  uid: user.uid,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
