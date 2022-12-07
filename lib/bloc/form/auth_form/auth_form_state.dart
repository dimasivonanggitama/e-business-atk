part of 'auth_form_bloc.dart';
enum Status { signIn, signUp }

abstract class AuthFormState extends Equatable {
  const AuthFormState();
}

// class AuthValidate extends AuthFormState {
  
//   @override
//   List<Object> get props => [];
// }

// class AuthSuccess extends AuthFormState {
//   // final String? displayName;
//   // const AuthSuccess({this.displayName});

//   @override
//   // List<Object?> get props => [displayName];
//   List<Object?> get props => [];
// }

// class AuthFailure extends AuthFormState {
//   @override
//   List<Object?> get props => [];
// }

class AuthFormInitial extends AuthFormState {
  final String addressField;
  final String authErrorMessage;
  final Color backgroundBarrierColor;
  final Color backgroundTabColor;
  final String confirmPasswordErrorText;
  final String confirmPasswordField;
  final String emailField;
  final Status formStatus;
  final Color formStatusColor;
  final String fullNameField;
  final String hintText;
  final Color hintButtonBorderColor;
  final String hintButtonText;
  final bool isAddressFieldStateInit;
  final bool isAddressFieldValid;
  final bool isAdminUser;
  final bool isAlertAppeared;
  final bool isAuthValid;
  final bool isConfirmPasswordFieldStateInit;
  final bool isConfirmPasswordFieldValid;
  final bool isEmailFieldStateInit;
  final bool isEmailFieldValid;
  final bool isFormStateInit;
  final bool isFullNameFieldStateInit;
  final bool isFullNameFieldValid;
  final bool isObscurePasswordToggleOn;
  final bool isObscureConfirmPasswordToggleOn;
  final bool isPasswordFieldStateInit;
  final bool isPasswordFieldValid;
  final bool isSignUpSuccess;
  final String passwordField;
  final Color signInBarrierColor;
  final Color signInTabColor;
  final Color signUpBarrierColor;
  final Color signUpTabColor;
  final String submitButtonText;

  const AuthFormInitial({
    required this.addressField,
    required this.authErrorMessage,
    required this.backgroundBarrierColor,
    required this.backgroundTabColor,
    required this.confirmPasswordErrorText,
    required this.confirmPasswordField,
    required this.emailField,
    required this.formStatus,
    required this.formStatusColor,
    required this.fullNameField,
    required this.hintText,
    required this.hintButtonBorderColor,
    required this.hintButtonText,
    required this.isAddressFieldStateInit,
    required this.isAddressFieldValid,
    required this.isAdminUser,
    required this.isAlertAppeared,
    required this.isAuthValid,
    required this.isConfirmPasswordFieldStateInit,
    required this.isConfirmPasswordFieldValid,
    required this.isEmailFieldStateInit,
    required this.isEmailFieldValid,
    required this.isFormStateInit,
    required this.isFullNameFieldStateInit,
    required this.isFullNameFieldValid,
    required this.isObscurePasswordToggleOn,
    required this.isObscureConfirmPasswordToggleOn,
    required this.isPasswordFieldStateInit,
    required this.isPasswordFieldValid,
    required this.isSignUpSuccess,
    required this.passwordField,
    required this.signInBarrierColor,
    required this.signInTabColor,
    required this.signUpBarrierColor,
    required this.signUpTabColor,
    required this.submitButtonText
  });

  AuthFormInitial currentValue({
    String? addressField,
    String? authErrorMessage,
    Color? backgroundBarrierColor,
    Color? backgroundTabColor,
    String? confirmPasswordErrorText,
    String? confirmPasswordField,
    String? emailField,
    Status? formStatus,
    Color? formStatusColor,
    String? fullNameField,
    String? hintText,
    Color? hintButtonBorderColor,
    String? hintButtonText,
    bool? isAddressFieldStateInit,
    bool? isAddressFieldValid,
    bool? isAdminUser,
    bool? isAlertAppeared,
    bool? isAuthValid,
    bool? isConfirmPasswordFieldStateInit,
    bool? isConfirmPasswordFieldValid,
    bool? isEmailFieldStateInit,
    bool? isEmailFieldValid,
    bool? isFormStateInit,
    bool? isFullNameFieldStateInit,
    bool? isFullNameFieldValid,
    bool? isObscurePasswordToggleOn,
    bool? isObscureConfirmPasswordToggleOn,
    bool? isPasswordFieldStateInit,
    bool? isPasswordFieldValid,
    bool? isSignUpSuccess,
    String? passwordField,
    Color? signInBarrierColor,
    Color? signInTabColor,
    Color? signUpBarrierColor,
    Color? signUpTabColor,
    String? submitButtonText
  }) {
    return AuthFormInitial(
      addressField: addressField ?? this.addressField,
      authErrorMessage: authErrorMessage ?? this.authErrorMessage,
      backgroundBarrierColor: backgroundBarrierColor ?? this.backgroundBarrierColor,
      backgroundTabColor: backgroundTabColor ?? this.backgroundTabColor,
      confirmPasswordErrorText: confirmPasswordErrorText ?? this.confirmPasswordErrorText, 
      confirmPasswordField: confirmPasswordField ?? this.confirmPasswordField, 
      emailField: emailField ?? this.emailField, 
      formStatus: formStatus ?? this.formStatus, 
      formStatusColor: formStatusColor ?? this.formStatusColor,
      fullNameField: fullNameField ?? this.fullNameField, 
      hintText: hintText ?? this.hintText,
      hintButtonBorderColor: hintButtonBorderColor ?? this.hintButtonBorderColor,
      hintButtonText: hintButtonText ?? this.hintButtonText,
      isAddressFieldStateInit: isAddressFieldStateInit ?? this.isAddressFieldStateInit, 
      isAddressFieldValid: isAddressFieldValid ?? this.isAddressFieldValid,
      isAdminUser: isAdminUser ?? this.isAdminUser,
      isAlertAppeared: isAlertAppeared ?? this.isAlertAppeared,
      isAuthValid: isAuthValid ?? this.isAuthValid, 
      isConfirmPasswordFieldStateInit: isConfirmPasswordFieldStateInit ?? this.isConfirmPasswordFieldStateInit, 
      isConfirmPasswordFieldValid: isConfirmPasswordFieldValid ?? this.isConfirmPasswordFieldValid, 
      isEmailFieldStateInit: isEmailFieldStateInit ?? this.isEmailFieldStateInit,
      isEmailFieldValid: isEmailFieldValid ?? this.isEmailFieldValid,
      isFormStateInit: isFormStateInit ?? this.isFormStateInit,
      isFullNameFieldStateInit: isFullNameFieldStateInit ?? this.isFullNameFieldStateInit, 
      isFullNameFieldValid: isFullNameFieldValid ?? this.isFullNameFieldValid,
      isObscurePasswordToggleOn: isObscurePasswordToggleOn ?? this.isObscurePasswordToggleOn,
      isObscureConfirmPasswordToggleOn: isObscureConfirmPasswordToggleOn ?? this.isObscureConfirmPasswordToggleOn,
      isPasswordFieldStateInit: isPasswordFieldStateInit ?? this.isPasswordFieldStateInit,
      isPasswordFieldValid: isPasswordFieldValid ?? this.isPasswordFieldValid,
      isSignUpSuccess: isSignUpSuccess ?? this.isSignUpSuccess, 
      passwordField: passwordField ?? this.passwordField, 
      signInBarrierColor: signInBarrierColor ?? this.signInBarrierColor,
      signInTabColor: signInTabColor ?? this.signInTabColor, 
      signUpBarrierColor: signUpBarrierColor ?? this.signUpBarrierColor,
      signUpTabColor: signUpTabColor ?? this.signUpTabColor,
      submitButtonText: submitButtonText ?? this.submitButtonText
    );
  }
  
  @override
  List<Object> get props => [
    addressField,
    authErrorMessage,
    backgroundBarrierColor,
    backgroundTabColor,
    confirmPasswordErrorText,
    confirmPasswordField,
    emailField,
    formStatus,
    formStatusColor,
    fullNameField,
    hintText,
    hintButtonBorderColor,
    hintButtonText,
    isAddressFieldStateInit,
    isAddressFieldValid,
    isAdminUser,
    isAlertAppeared,
    isAuthValid,
    isConfirmPasswordFieldStateInit,
    isConfirmPasswordFieldValid,
    isEmailFieldStateInit,
    isEmailFieldValid,
    isFormStateInit,
    isFullNameFieldStateInit,
    isFullNameFieldValid,
    isObscurePasswordToggleOn,
    isObscureConfirmPasswordToggleOn,
    isPasswordFieldStateInit,
    isPasswordFieldValid,
    isSignUpSuccess,
    passwordField,
    signInBarrierColor,
    signInTabColor,
    signUpBarrierColor,
    signUpTabColor,
    submitButtonText
  ];
}

