import 'package:flutter_riverpod/flutter_riverpod.dart';

final editProvider =
    StateNotifierProvider<EditNotifier, bool>((ref) => EditNotifier());

class EditNotifier extends StateNotifier<bool> {
  EditNotifier() : super(false);

  void toggleState() {
    state = !state;
  }
}
