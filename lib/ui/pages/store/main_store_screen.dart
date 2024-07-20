import 'package:flutter/material.dart';
import 'package:langspeak/ui/shared/status/status_main.dart';

class MainStoreScreen extends StatelessWidget {
  const MainStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Main Store Screen'), StatusMain()]),
      ),
    );
  }
}
