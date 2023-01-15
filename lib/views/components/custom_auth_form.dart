import 'dart:developer';

import 'package:ebusiness_atk_mobile/bloc/auth_condition/auth_condition_bloc.dart';
import 'package:ebusiness_atk_mobile/bloc/form/auth_form/auth_form_bloc.dart';
import 'package:ebusiness_atk_mobile/views/components/custom_button.dart';
import 'package:ebusiness_atk_mobile/views/components/preset_popUpAlert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'preset_snackbar.dart';
import 'preset_textField.dart';
import 'preset_textField_controller.dart';

// class authFormPage extends StatefulWidget {
class CustomAuthForm extends StatelessWidget {
  final bool isInstructionTextShowed;

  CustomAuthForm({
    this.isInstructionTextShowed = false
  });

  @override
  Widget build(BuildContext context) {
    context.read<AuthFormBloc>().add(FormInitated());
    return Scaffold(
      appBar: isInstructionTextShowed? AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          "Anda harus login terlebih dahulu!", 
          style: TextStyle(fontSize: 16)
        ),
      ) : null,
      body: ListView(
        children: [
          MultiBlocListener(
            listeners: [
              BlocListener<AuthFormBloc, AuthFormInitial>(
                listener: (context, state) {
                  // if (state.isFormSubmitted) {
                  //   showDialog(
                  //     context: context, 
                  //     builder: (BuildContext context) {
                  //       return Padding(
                  //         padding: EdgeInsets.symmetric(horizontal: 100, vertical: 250),
                  //         child: CircularProgressIndicator(),
                  //       );
                  //     }
                  //   );
                  // }
                  if (state.authErrorMessage.isNotEmpty) {
                    PresetPopUpAlert(context: context, description: state.authErrorMessage, firstActionButtonText: "OK", title: "Kesalahan!");
                    // if (state.formStatus == Status.signIn)
                    // } else if (state.isAuthValid && state.formStatus == Status.signUp) {
                  } else if (state.isAuthValid) {
                    if (state.isSignUpSuccess) PresetPopUpAlert(context: context, description: "Akun berhasil ditambahkan!", firstActionButtonText: "OK", title: "Informasi");
                    context.read<AuthConditionBloc>().add(CurrentAuthRequested());
                  } else if (!state.isFormStateInit && state.isAlertAppeared) {
                    PresetSnackbar(context: context, message: "Kesalahan! Ada kolom formulir yang belum valid.");
                  }
                  context.read<AuthFormBloc>().add(AlertDisappeared());
                },
              ),
              BlocListener<AuthConditionBloc, AuthConditionState>(
                listener: (context, state) {
                  if (state is AuthSuccess) Navigator.pop(context);
                },
              ),
            ],
            child: BlocBuilder<AuthFormBloc, AuthFormInitial>(
              builder: (context, state) {
                // if (state is AuthFormInitial) {
                PresetTextFieldController addressFieldController = PresetTextFieldController(value: state.addressField);
                PresetTextFieldController confirmPasswordFieldController = PresetTextFieldController(value: state.confirmPasswordField);
                PresetTextFieldController emailFieldController = PresetTextFieldController(value: state.emailField);
                PresetTextFieldController fullNameFieldController = PresetTextFieldController(value: state.fullNameField);
                PresetTextFieldController passwordFieldController = PresetTextFieldController(value: state.passwordField);
                return Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, 
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                          color: state.backgroundTabColor,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => context.read<AuthFormBloc>().add(SignInTabSelected()),
                                child: Container(
                                  decoration: BoxDecoration(
                                    // border: Border(
                                    //   top: BorderSide(color: Colors.black, style: BorderStyle.solid)
                                    // ),
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                    color: state.signInTabColor
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Text("Masuk"),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => context.read<AuthFormBloc>().add(SignUpTabSelected()),
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)), color: state.signUpTabColor),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Text("Mendaftar"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Barrier
                      Container(
                        color: state.backgroundBarrierColor,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(color: state.signInBarrierColor, borderRadius: BorderRadius.only(bottomRight: Radius.circular(15))),
                                padding: EdgeInsets.only(bottom: 15),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(color: state.signUpBarrierColor, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15))),
                                padding: EdgeInsets.only(bottom: 15),
                              ),
                            )
                          ],
                        ),
                      ),

                      //Form fields
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
                          color: state.formStatusColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                              // color: Colors.grey[100],
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(padding: EdgeInsets.only(top: 15)),
                                PresetTextField(
                                  controller: emailFieldController.getController,
                                  labelText: "Email",
                                  fieldOnChanged: (value) => context.read<AuthFormBloc>().add(EmailFieldChanged(value)),
                                  errorText: (!state.isEmailFieldStateInit && state.isEmailFieldValid == false) ? 'Email tidak boleh kosong!' : null,
                                ),
                                PresetTextField(
                                  controller: passwordFieldController.getController,
                                  isPasswordFieldType: true,
                                  labelText: "Password",
                                  fieldOnChanged: (value) => context.read<AuthFormBloc>().add(PasswordFieldChanged(value)),
                                  errorText: (!state.isPasswordFieldStateInit && state.isPasswordFieldValid == false) ? 'Password tidak boleh kosong!' : null,
                                  obscureText: state.isObscurePasswordToggleOn,
                                  obscureTextToggleOnPressed: () => context.read<AuthFormBloc>().add(ObscurePasswordTogglePressed()),
                                ),
                                if (state.formStatus == Status.signUp)
                                  PresetTextField(
                                    controller: confirmPasswordFieldController.getController,
                                    isPasswordFieldType: true,
                                    labelText: "Konfirmasi Password",
                                    fieldOnChanged: (value) => context.read<AuthFormBloc>().add(ConfirmPasswordFieldChanged(value)),
                                    errorText: (!state.isConfirmPasswordFieldStateInit && state.isConfirmPasswordFieldValid == false) ? state.confirmPasswordErrorText : null,
                                    obscureText: state.isObscureConfirmPasswordToggleOn,
                                    obscureTextToggleOnPressed: () => context.read<AuthFormBloc>().add(ObscureConfirmPasswordTogglePressed()),
                                  ),
                                if (state.formStatus == Status.signUp)
                                  PresetTextField(
                                    controller: fullNameFieldController.getController,
                                    labelText: "Nama Lengkap",
                                    fieldOnChanged: (value) => context.read<AuthFormBloc>().add(FullNameFieldChanged(value)),
                                    errorText: (!state.isFullNameFieldStateInit && state.isFullNameFieldValid == false) ? 'Nama Lengkap tidak boleh kosong!' : null,
                                  ),
                                if (state.formStatus == Status.signUp)
                                  PresetTextField(
                                    controller: addressFieldController.getController,
                                    labelText: "Alamat",
                                    fieldOnChanged: (value) => context.read<AuthFormBloc>().add(AddressFieldChanged(value)),
                                    // errorText: (!state.isStateInit && state.addressFieldChanged == false)
                                    // ? 'Alamat tidak boleh kosong!'
                                    // : null,
                                  ),
                                CustomButton(
                                  color: state.formStatusColor,
                                  text: state.submitButtonText,
                                  // textBold: true,
                                  // textColor: Colors.white,
                                  onTap: () => context.read<AuthFormBloc>().add(FormSubmitted(state.formStatus)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Hint
                      Padding(padding: EdgeInsets.all(15), child: Text(state.hintText)),
                      CustomButton(
                        borderColor: state.hintButtonBorderColor,
                        borderRadius: 20,
                        borderWidth: 5,
                        text: state.hintButtonText,
                        onTap: () => context.read<AuthFormBloc>().add(FormRedirected(state.formStatus)),
                      ),

                      // if (state.isAuthValid)
                      //   customButton(
                      //     borderColor: state.hintButtonBorderColor,
                      //     borderRadius: 20,
                      //     borderWidth: 5,
                      //     text: "Sign Out",
                      //     onTap: () => context.read<AuthFormBloc>().add(AuthSignedOut()),
                      //   ),
                    ]
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
