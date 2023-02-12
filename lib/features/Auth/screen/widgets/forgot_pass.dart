
import 'package:flutter/material.dart';

class ForgotPass extends StatelessWidget {
  const ForgotPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TextButton(
        onPressed: () {},
        child: Text(
          "forgot password ?",
          style: TextStyle(
              fontFamily: 'Lora',
              fontSize: 20,
              color: Theme.of(context).textTheme.titleLarge?.color),
        ),
      ),
    );
  }
}
