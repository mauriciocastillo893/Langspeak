import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langspeak/config/providers/user_bloc/user_event.dart';
import 'package:langspeak/config/providers/user_bloc/user_state.dart';
import 'package:langspeak/domain/usecase/user_usecase/user_usecase.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUsecase userUsecase;

  UserBloc(this.userUsecase) : super(UserInitialState()) {
    on<SignInLoadingEvent>(_onLoadingSignIn);
    on<SignUpLoadingEvent>(_onLoadingSignUp);
    on<SignInUserEvent>(_onSignIn);
    on<SignUpUserEvent>(_onSignUp);
  }

  Future<void> _onLoadingSignIn(
      SignInLoadingEvent event, Emitter<UserState> emit) async {
    emit(SignInLoadingState());
  }

  Future<void> _onLoadingSignUp(
      SignUpLoadingEvent event, Emitter<UserState> emit) async {
    emit(SignUpLoadingState());
  }

  Future<void> _onSignIn(SignInUserEvent event, Emitter<UserState> emit) async {
    emit(SignInLoadingState());
    final result = await userUsecase.signInUser(
        email: event.email, password: event.password);
    try {
      if (result) {
        emit(const SignInSuccessState(message: "Sign in success :)"));
      } else {
        emit(const SignUpErrorState(message: "Request failure :("));
      }
    } catch (e) {
      emit(SignInErrorState(message: e.toString()));
    }
  }

  Future<void> _onSignUp(SignUpUserEvent event, Emitter<UserState> emit) async {
    emit(SignUpLoadingState());
    final result = await userUsecase.signUpUser(
        email: event.email, username: event.username, password: event.password);
    try {
      if (result) {
        emit(const SignUpSuccessState(message: "Sign up success :)"));
      } else {
        emit(const SignUpErrorState(message: "Request failure :("));
      }
    } catch (e) {
      emit(SignUpErrorState(message: e.toString()));
    }
  }
}
