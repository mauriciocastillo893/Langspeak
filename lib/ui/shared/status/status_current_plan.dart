import 'package:flutter/material.dart';
import 'package:langspeak/ui/shared/profile_photo/profile_photo.dart';
import 'package:langspeak/ui/shared/status/status_credentials.dart';
import 'package:langspeak/ui/shared/text/normal_text.dart';

class StatusCurrentPlan extends StatefulWidget {
  final bool hasChanges;
  final double topHeightSizedBox;
  final double bottomHeightSizedBox;
  final Alignment containerAlignment;
  final Color containerColor;

  const StatusCurrentPlan({
    super.key,
    this.hasChanges = false,
    this.topHeightSizedBox = 0.03,
    this.bottomHeightSizedBox = 0.03,
    this.containerAlignment = Alignment.center,
    this.containerColor = const Color.fromRGBO(21, 106, 142, 1),
  });

  @override
  State<StatusCurrentPlan> createState() => _StatusCurrentPlanState();
}

class _StatusCurrentPlanState extends State<StatusCurrentPlan> {
  final String _currentPlan = "Free";

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.containerAlignment,
      child: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * widget.topHeightSizedBox,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NormalText(
                    text: "Current Plan",
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  NormalText(
                    text: "${_currentPlan.toUpperCase()} PASS",
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      fontWeight: FontWeight.w900,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.50,
              decoration: BoxDecoration(
                color: widget.containerColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const ProfilePhoto(
                    widthContainer: 0.16,
                    isEditable: false,
                  ),
                  Expanded(
                    child: StatusCredentials(
                      hasChanges: widget.hasChanges,
                      userIdAvailable: false,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height:
              MediaQuery.of(context).size.height * widget.bottomHeightSizedBox,
        ),
      ]),
    );
  }
}
