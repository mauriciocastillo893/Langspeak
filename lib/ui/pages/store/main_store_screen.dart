import 'package:flutter/material.dart';
import 'package:langspeak/ui/shared/app_bar/normal_app_bar.dart';

class MainStoreScreen extends StatelessWidget {
  const MainStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: NormalAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Main Store Screen'),
          ],
        ),
      ),
    );
  }
}
