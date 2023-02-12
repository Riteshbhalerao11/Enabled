import 'package:enabled_try_1/features/Profile/Screens/profile_page.dart';
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
      child: HomePage(), pushTransition: PageTransition.none),
  '/profile_page': (_) => const TransitionPage(
      child: ProfilePage(), pushTransition: PageTransition.none),
  // '/feed_page' :(_) => const MaterialPage(child: )
});
