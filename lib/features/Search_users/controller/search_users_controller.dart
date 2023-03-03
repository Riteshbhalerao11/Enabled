import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enabled_try_1/core/Common/error_text.dart';
import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/features/Profile/screen/read_only_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class SearchUserDelegate extends SearchDelegate {
  final WidgetRef ref;
  SearchUserDelegate(this.ref);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return theme.copyWith(
      textTheme: TextTheme(
          titleLarge: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              fontFamily: "SecularOne",
              fontSize: 20)),
      appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.brightness == Brightness.dark
              ? Colors.grey[900]
              : Colors.white,
          iconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
          toolbarTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer)),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer),
            border: InputBorder.none,
          ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Semantics(
        excludeSemantics: true,
        label: "cancel button",
        hint: "double tap to clear input of search edit box",
        child: IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close),
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    void navigate(String username) async {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userSnapshot =
          await _firestore.collection('users').doc(uid).get();
      final myUsername = await userSnapshot.get('username');
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => ViewOnlyProfilePage(
      //           otherUsername: username,
      //           myUsername: myUsername,
      //         )));
      Routemaster.of(context)
          .push('/feed_page/$uid/user_page/$myUsername/$username/feed');
    }

    return ref.watch(searchUsersProvider(query)).when(
        data: (users) => Semantics(
              excludeSemantics: true,
              explicitChildNodes: true,
              label: "Search results card",
              hint: "Tap around to know more",
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    if (users.isEmpty) {
                      return const Center(
                        child: Text(
                          "No users found",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      );
                    }
                    return Semantics(
                      excludeSemantics: true,
                      label: "User list tile",
                      hint: "username is ${user.firstName}",
                      child: ListTile(
                        leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: (user.profilepic.length == 1)
                                ? null
                                : NetworkImage(user.profilepic),
                            child: (user.profilepic.length == 1)
                                ? const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  )
                                : null),
                        title: Semantics(
                          label: "Username",
                          hint: user.username,
                          child: Text(
                            user.username,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        onTap: () => navigate(
                          user.username,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        error: (error, stack) => ErrorText(
              error: error.toString(),
            ),
        loading: () => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 35,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Search users",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            ));
  }
}
