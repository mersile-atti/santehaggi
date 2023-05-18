import 'package:flutter/material.dart' show immutable;
import 'package:equatable/equatable.dart';

import '../auth_user.dart';

@immutable
abstract class AuthState {
  final bool isLoading;
  final String? loadingText;
  const AuthState({
    required this.isLoading,
    this.loadingText = "Please wait a moment...",
  });
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering({
    required this.exception,
    required isLoading,
  }) : super(isLoading: isLoading);
}

class AuthStateForgotPassword extends AuthState {
  final Exception? exception;
  final bool hasSentEmail;
  const AuthStateForgotPassword({
    required this.hasSentEmail,
    required this.exception,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

// Loading state
class AuthStateLoading extends AuthState {
  const AuthStateLoading({
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

// Login state. The UI only needs to know if the user is logged in or not.
class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn({required this.user, required bool isLoading})
      : super(isLoading: isLoading);
}

//Verify email state

class AuthStateNeedVerification extends AuthState {
  const AuthStateNeedVerification({
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

//log out. No nedd to verify email

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  const AuthStateLoggedOut({
    required this.exception,
    required bool isLoading,
    String? loadingText,
  }) : super(isLoading: isLoading, loadingText: loadingText);

  @override
  List<Object?> get props => [exception, isLoading];
}
