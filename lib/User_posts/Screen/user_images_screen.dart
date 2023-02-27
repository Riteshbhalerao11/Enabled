import 'package:enabled_try_1/User_posts/widgets/grid_tile.dart';
import 'package:enabled_try_1/core/Common/error_text.dart';
import 'package:enabled_try_1/core/Common/loader.dart';
import 'package:enabled_try_1/features/Add_post/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserImagesScreen extends ConsumerWidget {
  const UserImagesScreen({super.key, required this.uid});
  final String uid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Images")),
      body: ref.watch(getuserPostsProvider(uid)).when(
          data: (post) {
            return post.isEmpty
                ? const Center(
                    child: Text("No images posted yet..."),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: post.length,
                    itemBuilder: (context, index) =>
                        ImageTile(image: post[index].link));
          },
          error: (e, s) => ErrorText(error: e.toString()),
          loading: () => const Loader()),
    );
  }
}
