import 'package:flutter/material.dart';
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
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 44.0),
            child: Row(
              children: [
                const Icon(Icons.person, color: Colors.white),
                const SizedBox(width: 8.0),
                Text(
                  _username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 8),
                color: const Color.fromRGBO(21, 106, 142, 1),
                child: const NormalText(
                  text: "LANGSPEAK: ONE CLICK FOR THE FUTURE",
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.0, vertical: 4.0),
                  alignment: Alignment.centerLeft,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(12, 78, 107, 1),
    );
  }
}
