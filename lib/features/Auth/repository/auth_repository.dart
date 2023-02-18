import 'package:enabled_try_1/core/Constants/failure.dart';
import 'package:enabled_try_1/core/Constants/typedef.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '/core/Constants/constants.dart';
import '/core/Providers/firebase.dart';
import '/models/user_model.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: ref.read(firebaseAuthProvider),
    firestore: ref.read(firebaseFirestoreProvider),
  ),
);

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository(
      {required FirebaseAuth auth, required FirebaseFirestore firestore})
      : _auth = auth,
        _firestore = firestore;

  Stream<User?> get authStateChange => _auth.authStateChanges();

  CollectionReference get _users =>
      _firestore.collection(FireBaseConstants.usersCollection);

  FutureEither<UserModel> loginUser(String email, String password) async {
    UserModel userModel;
    try {
      UserCredential userCred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(userCred.user!.uid);
      userModel = await getUserData(userCred.user!.uid).first;
      return right(userModel);
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? "Something went wrong. Unknown error"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel> signupUser(
      String username, String email, String password, String bio) async {
    UserModel userModel;
    try {
      final querySnapshot =
          await _users.where('username', isEqualTo: username).get();
      if (querySnapshot.docs.isNotEmpty) {
        return left(Failure('Username is already taken'));
      }
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      userModel = UserModel(
          username: username,
          email: email,
          firstName: ' ',
          password: password,
          bio: bio,
          points: 0,
          profilepic: " ",
          friends: []);
      await _users.doc(userCred.user!.uid).set(userModel.toMap());
      return right(userModel);
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? "Something went wrong. Unknown error"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }
}
