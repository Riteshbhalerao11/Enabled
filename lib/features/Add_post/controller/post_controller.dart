import 'dart:io';
import 'package:enabled_try_1/features/Add_post/repository/post_repository.dart';
import 'package:enabled_try_1/features/edit_profile/repository/edit_profile_repo.dart';
import 'package:enabled_try_1/models/post_model.dart';
import 'package:enabled_try_1/models/user_model.dart';
import 'package:enabled_try_1/utils/snackbar_&_fp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';

final fetchPostsProvider = FutureProvider((ref) {
  final postController = ref.read(postControllerProvider.notifier);
  return postController.fetchPosts();
});

final userPostsProvider = StreamProvider.family((ref, List<String> usernames) {
  final postController = ref.read(postControllerProvider.notifier);
  return postController.fetchUserPosts(usernames);
});

final getuserPostsProvider = StreamProvider.family((ref, String uid) {
  final postController = ref.read(postControllerProvider.notifier);
  return postController.getUserPosts(uid);
});

final postControllerProvider = StateNotifierProvider<PostController, bool>(
  (ref) => PostController(
      postRepository: ref.watch(postRepositoryProvider),
      ref: ref,
      editProfileRepository: ref.watch(editProfileRepositoryProvider)),
);

class PostController extends StateNotifier<bool> {
  final PostRepository _postRepository;
  final EditProfileRepository _editProfileRepository;
  final Ref _ref;
  PostController(
      {required PostRepository postRepository,
      required editProfileRepository,
      required Ref ref})
      : _postRepository = postRepository,
        _ref = ref,
        _editProfileRepository = editProfileRepository,
        super(false);

  void shareImagePost(
      {required BuildContext ctx,
      required File image,
      required String caption,
      required String altText,
      required UserModel user}) async {
    state = true;
    String postId = const Uuid().v4();
    final imageRes = await _editProfileRepository.storeFile(
        path: "posts/${user.username}", id: postId, file: image);
    imageRes.fold(
      (l) => showSnackBar(ctx, l.message, true),
      (r) async {
        final Post post = Post(
            link: r,
            id: postId,
            caption: caption,
            altText: altText,
            username: user.username,
            profilepic: user.profilepic,
            likes: [],
            dislikes: [],
            commentCount: 0,
            uid: user.uid,
            createdAt: DateTime.now());
        final res = await _postRepository.addPost(post);
        state = false;
        res.fold(
          (l) => showSnackBar(ctx, l.message, true),
          (r) {
            showSnackBar(ctx, "Posted successfully", false);
            Navigator.of(ctx).pop();
            Routemaster.of(ctx).pop();
          },
        );
      },
    );
  }

  Stream<List<Post>> fetchUserPosts(List<String> usernames) {
    if (usernames.isNotEmpty) {
      return _postRepository.fetchUserPosts(usernames);
    }
    return Stream.value([]);
  }

  Future<List<Post>> fetchPosts() {
    return _postRepository.fetchPosts();
  }

  Stream<List<Post>> getUserPosts(String uid) {
    return _postRepository.getUserPosts(uid);
  }

  void likePost(Post post, String uid) {
    _postRepository.likePost(post, uid);
  }

  void disLikePost(Post post, String uid) {
    _postRepository.disLikePost(post, uid);
  }
}
