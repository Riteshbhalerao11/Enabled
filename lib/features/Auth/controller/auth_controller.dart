import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/user_model.dart';
import '../repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/snackbar.dart';

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
        (l) => showSnackBar(ctx, l.message),
        (userModel) =>
            _ref.read(userProvider.notifier).update((state) => userModel));
  }

  Future signupUser(String username, String email, String password, String bio,
      BuildContext ctx) async {
    state = true;
    final user =
        await _authRepository.signupUser(username, email, password, bio);
    state = false;
    user.fold(
        (l) => showSnackBar(ctx, l.message),
        (userModel) =>
            _ref.read(userProvider.notifier).update((state) => userModel));
  }
}
