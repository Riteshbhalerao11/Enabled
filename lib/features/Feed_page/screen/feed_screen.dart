import 'package:enabled_try_1/features/Home/widgets/Buttons/nav_buttons.dart';
import 'package:enabled_try_1/features/Search_users/controller/search_users_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key, required this.uid});
  final String uid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              onPressed: () {
                showSearch(context: context, delegate: SearchUserDelegate(ref));
              },
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              actions: [
                Flexible(flex: 2, child: Container()),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: NavButtons("HOME", false, '/'),
                ),
                Flexible(flex: 2, child: Container()),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: NavButtons("FEED", true, "/feed_page/$uid"),
                ),
                Flexible(flex: 2, child: Container()),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: NavButtons("PROFILE", false, "/profile/$uid"),
                ),
                Flexible(flex: 2, child: Container()),
              ],
            )
          ],
        ));
  }
}
