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
      userModel = await getUserData(userCred.user!.uid).first;
      return right(userModel);
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? "Something went wrong. Unknown error"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel> signupUser(String username, String email,
      String password, String firstname, String bio) async {
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
        uid: userCred.user!.uid,
        username: username,
        email: email,
        firstName: firstname,
        password: password,
        bio: bio,
        points: 0,
        profilepic: " ",
        friends: [],
        friendreqs: [],
      );

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

  Stream<UserModel> getUserByName(String username) {
    return _users.where('username', isEqualTo: username).snapshots().map(
      (snapshot) {
        if (snapshot.docs.isNotEmpty) {
          return UserModel.fromMap(
              snapshot.docs.first.data() as Map<String, dynamic>);
        } else {
          throw Exception("User not found");
        }
      },
    );
  }

  FutureVoid editUser(UserModel user, String uid) async {
    try {
      return right(_users.doc(uid).update(user.toMap()));
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid editBio(UserModel user, String uid, String prevBio) async {
    if (user.bio == prevBio) {
      return left(Failure("Bio unchanged"));
    }
    try {
      return right(_users.doc(uid).update(user.toMap()));
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<UserModel>> searchUsers(String query) {
    return _users
        .where(
          'username',
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(
                    query.codeUnitAt(query.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map((event) {
      List<UserModel> users = [];
      for (var user in event.docs) {
        users.add(UserModel.fromMap(user.data() as Map<String, dynamic>));
      }
      return users;
    });
  }

  FutureVoid friendUser(
      {required String otherUid, required String username}) async {
    try {
      return right(_users.doc(otherUid).update({
        "friendreqs": FieldValue.arrayUnion([username]),
      }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid unFriendUser(
      {required String otherUid, required String myUid}) async {
    try {
      await _users.doc(myUid).update({
        "friends": FieldValue.arrayRemove([otherUid]),
      });
      return right(_users.doc(otherUid).update({
        "friends": FieldValue.arrayRemove([myUid]),
      }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid acceptUserReq(
      {required String otherUid, required String myUid}) async {
    try {
      await _users.doc(otherUid).update({
        "friends": FieldValue.arrayUnion([myUid]),
      });
      return right(_users.doc(myUid).update({
        "friends": FieldValue.arrayUnion([otherUid]),
      }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid cancelUserReq(
      {required String username, required String otherUid}) async {
    try {
      // await _users.doc(userUid).update({
      //   "friendreqs": FieldValue.arrayRemove([uid]),
      // });
      return right(_users.doc(otherUid).update({
        "friendreqs": FieldValue.arrayRemove([username]),
      }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
