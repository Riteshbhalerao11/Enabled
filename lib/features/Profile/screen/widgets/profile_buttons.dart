import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class MediaButton extends StatelessWidget {
  const MediaButton({super.key, required this.path, required this.title});
  final String title;
  final String path;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Routemaster.of(context).push(path);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: Text(title,
            style: TextStyle(
                fontFamily: "Signika",
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                letterSpacing: 1.2)),
      ),
    );
  }
}
