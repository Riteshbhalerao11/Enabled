import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enabled_try_1/core/Constants/constants.dart';
import 'package:enabled_try_1/core/Constants/failure.dart';
import 'package:enabled_try_1/core/Constants/typedef.dart';
import 'package:enabled_try_1/core/Providers/firebase.dart';
import 'package:enabled_try_1/models/post_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final postRepositoryProvider = Provider(
  (ref) {
    return PostRepository(
      firestore: ref.watch(firebaseFirestoreProvider),
    );
  },
);

class PostRepository {
  final FirebaseFirestore _firestore;
  PostRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _posts =>
      _firestore.collection(FireBaseConstants.postsCollection);

  FutureVoid addPost(Post post) async {
    try {
      return right(_posts.doc(post.id).set(post.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<Post>> fetchUserPosts(List<String> uid) {
    return _posts
        .where("uid", whereIn: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((event) => event.docs.map((e) {
              // print('e.data() = ${e.data()}');
              print(e.data());
              print(e.data().runtimeType);
              return Post.fromMap(e.data() as Map<String, dynamic>);
            }).toList());
  }
}
