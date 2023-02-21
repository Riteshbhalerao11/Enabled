import 'dart:io';

import 'package:enabled_try_1/features/edit_profile/repository/edit_profile_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import '../../../models/user_model.dart';
import '../repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/snackbar_&_fp.dart';

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChanged;
});

final authRepoGetUserData = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
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

  Future signupUser(String username, String email, String password, String bio,
      BuildContext ctx) async {
    state = true;
    final user =
        await _authRepository.signupUser(username, email, password, bio);
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
