import 'package:flutter/material.dart';
import 'package:langspeak/ui/shared/status/status_connection.dart';

class MainChatScreen extends StatelessWidget {
  const MainChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          StatusConnection(),
        ],
      ),
    ));
  }
}
