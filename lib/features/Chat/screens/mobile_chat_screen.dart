import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:enabled_try_1/core/common/utils/colors.dart';
import 'package:enabled_try_1/utils/Theme/theme.dart';
import 'package:enabled_try_1/core/common/widgets/loader.dart';
import 'package:enabled_try_1/features/auth/controller/auth_controller.dart';
// import 'package:enabled_try_1/features/call/controller/call_controller.dart';
// import 'package:enabled_try_1/features/call/screens/call_pickup_screen.dart';
import 'package:enabled_try_1/features/chat/widgets/bottom_chat_field.dart';
import 'package:enabled_try_1/models/user_model.dart';
import 'package:enabled_try_1/features/chat/widgets/chat_list.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat-screen';
  // final String name;
  final String uid;
  // final bool isGroupChat;
  // final String profilePic;
  const MobileChatScreen({
    Key? key,
    // required this.name,
    required this.uid,
    // required this.isGroupChat,
    // required this.profilePic,
  }) : super(key: key);

  // void makeCall(WidgetRef ref, BuildContext context) {
  //   ref.read(callControllerProvider).makeCall(
  //         context,
  //         name,
  //         uid,
  //         profilePic,
  //         isGroupChat,
  //       );
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Pallete.appBarColor,
          title: StreamBuilder<UserModel>(
                  stream: ref.read(authControllerProvider.notifier).getUserData(uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    }
                    return Column(
                      children: [
                        Text(snapshot.data!.username),
                        // Text(
                        //   snapshot.data!.isOnline ? 'online' : 'offline',
                        //   style: const TextStyle(
                        //     fontSize: 13,
                        //     fontWeight: FontWeight.normal,
                        //   ),
                        // ),
                      ],
                    );
                  }),
          centerTitle: false,
          actions: [
            // IconButton(
            //   onPressed: () => makeCall(ref, context),
            //   icon: const Icon(Icons.video_call),
            // ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.call),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: TempWidget(uid: uid),
      );
  }
  // Widget build(BuildContext context, WidgetRef ref) {
  //   return Scaffold( body: TempWidget(uid: uid));
  // }
}

class TempWidget extends StatelessWidget {
  const TempWidget({
    super.key,
    required this.uid,
    // required this.isGroupChat,
  });

  final String uid;
  // final bool isGroupChat;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
            Expanded(
              child: ChatList(
                recieverUserId: uid,
                // isGroupChat: isGroupChat,
              ),
            ),
            BottomChatField(
              recieverUserId: uid,
              // isGroupChat: isGroupChat,
            )]);
  }
}
