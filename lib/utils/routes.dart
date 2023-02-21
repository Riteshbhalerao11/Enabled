import 'package:enabled_try_1/features/Add%20post/screens/add_post_screen.dart';
import 'package:enabled_try_1/features/Auth/screen/signup_screen.dart';
import 'package:enabled_try_1/features/Feed_page/screen/feed_screen.dart';
import 'package:enabled_try_1/features/Profile/screen/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import '../features/Auth/screen/login_screen.dart';
import '../features/Home/Screens/home_page_screen.dart';

//loggedout
final loggedoutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

//Loggedin
final loggedinRoute = RouteMap(routes: {
  '/': (_) => const TransitionPage(
      child: HomePage(),
      pushTransition: PageTransition.none,
      popTransition: PageTransition.none),
  // '/signup': (_) => const MaterialPage(child: SignupScreen()),
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
  '/add_post': (route) => const MaterialPage(child: AddPostScreen()),
  // '/edit_profile/:bio/:profilepic': (route) => MaterialPage(
  //         child: EditProfileScreen(
  //       parentBio: route.pathParameters['bio']!,
  //       parentProfilepic: route.pathParameters['profilepic']!,
  //     ))
});
