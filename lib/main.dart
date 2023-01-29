import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './utils/colors.dart';
// import './responsive/mobile_screen_layout.dart';
// import './responsive/responsive_layout.dart';
// import './responsive/web_screen_layout.dart';
import './screens/signup_screen.dart';
import './screens/login_screen.dart';
import './screens/home_page_screen.dart';
import './screens/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enabled',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primaryAppColor,
        secondary: accentappColor,
        tertiary: buttonColor,
      )),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnapshot) {
            if (userSnapshot.hasData) {
              return const HomePage();
            }
            return const LoginScreen();
          }),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home_page': (context) => const HomePage(),
        '/profile_page': (context) => const ProfilePage(),
      },
      // home: const ResponsiveLayout(
      //     mobileScreenLayout: MobileScreenLayout(),
      //     webScreenLayout: WebScreenLayout()),
    );
  }
}
