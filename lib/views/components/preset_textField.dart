import 'dart:developer';

import 'package:flutter/material.dart';

class PresetTextField extends StatelessWidget {
  final String? errorText;
  final controller;
  final Function(String)? fieldOnChanged;
  final bool isPasswordFieldType;
  final TextInputType? keyboardType;
  final String labelText;
  final bool obscureText;
  final Function()? obscureTextToggleOnPressed;

  PresetTextField({
    this.errorText = null,
    this.controller,
    this.fieldOnChanged = null,
    this.isPasswordFieldType = false,
    this.keyboardType = TextInputType.name,
    required this.labelText,
    this.obscureText = false,
    this.obscureTextToggleOnPressed = null
  });

  // bool obscureText = widget.isPasswordFieldType;
  @override
  Widget build(BuildContext context) {
    // log("obscureText: ${obscureText}");
    // log("widget.isPasswordFieldType: ${widget.isPasswordFieldType}");
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: fieldOnChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(), //shape for all condition
          contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          errorText: errorText,
          labelText: labelText,
          suffixIcon: (isPasswordFieldType)? IconButton(
            icon: Icon(Icons.remove_red_eye),
            // onPressed: () => setState(() { log("obscureText1: ${obscureText}"); obscureText = !obscureText; log("obscureText2: ${obscureText}");})
            onPressed: obscureTextToggleOnPressed
          ) : null
        ),
      ),
    );
  }
}