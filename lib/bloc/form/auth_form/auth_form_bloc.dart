import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ebusiness_atk_mobile/models/user_model.dart';
import 'package:ebusiness_atk_mobile/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'auth_form_event.dart';
part 'auth_form_state.dart';

class AuthFormBloc extends Bloc<AuthFormEvent, AuthFormInitial> {
  UserRepository _userRepository = UserRepository();
  AuthFormBloc(this._userRepository) : super(AuthFormInitial(
    addressField: "",
    authErrorMessage: "",
    backgroundBarrierColor: Colors.transparent,
    backgroundTabColor: Colors.transparent,
    confirmPasswordErrorText: "Konfirmasi password tidak boleh kosong!",
    confirmPasswordField: "",
    emailField: "",
    formStatus: Status.signIn,
    formStatusColor: Colors.transparent,
    fullNameField: "",
    hintText: "",
    hintButtonBorderColor: Colors.transparent,
    hintButtonText: "",
    isAddressFieldStateInit: true,
    isAddressFieldValid: false,
    isAdminUser: false,
    isAlertAppeared: false,
    isAuthValid: false,
    isConfirmPasswordFieldStateInit: true,
    isConfirmPasswordFieldValid: false,
    isEmailFieldStateInit: true,
    isEmailFieldValid: false,
    isFormStateInit: true,
    isFormSubmitted: false,
    isFullNameFieldStateInit: true,
    isFullNameFieldValid: false,
    isObscurePasswordToggleOn: true,
    isObscureConfirmPasswordToggleOn: true,
    isPasswordFieldStateInit: true,
    isPasswordFieldValid: false,    
    isSignUpSuccess: false,
    passwordField: "",
    signInBarrierColor: Colors.transparent,
    signUpBarrierColor: Colors.transparent,
    signInTabColor: Colors.transparent,
    signUpTabColor: Colors.transparent,
    submitButtonText: ""
  )) {
    on<AddressFieldChanged>(
      (event, emit) {
        emit(
          state.currentValue(
            addressField: event.addressField,
            isAddressFieldStateInit: false,
            isAddressFieldValid: _isFieldNotEmpty(event.addressField),
          )
        );
      }
    );

    on<AlertDisappeared>(
      (event, emit) {
        emit(
          state.currentValue(
            authErrorMessage: "",
            isAlertAppeared: false,
            isSignUpSuccess: false
          )
        );
      }
    );

    // on<FormLoaded>(
    //   (event, emit) {
    //     emit();
    //   }
    // );

    // on<AuthSignedOut>((event, emit) => _authSignedOut(emit));

    on<AuthStarted>((event, emit) => _authStarted(emit));

    on<ConfirmPasswordFieldChanged>(
      (event, emit) {
        emit(
          state.currentValue(
            confirmPasswordField: event.confirmPasswordField,
            isConfirmPasswordFieldStateInit: false,
            // isConfirmPasswordFieldValid: (event.confirmPasswordField == state.confirmPasswordField),
          )
        );
        if (!_isFieldNotEmpty(event.confirmPasswordField)) emit(
          state.currentValue(
            isConfirmPasswordFieldValid: false,
            confirmPasswordErrorText: "Konfirmasi password tidak boleh kosong!",
          )
        );
        else if (event.confirmPasswordField != state.passwordField) emit(
          state.currentValue(
            isConfirmPasswordFieldValid: false,
            confirmPasswordErrorText: "Konfirmasi password tidak sama!",
          )
        );
        else emit(
          state.currentValue(
            isConfirmPasswordFieldValid: true,
          )
        );
      }
    );

    on<EmailFieldChanged>(
      (event, emit) {
        emit(
          state.currentValue(
            emailField: event.emailField,
            isEmailFieldStateInit: false,
            isEmailFieldValid: _isFieldNotEmpty(event.emailField),
          )
        );
      }
    );

    on<FormInitated>(
      (event, emit) => _formInitiated(emit)
    );

    on<FormRedirected>(
      (event, emit) {
        if (event.formStatus == Status.signIn) _signUpTabSelected(emit);
        else if (event.formStatus == Status.signUp) _signInTabSelected(emit);
      }
    );

    on<FormSubmitted>(
      (event, emit) async {
        // state.currentValue(isFormSubmitted: true);
        if (state.isFormStateInit) emit(
          state.currentValue(
            isAddressFieldStateInit: false,
            isConfirmPasswordFieldStateInit: false,
            isEmailFieldStateInit: false,
            isFormStateInit: false,
            isFullNameFieldStateInit: false,
            isPasswordFieldStateInit: false,
          )
        );
        if (event.formStatus == Status.signIn && (state.emailField.isEmpty || state.passwordField.isEmpty)) {
          // log("form sign in masih belum terpenuhi");
          emit(
            state.currentValue(
              isAlertAppeared: true
            )
          );
        } else if (event.formStatus == Status.signUp && (state.addressField.isEmpty || state.confirmPasswordField.isEmpty || state.emailField.isEmpty || state.fullNameField.isEmpty || state.passwordField.isEmpty)) {
          // log("form sign up masih belum terpenuhi");
          emit(
            state.currentValue(
              isAlertAppeared: true
            )
          );
        } else {
          log("Persyaratan Form telah terpenuhi.");
          UserModel user = UserModel(
            address: state.addressField,
            email: state.emailField,
            name: state.fullNameField,
            password: state.passwordField,
            // phoneNumber: state.phoneNumberField
          );

          if (event.formStatus == Status.signIn) {
            // await 
            try {
              UserCredential? authUser = await _userRepository.signIn(user);
              // UserModel updatedUser = user.copyWith(isVerified: authUser!.user!.emailVerified);
              // if (updatedUser.isVerified!) {
              //   emit(state.copyWith(isLoading: false, errorMessage: ""));
              // } else {
              //   emit(state.copyWith(isFormValid: false, errorMessage: "Please Verify your email, by clicking the link sent to you by mail.", isLoading: false));
              // }
              emit(state.currentValue(isAuthValid: true));
              // context.read<AuthConditionBloc>().add(CurrentAuthRequested());
              // AuthConditionBloc.dispatch(CurrentAuthRequested);
              // emit(state is AuthSuccess);
            } on FirebaseAuthException catch (e) {
              emit(state.currentValue(
                authErrorMessage: e.message
              ));
            }
          } else if (event.formStatus == Status.signUp) {
            try {
              UserCredential? authUser = await _userRepository.signUp(user);
              // UserModel updatedUser = user.copyWith(isVerified: authUser!.user!.emailVerified);
              // if (updatedUser.isVerified!) {
              //   emit(state.copyWith(isLoading: false, errorMessage: ""));
              // } else {
              //   emit(state.copyWith(isFormValid: false, errorMessage: "Please Verify your email, by clicking the link sent to you by mail.", isLoading: false));
              // }
              await _userRepository.saveUserData(user);
              emit(
                state.currentValue(
                  isAuthValid: true,
                  isSignUpSuccess: true,
                )
              );
            } on FirebaseAuthException catch (e) {
              emit(state.currentValue(
                authErrorMessage: e.message
              ));
            }
          }
        }
        // _formInitiated(emit);
        // Future.delayed(const Duration(seconds: 5));
        // state.currentValue(isFormSubmitted: false);
      }
    );

    on<FullNameFieldChanged>(
      (event, emit) {
        emit(
          state.currentValue(
            fullNameField: event.fullNameField,
            isFullNameFieldStateInit: false,
            isFullNameFieldValid: _isFieldNotEmpty(event.fullNameField),
          )
        );
      }
    );

    on<ObscureConfirmPasswordTogglePressed>(
      (event, emit) {
        emit(state.currentValue(isObscureConfirmPasswordToggleOn: !state.isObscureConfirmPasswordToggleOn));
      }
    );

    on<ObscurePasswordTogglePressed>(
      (event, emit) {
        emit(state.currentValue(isObscurePasswordToggleOn: !state.isObscurePasswordToggleOn));
      }
    );

    on<PasswordFieldChanged>(
      (event, emit) {
        emit(
          state.currentValue(
            passwordField: event.passwordField,
            isPasswordFieldStateInit: false,
            isPasswordFieldValid: _isFieldNotEmpty(event.passwordField),
          )
        );
        if (event.passwordField == state.confirmPasswordField) emit(
          state.currentValue(
            isConfirmPasswordFieldValid: true,
          )
        );
        else emit(
          state.currentValue(
            isConfirmPasswordFieldValid: false,
            confirmPasswordErrorText: "Konfirmasi password tidak sama!",
          )
        );
      }
    );

    on<SignInTabSelected>(
      (event, emit) => _signInTabSelected(emit));

    on<SignUpTabSelected>(
      (event, emit) => _signUpTabSelected(emit));
  }

  _authSignedOut(Emitter emit) async {
    await _userRepository.signOut();
    emit(state.currentValue(isAuthValid: false));
    // emit(AuthFailure());
  }

  _authStarted(Emitter emit) async {
    UserModel user = await _userRepository.getCurrentUser().first;
    if (user.userID != "uid") {
      // String? displayName = await _userRepository.retrieveUserName(user);
      // emit(AuthenticationSuccess(displayName: displayName));
      emit(state.currentValue(isAuthValid: false)); // turn off the "toggle"
    //   emit(state is AuthSuccess);
    // } else {
    //   emit(AuthFailure());
    }
  }

  _formInitiated(Emitter emit) => _signInTabSelected(emit);

  _signInTabSelected(Emitter emit) {
    emit(
      state.currentValue(
        backgroundBarrierColor: Colors.green.shade200,
        backgroundTabColor: Colors.red.shade100,
        formStatus: Status.signIn,
        formStatusColor: Colors.green.shade200,
        hintText: "Belum punya akun?",
        hintButtonBorderColor: Colors.red.shade100,
        hintButtonText: "Mendaftar",
        signInBarrierColor: Colors.transparent,
        signInTabColor: Colors.green.shade200,
        signUpBarrierColor: Colors.red.shade100,
        signUpTabColor: Colors.transparent,
        submitButtonText: "Masuk"
      )
    );
  }

  _signUpTabSelected(Emitter emit) {
    emit(
      state.currentValue(
        backgroundBarrierColor: Colors.red.shade200,
        backgroundTabColor: Colors.green.shade100,
        formStatus: Status.signUp,
        formStatusColor: Colors.red.shade200,
        hintText: "Sudah punya akun?",
        hintButtonBorderColor: Colors.green.shade100,
        hintButtonText: "Masuk",
        signInBarrierColor: Colors.green.shade100,
        signInTabColor: Colors.transparent,
        signUpBarrierColor: Colors.transparent,
        signUpTabColor: Colors.red.shade200,
        submitButtonText: "Buat Akun"
      )
    );
  }
}

bool _isFieldNotEmpty(String fieldValue) {
  return fieldValue.isNotEmpty;
}
