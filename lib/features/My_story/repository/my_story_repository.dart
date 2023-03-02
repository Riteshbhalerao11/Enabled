import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enabled_try_1/core/Constants/constants.dart';
import 'package:enabled_try_1/core/Providers/firebase.dart';
import 'package:enabled_try_1/utils/snackbar_&_fp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final futureGetStoryData = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(myStoryProvider.notifier);
  return authController.getData(uid: uid);
});

final myStoryProvider = StateNotifierProvider<MyStoryRepo, bool>(
    (ref) => MyStoryRepo(firestore: ref.read(firebaseFirestoreProvider)));

class MyStoryRepo extends StateNotifier<bool> {
  final FirebaseFirestore _firestore;

  MyStoryRepo({required FirebaseFirestore firestore})
      : _firestore = firestore,
        super(false);

  CollectionReference get _story =>
      _firestore.collection(FireBaseConstants.storyCollection);

  void storeData(
      {required BuildContext ctx,
      required String uid,
      required String jsonData}) async {
    try {
      state = true;
      await _story.doc(uid).set({"story": jsonData});
      showSnackBar(ctx, "Saved succesfully", false);
      state = false;
    } on Exception catch (e) {
      showSnackBar(ctx, e.toString(), true);
    }
  }

  Future<String> getData({required String uid}) async {
    final story = await _story.doc(uid).get();
    if (story.data() == null) {
      return "";
    }
    final data = story.data() as Map<String, dynamic>;
    return data['story'];
  }
}
