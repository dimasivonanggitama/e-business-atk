part of 'auth_form_bloc.dart';

abstract class AuthFormEvent extends Equatable {
  const AuthFormEvent();

  @override
  List<Object> get props => [];
}

class AddressFieldChanged extends AuthFormEvent {
  final String addressField;
  const AddressFieldChanged(this.addressField);

  @override
  List<Object> get props => [addressField];
}

class AlertDisappeared extends AuthFormEvent {
  
  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthFormEvent {
  
  @override
  List<Object> get props => [];
}

class ConfirmPasswordFieldChanged extends AuthFormEvent {
  final String confirmPasswordField;
  const ConfirmPasswordFieldChanged(this.confirmPasswordField);

  @override
  List<Object> get props => [confirmPasswordField];
}

class EmailFieldChanged extends AuthFormEvent {
  final String emailField;
  const EmailFieldChanged(this.emailField);

  @override
  List<Object> get props => [emailField];
}

class FormInitated extends AuthFormEvent {
  
  @override
  List<Object> get props => [];
}

class FormRedirected extends AuthFormEvent {
  final Status formStatus;
  const FormRedirected(this.formStatus);

  @override
  List<Object> get props => [formStatus];
}

class FormSubmitted extends AuthFormEvent {
  final Status formStatus;
  const FormSubmitted(this.formStatus);

  @override
  List<Object> get props => [formStatus];
}

class FullNameFieldChanged extends AuthFormEvent {
  final String fullNameField;
  const FullNameFieldChanged(this.fullNameField);

  @override
  List<Object> get props => [fullNameField];
}

class ObscureConfirmPasswordTogglePressed extends AuthFormEvent {
  const ObscureConfirmPasswordTogglePressed();

  @override
  List<Object> get props => [];
}

class ObscurePasswordTogglePressed extends AuthFormEvent {
  const ObscurePasswordTogglePressed();

  @override
  List<Object> get props => [];
}

class PasswordFieldChanged extends AuthFormEvent {
  final String passwordField;
  const PasswordFieldChanged(this.passwordField);

  @override
  List<Object> get props => [passwordField];
}

class SignInTabSelected extends AuthFormEvent {
  
  @override
  List<Object> get props => [];
}

class SignUpTabSelected extends AuthFormEvent {
  
  @override
  List<Object> get props => [];
}