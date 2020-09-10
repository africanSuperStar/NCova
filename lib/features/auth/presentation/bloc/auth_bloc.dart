import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../domain/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({@required AuthRepository authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository;

  @override
  AuthState get initialState {
    return super.initialState ?? AuthLoaded(isSignedIn: false);
  }

  @override
  AuthState fromJson(Map<String, dynamic> json) {
    try {
      return AuthLoaded(isSignedIn: json['isSignedIn'] as bool);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, bool> toJson(AuthState state) {
    try {
      return {'isSignedIn': state.isSignedIn};
    } catch (_) {
      return null;
    }
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    switch (event) {
      case AuthEvent.signIn:
        if (_authRepository.signInAnonymously() != null) {
          yield AuthLoaded(isSignedIn: true);
        }
        break;
      case AuthEvent.signOut:
        _authRepository.signOutAnonymously();
        yield AuthLoaded(isSignedIn: false);
        break;
    }
  }
}
