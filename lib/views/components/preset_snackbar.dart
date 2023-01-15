import 'package:flutter/material.dart';

class PresetSnackbar {
  final String message;

  PresetSnackbar({bool action = true, color, required BuildContext context, required this.message, onVisible}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(message),
        onVisible: onVisible,
        action: (action)? SnackBarAction(
          label: "OK",
          onPressed: () {}
        ) : null,
      )
    );
  }
}