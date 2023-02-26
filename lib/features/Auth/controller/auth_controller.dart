import 'dart:io';

import 'package:enabled_try_1/features/edit_profile/repository/edit_profile_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:routemaster/routemaster.dart';

import '../../../models/user_model.dart';
import '../repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/snackbar_&_fp.dart';

final searchUsersProvider = StreamProvider.family((ref, String username) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.searchUsers(username);
});

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChanged;
});

final authRepoGetUserData = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final futureGetUserData = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserDataFuture(uid);
});

final getUserDataByName =
    StreamProvider.family.autoDispose((ref, String username) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserByName(username);
});

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
      authRepository: ref.watch(authRepositoryProvider), ref: ref),
);

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChanged => _authRepository.authStateChange;

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  Future<UserModel> getUserDataFuture(String uid) {
    return _authRepository.getUserDataFuture(uid);
  }

  Stream<UserModel> getUserByName(String username) {
    return _authRepository.getUserByName(username);
  }

  Future loginUser(String email, String password, BuildContext ctx) async {
    state = true;
    final user = await _authRepository.loginUser(email, password);
    state = false;
    user.fold(
        (l) => showSnackBar(ctx, l.message, true),
        (userModel) =>
            _ref.read(userProvider.notifier).update((state) => userModel));
  }

  void editBio(
      {required UserModel user,
      required String uid,
      required String bio,
      required BuildContext ctx}) async {
    String prevbio = user.bio;
    user = user.copyWith(bio: bio);
    state = true;
    final res = await _authRepository.editBio(user, uid, prevbio);
    state = false;
    res.fold((l) => showSnackBar(ctx, l.message, true), (r) {
      Routemaster.of(ctx).pop();
      showSnackBar(ctx, "Bio updated !", false);
    });
  }

  void sendFriendReq(
      {required String otherUid,
      required BuildContext ctx,
      required String username}) async {
    final res = await _authRepository.friendUser(
        otherUid: otherUid, username: username);
    res.fold((l) => showSnackBar(ctx, l.message, true), (r) {
      ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
      showSnackBar(ctx, "Friend request sent", false);
    });
  }

  void unFriend(
      {required String otherUid,
      required String myUid,
      required BuildContext ctx,
      required myUsername,
      required otherUsername}) async {
    final res = await _authRepository.unFriendUser(
        otherUid: otherUid,
        myUid: myUid,
        myUsername: myUsername,
        otherUsername: otherUsername);
    res.fold((l) => showSnackBar(ctx, l.message, true), (r) {
      ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
      showSnackBar(ctx, "Unfriend successful", false);
    });
  }

  void acceptUserReq(
      {required String otherUsername,
      required String myUid,
      required String myUsername,
      required BuildContext ctx}) async {
    final res = await _authRepository.acceptUserReq(
        otherUsername: otherUsername, myUsername: myUsername, myUid: myUid);
    res.fold((l) => showSnackBar(ctx, l.message, true), (r) {
      ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
      showSnackBar(ctx, "Friend added", false);
    });
  }

  void cancelFriendRequest(
      {required String username,
      required String otherUid,
      required BuildContext ctx}) async {
    final res = await _authRepository.cancelUserReq(
        username: username, otherUid: otherUid);
    res.fold((l) => showSnackBar(ctx, l.message, true), (r) {
      ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
      showSnackBar(ctx, "Request Cancelled", false);
    });
  }

  Stream<List<UserModel>> searchUsers(String query) {
    return _authRepository.searchUsers(query);
  }
}

final signupAuthControllerProvider =
    StateNotifierProvider<SignupAuthController, bool>(
  (ref) => SignupAuthController(
      authRepository: ref.watch(authRepositoryProvider),
      ref: ref,
      storageRepository: ref.watch(editProfileRepositoryProvider)),
);

class SignupAuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  final EditProfileRepository _storageRepository;
  SignupAuthController(
      {required AuthRepository authRepository,
      required Ref ref,
      required EditProfileRepository storageRepository})
      : _authRepository = authRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  Future signupUser(String username, String email, String password,
      String firstname, String bio, BuildContext ctx) async {
    state = true;
    final user = await _authRepository.signupUser(
        username, email, password, firstname, bio);
    state = false;
    user.fold(
        (l) => showSnackBar(ctx, l.message, true),
        (userModel) =>
            _ref.read(userProvider.notifier).update((state) => userModel));
  }

  void editUser(
      {required UserModel user,
      required String uid,
      required File? profilepic,
      required BuildContext ctx}) async {
    if (profilepic != null) {
      state = true;
      final res = await _storageRepository.storeFile(
          path: "users/profile", id: uid, file: profilepic);
      res.fold((l) => showSnackBar(ctx, l.message, true),
          (r) => user = user.copyWith(profilepic: r));
    }
    final res = await _authRepository.editUser(user, uid);
    state = false;
    res.fold((l) => showSnackBar(ctx, l.message, true), (r) {
      Routemaster.of(ctx).pop();
      showSnackBar(ctx, "Image uploaded !", false);
    });
  }
}
