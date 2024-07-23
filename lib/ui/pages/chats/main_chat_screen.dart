import 'package:flutter/material.dart';
import 'package:langspeak/ui/shared/chat/chat_screen/chat_screen.dart';
import 'package:langspeak/ui/shared/status/status_connection.dart';

class MainChatScreen extends StatelessWidget {
  const MainChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Column(
        children: [
          StatusConnection(),
          ChatScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromRGBO(105, 201, 242, 1),
        child: const Icon(
          Icons.add,
          // color: Colors.white,
          color: Color.fromRGBO(20, 121, 164, 1),
        ),
      ),
    );
  }
}
