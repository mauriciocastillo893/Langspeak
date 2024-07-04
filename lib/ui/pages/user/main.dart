import 'package:flutter/material.dart';
import 'package:langspeak/ui/shared/app_bar/normal_app_bar.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar(),
      body: const Center(
        child: Text("Hi"),
      ),
    );
  }
}
