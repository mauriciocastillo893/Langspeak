import 'package:flutter/material.dart';
import 'package:langspeak/infrastructure/helpers/shared_preferences/user_shared_preferences.dart';
import 'package:langspeak/ui/shared/button/normal_button.dart';
import 'package:langspeak/ui/shared/status/status_main.dart';
import 'package:langspeak/ui/shared/text/normal_text.dart';
import 'package:langspeak/ui/shared/text_field/normal_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            StatusMain(
              hasChanges: hasChanges,
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
                      await UserSharedPreferences.saveNewCredentials(
                              email: emailController.text,
                              username: usernameController.text,
                              context: context)
                          .then((onValue) {
                        if (onValue) {
                          setState(() {
                            hasChanges = onValue;
                          });
                          emailController.clear();
                          usernameController.clear();
                          _setUserCredentials();
                        }
                      });
                    }),
                NormalButton(
                  buttonText: "SIGN OUT",
                  colorBorderButton: const Color.fromRGBO(28, 156, 184, 1),
                  colorTextButton: const Color.fromRGBO(255, 249, 222, 1),
                  colorBackgroundButton: const Color.fromRGBO(28, 156, 184, 1),
                  onPressed: () => Navigator.pushNamed(context, '/'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
