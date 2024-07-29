import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langspeak/config/providers/user_bloc/user_bloc.dart';
import 'package:langspeak/infrastructure/helpers/shared_preferences/user_shared_preferences.dart';
import 'package:langspeak/infrastructure/helpers/validators/email_validator.dart';
import 'package:langspeak/ui/pages/user/graphics.dart';
import 'package:langspeak/ui/shared/alert/normal_alert.dart';
import 'package:langspeak/ui/shared/button/normal_button.dart';
import 'package:langspeak/ui/shared/graphics/create_data.dart';
import 'package:langspeak/ui/shared/status/status_main.dart';
import 'package:langspeak/ui/shared/text/normal_text.dart';
import 'package:langspeak/ui/shared/text_field/normal_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:langspeak/config/providers/user_bloc/user_event.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late SharedPreferences prefs;
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final emailFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();
  // final data = createData();
  String _email = "";
  String _username = "";
  bool hasChanges = false;

  @override
  void initState() {
    _setUserCredentials();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    emailFocusNode.dispose();
    usernameFocusNode.dispose();
    super.dispose();
  }

  void _setUserCredentials() {
    UserSharedPreferences().getUserCredentials().then((userCredentials) {
      setState(() {
        _email = userCredentials['email'] as String;
        _username = userCredentials['username'] as String;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            StatusMain(
              hasChanges: hasChanges,
              bottomHeightSizedBox: 0,
            ),
            Column(
              children: [
                NormalText(
                  text: "My email",
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.only(left: 30, top: 20, bottom: 2.5),
                  textStyle: TextStyle(
                      color: const Color.fromRGBO(255, 249, 222, 1),
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontFamily: 'Inter'),
                ),
                NormalTextField(
                  controller: emailController,
                  focusNode: emailFocusNode,
                  hintText: _email,
                  colorBorder: const Color.fromRGBO(28, 156, 184, 1),
                  textStyle: TextStyle(color: Colors.grey[400]),
                  suffixIcon: const Icon(Icons.email_outlined),
                  onIconPressed: () {},
                ),
                NormalText(
                  text: "My username",
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.only(left: 30, top: 15, bottom: 2.5),
                  textStyle: TextStyle(
                      color: const Color.fromRGBO(255, 249, 222, 1),
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontFamily: 'Inter'),
                ),
                NormalTextField(
                  controller: usernameController,
                  focusNode: usernameFocusNode,
                  hintText: _username,
                  colorBorder: const Color.fromRGBO(28, 156, 184, 1),
                  textStyle: TextStyle(color: Colors.grey[400]),
                  suffixIcon: const Icon(Icons.person_outline),
                  onIconPressed: () {},
                ),
                NormalButton(
                    buttonText: "SAVE CHANGES",
                    colorBorderButton: const Color.fromRGBO(28, 156, 184, 1),
                    colorTextButton: const Color.fromRGBO(255, 249, 222, 1),
                    colorBackgroundButton: const Color.fromRGBO(51, 56, 78, 1),
                    padding: const EdgeInsets.only(
                        top: 30, bottom: 20, left: 30, right: 30),
                    onPressed: () async {
                      if (emailController.text.isNotEmpty ||
                          usernameController.text.isNotEmpty) {
                        if (emailController.text.isNotEmpty) {
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
                          BlocProvider.of<UserBloc>(context).add(
                              UpdateUserCredentialsEvent(
                                  email: emailController.text.trim(),
                                  username: "",
                                  password: "",
                                  profilePicturePath: ""));
                        }
                        if (usernameController.text.isNotEmpty) {
                          BlocProvider.of<UserBloc>(context).add(
                              UpdateUserCredentialsEvent(
                                  email: "",
                                  username: usernameController.text.trim(),
                                  password: "",
                                  profilePicturePath: ""));
                        }
                      } else {
                        showCustomAlert(
                          context: context,
                          title: "Invalid Credentials",
                          message:
                              "Please enter your credentials, make sure fill at least one field.",
                          primaryButtonText: "OK",
                          icon: const Icon(Icons.highlight_remove_rounded,
                              color: Colors.red, size: 40),
                        );
                      }
                    }),
                NormalButton(
                  buttonText: "SIGN OUT",
                  colorBorderButton: const Color.fromRGBO(28, 156, 184, 1),
                  colorTextButton: const Color.fromRGBO(255, 249, 222, 1),
                  colorBackgroundButton: const Color.fromRGBO(28, 156, 184, 1),
                  onPressed: () => Navigator.pushNamed(context, '/'),
                ),
                NormalButton(
                  buttonText: "SHOW GRAPHICS",
                  padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
                  colorBackgroundButton: const Color.fromRGBO(51, 56, 78, 1),
                  colorBorderButton: const Color.fromRGBO(28, 156, 184, 1),
                  // onPressed: () => Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) =>
                  // SimpleTimeSeriesChart(data, animate: true),
                  // )
                  // )
                )
              ],
            ),
            // BlocBuilder<UserBloc, UserState>(builder: (context, state) {
            //   if (state is UpdateUserCredentialsSuccessState) {
            //     print("New credentials");}
            //     _setUserCredentials();
            //     return Container();
            //   } else {
            //     return Container();
            //   }
            // }),
            // } else if (state is SignInLoadingState) {
          ],
        ),
      ),
    );
  }
}
