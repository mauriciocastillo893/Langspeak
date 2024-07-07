import 'package:flutter/material.dart';
import 'package:langspeak/ui/shared/app_bar/normal_app_bar.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: NormalAppBar(),
      body: Center(
        child: Text('Settings'),
      ),
      // bottomNavigationBar: NormalBottomNavigationBar(),
    );
  }
}
