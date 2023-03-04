import 'package:enabled_try_1/features/My_story/Screen/my_story.dart';
import 'package:enabled_try_1/features/Notifications/screen/notifications_screen.dart';
import 'package:enabled_try_1/features/Profile/screen/read_only_profile.dart';
import 'package:enabled_try_1/features/User_posts/Screen/user_images_screen.dart';
import 'package:enabled_try_1/features/edit_profile/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import 'package:enabled_try_1/features/Add_post/screens/add_image_screen.dart';
import 'package:enabled_try_1/features/Add_post/screens/add_post_screen.dart';
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
  //---------------------------Home routes-----------------------------------------------------------

  '/': (_) => TransitionPage(
      child: HomePage(),
      pushTransition: PageTransition.none,
      popTransition: PageTransition.none),
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
  '/add_image_screen': (route) => const MaterialPage(child: AddImageScreen()),
  '/edit_profile_screen': (route) =>
      const MaterialPage(child: EditProfileScreen()),
  '/notifications/:uid': (route) => MaterialPage(
        child: Notifications(
          uid: route.pathParameters['uid']!,
        ),
      ),
  '/my_story/:uid': (route) => MaterialPage(
        child: MyStory(
          uid: route.pathParameters['uid']!,
        ),
      ),

  '/user_page/:myUsername/:otherUsername/:page': (route) => MaterialPage(
        child: ViewOnlyProfilePage(
            page: route.pathParameters['page']!,
            otherUsername: route.pathParameters['otherUsername']!,
            myUsername: route.pathParameters['myUsername']!),
      ),

  '/user_page/:myUsername/:otherUsername/:page/my_story/:uid': (route) =>
      MaterialPage(
        child: ReadOnlyMyStory(
          uid: route.pathParameters['uid']!,
        ),
      ),
  //------------------------Profile routes-----------------------

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
  '/profile/:uid/add_posts_screen': (route) =>
      const MaterialPage(child: AddPostScreen()),
  '/profile/:uid/add_posts_screen/add_image_screen': (route) =>
      const MaterialPage(child: AddImageScreen()),
  '/profile/:uid/edit_profile_screen': (route) =>
      const MaterialPage(child: EditProfileScreen()),
  '/profile/:uid/feed_screen': (route) => MaterialPage(
          child: FeedScreen(
        uid: route.pathParameters['uid']!,
      )),
  '/profile/:uid/notifications': (route) => MaterialPage(
          child: Notifications(
        uid: route.pathParameters['uid']!,
      )),

  '/profile/:uid/friends/user_page/:myUsername/:otherUsername/:page': (route) =>
      MaterialPage(
        child: ViewOnlyProfilePage(
            page: route.pathParameters['page']!,
            otherUsername: route.pathParameters['otherUsername']!,
            myUsername: route.pathParameters['myUsername']!),
      ),

  // '/profile/:uid/friends'

  //--------------------------Feed page routes-------------------------------

  '/feed_page/:uid/user_page/:myUsername/:otherUsername/:page': (route) =>
      MaterialPage(
        child: ViewOnlyProfilePage(
            page: route.pathParameters['page']!,
            otherUsername: route.pathParameters['otherUsername']!,
            myUsername: route.pathParameters['myUsername']!),
      ),
  '/feed_page/:uid/user_page/:myUsername/:otherUsername/user_images_page/:otheruid':
      (route) => MaterialPage(
            child: UserImagesScreen(
              uid: route.pathParameters['otheruid']!,
            ),
          ),
  '/feed_page/:uid/user_page/:myUsername/:otherUsername/:page/:otheruid/my_story_page':
      (route) => MaterialPage(
            child: ReadOnlyMyStory(
              uid: route.pathParameters['otheruid']!,
            ),
          ),
  '/feed_page/:uid/notifications': (route) => MaterialPage(
          child: Notifications(
        uid: route.pathParameters['uid']!,
      )),
  '/feed_page/:uid/user_images_page': (route) => MaterialPage(
        child: UserImagesScreen(
          uid: route.pathParameters['uid']!,
        ),
      ),
  '/feed_page/:uid/my_story': (route) => MaterialPage(
        child: MyStory(
          uid: route.pathParameters["uid"],
        ),
      ),
  '/feed_page/:uid/add_posts_screen': (route) =>
      const MaterialPage(child: AddPostScreen()),
  '/feed_page/:uid/edit_profile_screen': (route) =>
      const MaterialPage(child: EditProfileScreen()),
  '/feed_page/:uid/profile': (route) => TransitionPage(
      child: ProfilePage(
        uid: route.pathParameters['uid']!,
      ),
      pushTransition: PageTransition.none,
      popTransition: PageTransition.none),

  //------------------Notifications route----------------
  '/notifications/:uid/user_images_page': (route) => MaterialPage(
        child: UserImagesScreen(
          uid: route.pathParameters['uid']!,
        ),
      ),
  '/notifications/:uid/my_story': (route) => MaterialPage(
        child: MyStory(
          uid: route.pathParameters["uid"],
        ),
      ),
  '/notifications/:uid/add_posts_screen': (route) =>
      const MaterialPage(child: AddPostScreen()),
  '/notifications/:uid/add_posts_screen/add_image_screen': (route) =>
      const MaterialPage(child: AddImageScreen()),
  '/notifications/:uid/edit_profile_screen': (route) =>
      const MaterialPage(child: EditProfileScreen()),
  '/notifications/:uid/feed_screen': (route) => MaterialPage(
          child: FeedScreen(
        uid: route.pathParameters['uid']!,
      )),
  '/notifications/:uid/profile': (route) => TransitionPage(
      child: ProfilePage(
        uid: route.pathParameters['uid']!,
      ),
      pushTransition: PageTransition.none,
      popTransition: PageTransition.none),
});
