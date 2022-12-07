import 'package:flutter/material.dart';

class PresetSnackbar {
  final String message;

  PresetSnackbar({required BuildContext context, required this.message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: "OK",
          onPressed: () {}
        ),
      )
    );
  }
}