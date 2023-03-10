import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routemaster/routemaster.dart';

class NavButtons extends StatelessWidget {
  final String title;
  final bool isSelected;
  final String page;
  const NavButtons(this.title, this.isSelected, this.page, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        isSelected ? Null : Routemaster.of(context).push(page);
      },
      style: TextButton.styleFrom(
        backgroundColor: isSelected
            ? Theme.of(context).colorScheme.tertiary
            : Theme.of(context).colorScheme.onPrimaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        fixedSize: const Size.fromWidth(110),
        elevation: 5,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'SecularOne',
          fontSize: 16,
          letterSpacing: 1.28,
          color: isSelected
              ? Theme.of(context).colorScheme.onPrimaryContainer
              : Theme.of(context).colorScheme.onSecondaryContainer,
        ),
      ),
    );
  }
}
