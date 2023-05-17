import 'package:flutter/material.dart' show immutable;
import 'package:equatable/equatable.dart';

import '../auth_user.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized();
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering(this.exception);
}

// Loading state
class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

// Login state. The UI only needs to know if the user is logged in or not.
class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn(this.user);
}

//Verify email state

class AuthStateNeedVerification extends AuthState {
  const AuthStateNeedVerification();
}

//log out. No nedd to verify email

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  final bool isLoading;
  const AuthStateLoggedOut({
    required this.exception,
    required this.isLoading,
  });

  @override
  List<Object?> get props => [exception, isLoading];
}
