import 'dart:io';
import 'package:enabled_try_1/core/Constants/failure.dart';
import 'package:enabled_try_1/core/Providers/firebase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:enabled_try_1/core/Constants/typedef.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final editProfileRepositoryProvider = Provider((ref) =>
    EditProfileRepository(firebaseStorage: ref.watch(storageProvider)));

class EditProfileRepository {
  final FirebaseStorage _firebaseStorage;

  EditProfileRepository({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;
  FutureEither<String> storeFile({
    required String path,
    required String id,
    required File file,
  }) async {
    try {
      final ref = _firebaseStorage.ref().child(path).child(id);
      UploadTask uploadTask = ref.putFile(file);
      final snapShot = await uploadTask;
      return Right(await snapShot.ref.getDownloadURL());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
