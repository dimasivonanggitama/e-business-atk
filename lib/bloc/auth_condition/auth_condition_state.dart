part of 'auth_condition_bloc.dart';

abstract class AuthConditionState extends Equatable {
  const AuthConditionState();
  
  @override
  List<Object> get props => [];
}

// class AuthenticationInitial extends AuthConditionState {}

class Unauthorized extends AuthConditionState {
  
  @override
  List<Object> get props => [];
}

class AuthSuccess extends AuthConditionState {
  final String uid;
  AuthSuccess(this.uid);

  @override
  List<Object> get props => [uid];
}
