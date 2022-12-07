import 'package:ebusiness_atk_mobile/views/components/custom_auth_form.dart';
import 'package:flutter/material.dart';

class AuthFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: Text("Masuk / Mendaftar"),
      ),
      body: CustomAuthForm() // Custom components, not a page
    );
  }
}