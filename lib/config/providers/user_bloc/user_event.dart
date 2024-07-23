import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UserInitialEvent extends UserEvent {}

// SIGN IN
class SignInUserEvent extends UserEvent {
  final String email;
  final String password;
  const SignInUserEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignInLoadingEvent extends UserEvent {}

class SignInSuccessEvent extends UserEvent {
  final String message;
  const SignInSuccessEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class SignInErrorEvent extends UserEvent {
  final String message;
  const SignInErrorEvent({required this.message});

  @override
  List<Object> get props => [message];
}

// SIGN UP
class SignUpUserEvent extends UserEvent {
  final String email;
  final String username;
  final String password;
  const SignUpUserEvent(
      {required this.email, required this.username, required this.password});

  @override
  List<Object> get props => [email, username, password];
}

class SignUpLoadingEvent extends UserEvent {}

class SignUpSuccessEvent extends UserEvent {
  final String message;
  const SignUpSuccessEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class SignUpErrorEvent extends UserEvent {
  final String message;
  const SignUpErrorEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class UpdateUserCredentialsEvent extends UserEvent {
  final String email;
  final String username;
  final String password;
  final String profilePicturePath;
  const UpdateUserCredentialsEvent(
      {required this.email,
      required this.username,
      required this.password,
      required this.profilePicturePath});

  @override
  List<Object> get props => [email, username, password, profilePicturePath];
}

class UpdateUserCredentialsLoadingEvent extends UserEvent {}

class UpdateUserCredentialsSuccessEvent extends UserEvent {
  final String message;
  const UpdateUserCredentialsSuccessEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class UpdateUserCredentialsErrorEvent extends UserEvent {
  final String message;
  const UpdateUserCredentialsErrorEvent({required this.message});

  @override
  List<Object> get props => [message];
}

// SIGN OUT
class SignOutUserEvent extends UserEvent {}

class SignOutUserLoadingEvent extends UserEvent {}

class SignOutUserSuccessEvent extends UserEvent {
  final String message;
  const SignOutUserSuccessEvent({required this.message});

  @override
  List<Object> get props => [message];
}