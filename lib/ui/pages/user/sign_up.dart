import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langspeak/config/providers/user_bloc/user_bloc.dart';
import 'package:langspeak/config/providers/user_bloc/user_state.dart';
import 'package:langspeak/infrastructure/helpers/validators/email_validator.dart';
import 'package:langspeak/ui/shared/alert/normal_alert.dart';
import 'package:langspeak/ui/shared/button/normal_button.dart';
import 'package:langspeak/ui/shared/text/normal_text.dart';
import 'package:langspeak/ui/shared/text_field/normal_text_field.dart';
import 'package:langspeak/config/providers/user_bloc/user_event.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();
  final focusNodeEmail = FocusNode();
  final focusNodePassword = FocusNode();
  final focusNodeConfirmPassword = FocusNode();
  final focusNodeUsername = FocusNode();

  @override
  void initState() {
    final userBloc = context.read<UserBloc>();
    userBloc.add(UserInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    focusNodeUsername.dispose();
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    focusNodeConfirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = context.watch<UserBloc>();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NormalText(
                text: "SIGN UP",
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  color: const Color.fromRGBO(255, 249, 222, 1),
                  fontSize: MediaQuery.of(context).size.width * 0.08,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w900,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child:
                    BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                  if (state is UserInitialState) {
                    return NormalText(
                      text: "Welcome, please enter your credentials to sign up",
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                        color: const Color.fromRGBO(255, 249, 222, 1),
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w900,
                      ),
                    );
                  } else if (state is SignUpLoadingState) {
                    return NormalText(
                      text: "Loading...",
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                        color: const Color.fromRGBO(255, 249, 222, 1),
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w900,
                      ),
                    );
                  } else if (state is SignUpSuccessState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      final userBloc = context.read<UserBloc>();
                      userBloc.add(UserInitialEvent());
                      usernameController.clear();
                      emailController.clear();
                      passwordController.clear();
                      Navigator.pushNamed(context, '/');
                    });
                    return NormalText(
                      text: state.message,
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                        color: const Color.fromRGBO(255, 249, 222, 1),
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w900,
                      ),
                    );
                  } else if (state is SignUpErrorState) {
                    return NormalText(
                      text: state.message,
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                        color: const Color.fromRGBO(255, 249, 222, 1),
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w900,
                      ),
                    );
                  } else {
                    return NormalText(
                      text: "Error found not contained $state",
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                        color: const Color.fromRGBO(255, 249, 222, 1),
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w900,
                      ),
                    );
                  }
                }),
              ),
              NormalText(
                text: "Username",
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 30, top: 20, bottom: 2.5),
                textStyle: TextStyle(
                    color: const Color.fromRGBO(255, 249, 222, 1),
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontFamily: 'Inter'),
              ),
              NormalTextField(
                controller: usernameController,
                focusNode: focusNodeUsername,
                hintText: "",
                nextFocusNode: focusNodeEmail,
                textStyle: TextStyle(
                    color: const Color.fromRGBO(255, 249, 222, 1),
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontFamily: 'Inter'),
                suffixIcon: const Icon(
                  Icons.person,
                ),
                onIconPressed: () {},
              ),
              NormalText(
                text: "Email",
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 30, top: 20, bottom: 2.5),
                textStyle: TextStyle(
                    color: const Color.fromRGBO(255, 249, 222, 1),
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontFamily: 'Inter'),
              ),
              NormalTextField(
                controller: emailController,
                focusNode: focusNodeEmail,
                hintText: "",
                nextFocusNode: focusNodePassword,
                textStyle: TextStyle(
                    color: const Color.fromRGBO(255, 249, 222, 1),
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontFamily: 'Inter'),
                suffixIcon: const Icon(
                  Icons.email,
                ),
                onIconPressed: () {},
              ),
              NormalText(
                text: "Password",
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 30, top: 20, bottom: 2.5),
                textStyle: TextStyle(
                    color: const Color.fromRGBO(255, 249, 222, 1),
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontFamily: 'Inter'),
              ),
              NormalTextField(
                controller: passwordController,
                focusNode: focusNodePassword,
                nextFocusNode: focusNodeConfirmPassword,
                hintText: "",
                textStyle: TextStyle(
                    color: const Color.fromRGBO(255, 249, 222, 1),
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontFamily: 'Inter'),
                suffixIcon: const Icon(Icons.remove_red_eye_rounded),
                obscureText: true,
              ),
              NormalText(
                text: "Confirm Password",
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 30, top: 20, bottom: 2.5),
                textStyle: TextStyle(
                    color: const Color.fromRGBO(255, 249, 222, 1),
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontFamily: 'Inter'),
              ),
              NormalTextField(
                controller: confirmPasswordController,
                focusNode: focusNodeConfirmPassword,
                hintText: "",
                textStyle: TextStyle(
                    color: const Color.fromRGBO(255, 249, 222, 1),
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontFamily: 'Inter'),
                suffixIcon: const Icon(Icons.remove_red_eye_rounded),
                obscureText: true,
              ),
              NormalButton(
                buttonText: "Sign Up",
                padding: const EdgeInsets.only(left: 30, right: 30, top: 35),
                onPressed: () async {
                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty &&
                      confirmPasswordController.text.isNotEmpty &&
                      usernameController.text.isNotEmpty) {
                    final result = await EmailValidator.validateEmail(
                        emailController.text.trim());
                    if (!context.mounted) return;
                    if (!result['status']) {
                      showCustomAlert(
                        context: context,
                        title: "Invalid Email",
                        message: result['message'],
                        primaryButtonText: "OK",
                        icon: const Icon(Icons.highlight_remove_rounded,
                            color: Colors.red, size: 40),
                      );
                      return;
                    }
                    if (passwordController.text.trim().length < 8) {
                      showCustomAlert(
                        context: context,
                        title: "Invalid Password",
                        message:
                            "Password must be greater than or equal to 8 characters",
                        primaryButtonText: "OK",
                        icon: const Icon(Icons.highlight_remove_rounded,
                            color: Colors.red, size: 40),
                      );
                      return;
                    }
                    if (passwordController.text.trim() !=
                        confirmPasswordController.text.trim()) {
                      showCustomAlert(
                        context: context,
                        title: "Password Mismatch",
                        message: "Passwords do not match, make sure they match",
                        primaryButtonText: "OK",
                        icon: const Icon(Icons.highlight_remove_rounded,
                            color: Colors.red, size: 40),
                      );
                      return;
                    }
                    userBloc.add(SignUpUserEvent(
                        username: usernameController.text.trim(),
                        email: emailController.text.trim(),
                        password: passwordController.text.trim()));
                    // if (!context.mounted) return;
                    // Navigator.pushNamed(context, "/menu");
                  } else {
                    showCustomAlert(
                      context: context,
                      title: "Invalid Credentials",
                      message:
                          "Please enter your credentials, make sure not to leave any field empty.",
                      primaryButtonText: "OK",
                      icon: const Icon(Icons.highlight_remove_rounded,
                          color: Colors.red, size: 40),
                    );
                  }
                },
              ),
              NormalText(
                text: "Do you have an account? Go to Sign In",
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 20, bottom: 0),
                textStyle: TextStyle(
                    color: const Color.fromRGBO(255, 249, 222, 1),
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontFamily: 'Inter'),
              ),
              NormalButton(
                buttonText: 'Sign In',
                colorBackgroundButton: const Color.fromRGBO(51, 56, 78, 1),
                padding: const EdgeInsets.only(left: 30, right: 30, top: 5),
                onPressed: () {
                  Navigator.pushNamed(context, "/");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
