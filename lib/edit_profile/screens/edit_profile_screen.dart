import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/features/Profile/screen/widgets/bio_box.dart';
import 'package:enabled_try_1/features/Profile/screen/widgets/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var bio = ref.watch(userProvider)?.bio ?? " ";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile"),
      ),
      body: Column(
        children: [
          const ProfilePicture(),
          const SizedBox(
            height: 50,
          ),
          BioBox(bio: bio),
        ],
      ),
    );
  }
}
