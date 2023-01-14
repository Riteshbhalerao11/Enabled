import 'package:enabled_try_1/utils/dimensions.dart';
import "package:flutter/material.dart";

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout(
      {super.key,
      required this.mobileScreenLayout,
      required this.webScreenLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreensize) {
        return webScreenLayout;
      }

      return mobileScreenLayout;
    });
  }
}
