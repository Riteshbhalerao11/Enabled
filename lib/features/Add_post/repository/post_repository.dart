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

  Future<List<Post>> fetchPosts() async {
    final posts = await _posts.orderBy("createdAt", descending: true).get();
    return posts.docs
        .map((e) => Post.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }

  Stream<List<Post>> fetchUserPosts(List<String> usernames) {
    return _posts
        .where("username", whereIn: usernames)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((event) => event.docs.map((e) {
              return Post.fromMap(e.data() as Map<String, dynamic>);
            }).toList());
  }

  void likePost(Post post, String userId) async {
    if (post.likes.contains(userId)) {
      _posts.doc(post.id).update({
        'likes': FieldValue.arrayRemove([userId])
      });
    } else {
      _posts.doc(post.id).update({
        'likes': FieldValue.arrayUnion([userId])
      });
    }
  }

  void disLikePost(Post post, String userId) async {
    if (post.dislikes.contains(userId)) {
      _posts.doc(post.id).update({
        'dislikes': FieldValue.arrayRemove([userId])
      });
    } else {
      _posts.doc(post.id).update({
        'dislikes': FieldValue.arrayUnion([userId])
      });
    }
  }

  Stream<List<Post>> getUserPosts(String uid) {
    return _posts
        .where('uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((event) => event.docs
            .map((e) => Post.fromMap(e.data() as Map<String, dynamic>))
            .toList());
  }
}
