import 'package:enabled_try_1/core/Common/error_text.dart';
import 'package:enabled_try_1/core/Common/loader.dart';
import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/features/Profile/screen/read_only_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchUserDelegate extends SearchDelegate {
  final WidgetRef ref;
  SearchUserDelegate(this.ref);

  @override
  // TODO: implement searchFieldStyle
  TextStyle? get searchFieldStyle => const TextStyle(color: Colors.black);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
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
    void navigate(String username) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ViewOnlyProfilePage(username: username)));
    }

    return ref.watch(searchUsersProvider(query)).when(
        data: (users) => Container(
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
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return ListTile(
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
                    title: Text(
                      user.username,
                      style: const TextStyle(color: Colors.black),
                    ),
                    onTap: () => navigate(user.username),
                  );
                },
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
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Search users")
                ],
              ),
            ));
  }
}
