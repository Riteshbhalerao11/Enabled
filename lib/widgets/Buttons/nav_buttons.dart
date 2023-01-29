import 'package:flutter/material.dart';

class NavButtons extends StatelessWidget {
  final String title;
  final bool isSelected;
  final String page;
  const NavButtons(this.title, this.isSelected, this.page, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        isSelected ? Null : Navigator.of(context).pushReplacementNamed(page);
      },
      style: TextButton.styleFrom(
        backgroundColor:
            isSelected ? Theme.of(context).colorScheme.tertiary : Colors.white,
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
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
