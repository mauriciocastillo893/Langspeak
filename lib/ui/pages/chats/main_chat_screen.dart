import 'package:flutter/material.dart';
import 'package:langspeak/ui/shared/app_bar/normal_app_bar.dart';

class MainChatScreen extends StatelessWidget {
  const MainChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: NormalAppBar(),
      body: Center(
        child: Text('Main Chat Screen'),
      ),
    );
  }
}
