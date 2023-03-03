import 'package:flutter/material.dart';

class TitleWidg extends StatelessWidget {
  const TitleWidg({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "App logo",
      child: const Text(
        "Enabled",
        style: TextStyle(
          height: 0.5,
          fontSize: 72,
          color: Colors.white,
          fontFamily: 'Pacifico',
          shadows: [
            Shadow(offset: Offset(1, 5), blurRadius: 4.0, color: Colors.black26)
          ],
        ),
      ),
    );
  }
}
