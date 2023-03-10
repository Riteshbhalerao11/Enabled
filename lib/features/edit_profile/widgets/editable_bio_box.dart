import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/features/edit_profile/repository/edit_provider.dart';
import 'package:enabled_try_1/models/user_model.dart';

class EditBioBox extends ConsumerStatefulWidget {
  const EditBioBox({super.key, required this.user, required this.uid});
  final UserModel user;
  final String uid;
  @override
  ConsumerState<EditBioBox> createState() => _EditBioBoxState();
}

class _EditBioBoxState extends ConsumerState<EditBioBox> {
  void save(UserModel user, String uid, String bio, BuildContext ctx) {
    if (user.bio == bio) {
      ref.read(editProvider.notifier).toggleState();
      return;
    }
    ref
        .watch(authControllerProvider.notifier)
        .editBio(user: user, uid: uid, bio: bio, ctx: ctx);
  }

  late TextEditingController bioEditingController;

  @override
  void initState() {
    final String initBio = widget.user.bio;
    super.initState();
    bioEditingController = TextEditingController(text: initBio);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bioEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String bio;
    final isLoading = ref.watch(authControllerProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: 100,
            width: double.infinity,
            child: Container(
              height: 100,
              width: double.infinity,
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, right: 16, left: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                controller: bioEditingController,
                onFieldSubmitted: (value) {
                  bioEditingController.text = value;
                },
                maxLines: 3,
                maxLength: 48 * 3,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                style: const TextStyle(
                    color: Colors.black, fontSize: 16, fontFamily: "PTSans"),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        if (!isLoading)
          ElevatedButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              bio = bioEditingController.text;
              save(widget.user, widget.uid, bio, context);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
              child: Text("Save Bio",
                  style: TextStyle(
                      fontFamily: "Signika",
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      letterSpacing: 1.2)),
            ),
          ),
        if (isLoading)
          const CircularProgressIndicator(
            color: Colors.white,
          ),
      ],
    );
  }
}
