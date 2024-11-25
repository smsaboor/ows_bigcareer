import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}
class AuthResetState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthCodeSentState extends AuthState {}

class AuthCodeVerifiedState extends AuthState {}

class AuthLoggedInState extends AuthState {}

class AuthLoggedOutState extends AuthState {}

class AuthMobileAlreadyExist extends AuthState {}
class AuthMobileNotExist extends AuthState {}
class AuthPasswordNotMatch extends AuthState {}
class AuthPasswordChangedSuccessfully extends AuthState {}
class AuthChangePwdErrorState extends AuthState {}
class AuthErrorState extends AuthState {
  final String error;
  AuthErrorState(this.error);
}