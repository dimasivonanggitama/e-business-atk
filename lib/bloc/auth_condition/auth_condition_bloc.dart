import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/user_model.dart';
import '../../repository/user_repository.dart';

part 'auth_condition_event.dart';
part 'auth_condition_state.dart';

class AuthConditionBloc extends Bloc<AuthConditionEvent, AuthConditionState> {
  UserRepository _userRepository = UserRepository();
  AuthConditionBloc(this._userRepository) : super(Unauthorized()) {
    on<CurrentAuthRequested>(
      (event, emit) async {
        UserModel user = await _userRepository.getCurrentUser().first;
        if (user.uid != "uid") {
          // String? displayName = await _authenticationRepository.retrieveUserName(user);
          // emit(AuthenticationSuccess(displayName: displayName));
          emit(AuthSuccess(user.uid.toString()));
        } else {
          emit(Unauthorized());
        }
        
          log("CurrentAuthRequested");
          log(state.toString());
          log("user.uid: ${user.uid}");
      }
    );

    on<AuthSignedOut>(
      (event, emit) async {
        await _userRepository.signOut();
        emit(Unauthorized());
        // emit(AuthFailure());
      }
    );
  }
}
