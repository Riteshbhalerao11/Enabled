import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:routemaster/routemaster.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:enabled_try_1/core/common/utils/utils.dart';
import 'package:enabled_try_1/models/user_model.dart';
import 'package:enabled_try_1/features/chat/screens/mobile_chat_screen.dart';

final selectContactsRepositoryProvider = Provider(
  (ref) => SelectContactRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance
  ),
);

class SelectContactRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  SelectContactRepository({
    required this.firestore,
    required this.auth
  });

  Future<List<String>> getContacts() async {
    List<String> friends = [];
    try {
      // if (await FlutterContacts.requestPermission()) {
      //   contacts = await FlutterContacts.getContacts(withProperties: true);
      // }
      var userData = await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get();
        var user = UserModel.fromMap(userData.data()!);
        friends = user.friends;
    } catch (e) {
      debugPrint(e.toString());
    }
    return friends;
  }

  void selectContact(String selectedContact, BuildContext context) async {
    try {
      var userCollection = await firestore.collection('users').get();
      bool isFound = false;

      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        String selectedUser = selectedContact;
        if (selectedUser == userData.username) {
          isFound = true;
          Routemaster.of(context).push('/chat/${userData.uid}');
        }
      }

      if (!isFound) {
        showSnackBar(
          context: context,
          content: 'This number does not exist on this app.',
        );
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
