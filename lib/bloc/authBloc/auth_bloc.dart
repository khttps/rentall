import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:rentall/bloc/authBloc/auth_event.dart';
import 'package:rentall/bloc/authBloc/auth_state.dart';
import 'package:rentall/data/repository/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepository userrepo;

  AuthBloc({required this.userrepo}) : super(AuthInitialState());
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    try {
      if (event is AppStartedEvent) {
        var issiggnedIn = await userrepo.isSignedIn();
        if (issiggnedIn) {
          var user = await userrepo.getCurrentUser();
          yield AuthenticatedState(user: user);
        }
      } else {
        yield UnauthenticatedState();
      }
    } catch (e) {
      yield UnauthenticatedState();
    }
  }
}
