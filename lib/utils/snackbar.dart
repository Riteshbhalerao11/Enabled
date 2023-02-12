import 'package:flutter/material.dart';

void showSnackBar(BuildContext ctx, String message) {
  ScaffoldMessenger.of(ctx)
    ..hideCurrentSnackBar
    ..showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Colors.red,
        padding: const EdgeInsetsDirectional.all(24),
      ),
    );
}
