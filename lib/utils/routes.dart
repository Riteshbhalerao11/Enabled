import 'package:enabled_try_1/features/My_story/Screen/my_story.dart';
import 'package:enabled_try_1/features/Profile/screen/read_only_profile.dart';
import 'package:enabled_try_1/features/User_posts/Screen/user_images_screen.dart';
import 'package:enabled_try_1/features/edit_profile/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:enabled_try_1/features/Chat/screens/mobile_chat_screen.dart';
import 'package:enabled_try_1/features/ChatList/screens/select_contact_screen.dart';
import 'package:enabled_try_1/features/Add_post/screens/add_image_screen.dart';
import 'package:enabled_try_1/features/Add_post/screens/add_post_screen.dart';
import 'package:enabled_try_1/features/Add_post/screens/add_video_screen.dart';
import 'package:enabled_try_1/features/Auth/screen/login_screen.dart';
import 'package:enabled_try_1/features/Feed_page/screen/feed_screen.dart';
import 'package:enabled_try_1/features/Home/Screens/home_page_screen.dart';
import 'package:enabled_try_1/features/Profile/screen/profile_page.dart';

import '../features/My_story/Screen/read_only_myStory.dart';

//loggedout
final loggedoutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

//Loggedin
final loggedinRoute = RouteMap(routes: {
  '/': (_) => TransitionPage(
      child: HomePage(),
      pushTransition: PageTransition.none,
      popTransition: PageTransition.none),
  '/chatlist': (route) => const TransitionPage(
    child: SelectContactsScreen()
    ),
  '/chat/:uid': (route) => TransitionPage(
    child: MobileChatScreen(
      uid: route.pathParameters['uid']!,
    )),
  '/profile/:uid': (route) => TransitionPage(
      child: ProfilePage(
        uid: route.pathParameters['uid']!,
      ),
      pushTransition: PageTransition.none,
      popTransition: PageTransition.none),
  '/feed_page/:uid': (route) => TransitionPage(
      child: FeedScreen(
        uid: route.pathParameters['uid']!,
      ),
      pushTransition: PageTransition.none,
      popTransition: PageTransition.none),
  '/profile/:uid/user_images_page': (route) => MaterialPage(
        child: UserImagesScreen(
          uid: route.pathParameters['uid']!,
        ),
      ),
  '/profile/:uid/my_story': (route) => MaterialPage(
        child: MyStory(
          uid: route.pathParameters["uid"],
        ),
      ),
  '/feed_page/:uid/user_page/:myUsername/:otherUsername': (route) =>
      MaterialPage(
        child: ViewOnlyProfilePage(
            otherUsername: route.pathParameters['otherUsername']!,
            myUsername: route.pathParameters['myUsername']!),
      ),
  '/feed_page/:uid/user_page/:myUsername/:otherUsername/:otheruid/user_images_page':
      (route) => MaterialPage(
            child: UserImagesScreen(
              uid: route.pathParameters['otheruid']!,
            ),
          ),
  '/feed_page/:uid/user_page/:myUsername/:otherUsername/:otheruid/my_story_page':
      (route) => MaterialPage(
            child: ReadOnlyMyStory(
              uid: route.pathParameters['otheruid']!,
            ),
          ),
  '/profile/:uid/add_posts_screen': (route) =>
      const MaterialPage(child: AddPostScreen()),
  '/profile/:uid/add_posts_screen/add_image_screen': (route) =>
      const MaterialPage(child: AddImageScreen()),
  '/profile/:uid/edit_profile_screen': (route) =>
      const MaterialPage(child: EditProfileScreen()),
  '/add_image_screen': (route) => const MaterialPage(child: AddImageScreen()),
  '/edit_profile_screen': (route) =>
      const MaterialPage(child: EditProfileScreen()),
});
