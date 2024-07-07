import 'package:flutter/material.dart';
import 'package:langspeak/ui/pages/chats/main_chat_screen.dart';
import 'package:langspeak/ui/pages/store/main_store_screen.dart';
import 'package:langspeak/ui/pages/user/main.dart';
import 'package:langspeak/ui/pages/user/settings.dart';
import 'package:langspeak/ui/shared/bottom_navigation_bar/normal_bottom_navigation_bar.dart';

class BaseScreen extends StatefulWidget {
  final int initialIndex;

  const BaseScreen({super.key, required this.initialIndex});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _screens = [
    const Main(),
    const MainChatScreen(),
    const MainStoreScreen(),
    const Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NormalBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
