import 'package:flutter/material.dart';
import 'package:langspeak/ui/shared/chat/chat_screen/chat_screen.dart';
import 'package:langspeak/ui/shared/status/status_connection.dart';

class MainChatScreen extends StatefulWidget {
  const MainChatScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainChatScreenState();
}

class _MainChatScreenState extends State<MainChatScreen> {
  int _selectedIndex = 0;

  void _changeIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const StatusConnection(),
          ChatScreen(
            index: _selectedIndex,
            function: _changeIndex,
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {},
              backgroundColor: const Color.fromRGBO(105, 201, 242, 1),
              child: const Icon(
                Icons.add,
                // color: Colors.white,
                color: Color.fromRGBO(20, 121, 164, 1),
              ),
            )
          : null,
    );
  }
}
