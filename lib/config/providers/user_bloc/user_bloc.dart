import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langspeak/config/providers/user_bloc/user_event.dart';
import 'package:langspeak/config/providers/user_bloc/user_state.dart';
import 'package:langspeak/domain/usecase/user_usecase/user_usecase.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUsecase userUsecase;

  UserBloc(this.userUsecase) : super(UserInitialState()) {
    on<UserInitialEvent>(_onUserInitial);
    on<SignInLoadingEvent>(_onLoadingSignIn);
    on<SignUpLoadingEvent>(_onLoadingSignUp);
    on<SignInUserEvent>(_onSignIn);
    on<SignUpUserEvent>(_onSignUp);
    on<UpdateUserCredentialsEvent>(_onUserUpdateCredentials);
    // on<UserSignOutEvent>();
  }

  Future<void> _onUserInitial(
      UserInitialEvent event, Emitter<UserState> emit) async {
    emit(UserInitialState());
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
      print(result);
      if (result['status']) {
        emit(SignInSuccessState(message: result['message']));
      } else {
        emit(SignInErrorState(message: result['message']));
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
      if (result['status']) {
        emit(SignUpSuccessState(message: result['message']));
      } else {
        emit(SignUpErrorState(message: result['message']));
      }
    } catch (e) {
      emit(SignUpErrorState(message: e.toString()));
    }
  }

  Future<void> _onUserUpdateCredentials(
      UpdateUserCredentialsEvent event, Emitter<UserState> emit) async {
    final result = await userUsecase.updateUserCredentials(
        email: event.email,
        username: event.username,
        password: event.password,
        profilePicturePath: "",
        city: "Earth");
    try {
      print("Result form update user credentials: $result");
      if (result['status']) {
        emit(UpdateUserCredentialsSuccessState(message: result['message']));
      } else {
        emit(UpdateUserCredentialsErrorState(message: result['message']));
      }
      Future.delayed(Duration(seconds: 4));
      emit(UserInitialState());
    } catch (e) {
      emit(UpdateUserCredentialsErrorState(message: e.toString()));
    }
  }
}
