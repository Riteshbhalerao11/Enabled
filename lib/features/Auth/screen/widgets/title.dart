import 'package:flutter/material.dart';

class TitleWidg extends StatelessWidget {
  const TitleWidg({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Enabled",
      style: TextStyle(
        height: 0.5,
        fontSize: 72,
        color: Theme.of(context).textTheme.titleLarge?.color,
        fontFamily: 'Pacifico',
        shadows: const [
          Shadow(offset: Offset(1, 5), blurRadius: 4.0, color: Colors.black26)
        ],
      ),
    );
  }
}
