import 'package:flutter/material.dart';
import 'package:langspeak/ui/shared/profile_photo/profile_photo.dart';
import 'package:langspeak/ui/shared/status/status_credentials.dart';

class StatusMain extends StatefulWidget {
  final bool hasChanges;
  final bool userIdAvailable;
  final double containerHeight;
  final double containerWidth;
  final double topHeightSizedBox;
  final double bottomHeightSizedBox;
  final Color containerColor;
  final Alignment containerAlignment;
  // ProfilePhoto
  final bool profilePhotoIsEditable;

  const StatusMain({
    super.key,
    this.hasChanges = false,
    this.userIdAvailable = true,
    this.containerHeight = 0.12,
    this.containerWidth = 0.85,
    this.topHeightSizedBox = 0.03,
    this.bottomHeightSizedBox = 0.03,
    this.containerColor = const Color.fromRGBO(21, 106, 142, 1),
    this.containerAlignment = Alignment.center,
    this.profilePhotoIsEditable = true,
  });

  @override
  State<StatusMain> createState() => _StatusMainState();
}

class _StatusMainState extends State<StatusMain> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.containerAlignment,
      child: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * widget.topHeightSizedBox,
        ),
        Container(
          height: MediaQuery.of(context).size.height * widget.containerHeight,
          width: MediaQuery.of(context).size.width * widget.containerWidth,
          decoration: BoxDecoration(
            color: widget.containerColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              ProfilePhoto(
                isEditable: widget.profilePhotoIsEditable,
              ),
              Expanded(
                child: StatusCredentials(
                  hasChanges: widget.hasChanges,
                  userIdAvailable: widget.userIdAvailable,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height:
              MediaQuery.of(context).size.height * widget.bottomHeightSizedBox,
        ),
      ]),
    );
  }
}
