import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langspeak/config/providers/user_bloc/user_bloc.dart';
import 'package:langspeak/config/providers/user_bloc/user_state.dart';
import 'package:langspeak/ui/shared/text/normal_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NormalAppBar extends StatefulWidget implements PreferredSizeWidget {
  const NormalAppBar({super.key});

  @override
  State<NormalAppBar> createState() => _NormalAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(74.0);
}

class _NormalAppBarState extends State<NormalAppBar> {
  String _username = "User";

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? "User";
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UpdateUserCredentialsSuccessState) {
            _loadUsername();
          }
        },
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 44.0),
                child: Row(
                  children: [
                    const Expanded(
                        flex: 1,
                        child: Align(
                            alignment: Alignment.center,
                            child: Icon(Icons.person, color: Colors.white))),
                    Expanded(
                      flex: 7,
                      child: NormalText(
                        text: _username,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 8),
                    color: const Color.fromRGBO(21, 106, 142, 1),
                    child: NormalText(
                      text: "LANGSPEAK: ONE CLICK FOR THE FUTURE",
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.075,
                          vertical: MediaQuery.of(context).size.width * 0.01),
                      alignment: Alignment.centerLeft,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
            ],
          ),
          backgroundColor: const Color.fromRGBO(12, 78, 107, 1),
        ));
  }
}
