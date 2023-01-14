import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './utils/colors.dart';
import './responsive/mobile_screen_layout.dart';
import './responsive/responsive_layout.dart';
import './responsive/web_screen_layout.dart';

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
      )),
      debugShowCheckedModeBanner: false,
      home: const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout()),
    );
  }
}
