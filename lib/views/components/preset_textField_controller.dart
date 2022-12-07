import 'package:flutter/material.dart';

class PresetTextFieldController {
  final String value;
  TextEditingController controller = TextEditingController();

  PresetTextFieldController({required this.value}) {
    controller.text = value;
    controller.selection = TextSelection.fromPosition(
      TextPosition(
        offset: controller.text.length
      )
    );
  }

  get getController{
    return controller;
  }
}