// import 'package:enabled_try_1/features/auth/controller/auth_controller.dart';
// import 'package:enabled_try_1/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class FriendButton extends ConsumerStatefulWidget {
//   const FriendButton(
//       {super.key,
//       required this.uid,
//       required this.userUid,
//       required this.user});
//   final String uid;
//   final String userUid;
//   final UserModel user;

//   @override
//   ConsumerState<FriendButton> createState() => _FriendButtonState();
// }

// class _FriendButtonState extends ConsumerState<FriendButton> {
//   void sendFriendReq(
//       WidgetRef ref, String uid, String userUid, BuildContext ctx) {
//     ref.read(authControllerProvider.notifier).sendFriendReq(uid, userUid, ctx);
//   }

//   void unFriend(WidgetRef ref, String uid, String userUid, BuildContext ctx) {
//     ref.read(authControllerProvider.notifier).unFriend(uid, userUid, ctx);
//   }

//   void cancelRequest(
//       WidgetRef ref, String uid, String userUid, BuildContext ctx) {
//     ref
//         .read(authControllerProvider.notifier)
//         .cancelFriendRequest(uid, userUid, ctx);
//   }

//   bool isFriend = false;
//   bool isRequested = false;
//   @override
//   Widget build(BuildContext context) {
//     if (widget.user.friendreqs.contains(widget.userUid)) {
//       isRequested = true;
//     }
//     if (widget.user.friends.contains(widget.userUid)) {
//       isFriend = true;
//     }
//     return 
//   }
// }
