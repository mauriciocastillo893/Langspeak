import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {}

// SIGN IN
class SignInUserState extends UserState {
  final String email;
  final String password;
  const SignInUserState({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignInLoadingState extends UserState {}

class SignInSuccessState extends UserState {
  final String message;
  const SignInSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class SignInErrorState extends UserState {
  final String message;
  const SignInErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

// SIGN UP
class SignUpUserState extends UserState {
  final String email;
  final String username;
  final String password;
  const SignUpUserState(
      {required this.email, required this.username, required this.password});

  @override
  List<Object> get props => [email, username, password];
}

class SignUpLoadingState extends UserState {}

class SignUpSuccessState extends UserState {
  final String message;
  const SignUpSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class SignUpErrorState extends UserState {
  final String message;
  const SignUpErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
