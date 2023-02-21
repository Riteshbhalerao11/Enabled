import 'package:enabled_try_1/features/Profile/screen/widgets/bio_box.dart';
import 'package:enabled_try_1/features/edit_profile/repository/edit_provider.dart';
import 'package:enabled_try_1/features/edit_profile/widgets/bio_edit.dart';
import 'package:enabled_try_1/features/edit_profile/widgets/editable_bio_box.dart';
import 'package:enabled_try_1/features/edit_profile/widgets/image.dart';
import 'package:enabled_try_1/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/bio_edit.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key, required this.user, required this.uid});
  final UserModel user;
  final String uid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var bio = user.bio;
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
                uid: uid,
              ),
              const SizedBox(
                height: 50,
              ),
              if (!isEdit)
                Stack(children: [BioBox(bio: bio), const EditButton()]),
              if (isEdit)
                EditBioBox(
                  user: user,
                  uid: uid,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
