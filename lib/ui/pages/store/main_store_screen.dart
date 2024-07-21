import 'package:flutter/material.dart';
import 'package:langspeak/ui/shared/status/status_current_plan.dart';
import 'package:langspeak/ui/shared/store_card/premium_card.dart';

class MainStoreScreen extends StatelessWidget {
  const MainStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          StatusCurrentPlan(
            bottomHeightSizedBox: 0,
          ),
          PremiumCard()
        ]),
      ),
    );
  }
}
