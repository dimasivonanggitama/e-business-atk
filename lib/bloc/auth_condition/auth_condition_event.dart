part of 'auth_condition_bloc.dart';

abstract class AuthConditionEvent extends Equatable {
  const AuthConditionEvent();

  @override
  List<Object> get props => [];
}

class AuthSignedOut extends AuthConditionEvent {
  
  @override
  List<Object> get props => [];
}

class CurrentAuthRequested extends AuthConditionEvent {

  @override
  List<Object> get props => [];
}
