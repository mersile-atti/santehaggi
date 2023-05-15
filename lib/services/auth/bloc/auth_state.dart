import 'package:flutter/material.dart' show immutable;

import '../auth_user.dart';

@immutable
abstract class AuthState {
  const AuthState();
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

class AuthStateLoggedOut extends AuthState {
  final Exception? exception;
  const AuthStateLoggedOut(this.exception);
}

class AuthStateLoggedOutFailure extends AuthState {
  final Exception exception;
  const AuthStateLoggedOutFailure(this.exception);
}
