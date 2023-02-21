import 'package:enabled_try_1/features/edit_profile/repository/edit_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditButton extends ConsumerWidget {
  const EditButton({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.only(right: 30, bottom: 8),
        child: ClipOval(
          child: Material(
            color: Colors.white,
            child: InkWell(
              splashColor: Colors.white,
              onTap: () => ref.read(editProvider.notifier).toggleState(),
              child: Container(
                height: 40,
                width: 40,
                color: Colors.transparent,
                child: const Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
