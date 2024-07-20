import 'dart:io';
import 'package:flutter/material.dart';
import 'package:langspeak/infrastructure/helpers/profile_photo/profile_photo_auxiliar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePhoto extends StatefulWidget {
  final double size;
  final double borderWidth;
  final double heightFactor;
  final double widthFactor;
  final bool isEditable;
  final Color borderColor;

  const ProfilePhoto({
    super.key,
    this.size = 80,
    this.borderWidth = 2,
    this.heightFactor = 0.6,
    this.widthFactor = 0.6,
    this.isEditable = true,
    this.borderColor = Colors.white,
  });

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  late String _profileImagePath = "";

  @override
  void initState() {
    super.initState();
  }

  Future<void> _updateProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? newProfileImagePath = prefs.getString('profile_image');
    if (newProfileImagePath != null) {
      setState(() {
        _profileImagePath = newProfileImagePath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width * 0.25,
      decoration: BoxDecoration(
        // color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: FractionallySizedBox(
        heightFactor: widget.heightFactor,
        widthFactor: widget.widthFactor,
        child: Stack(
          children: [
            ClipOval(
              child: AspectRatio(
                aspectRatio: 1,
                child: _profileImagePath.isNotEmpty
                    ? Image.file(
                        File(_profileImagePath),
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/langspeak_2.webp',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            if (widget.isEditable)
              Align(
                alignment: Alignment.bottomRight,
                child: FractionallySizedBox(
                  widthFactor: 0.4,
                  heightFactor: 0.4,
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () async {
                      bool result = await ProfilePhotoAuxiliar.handleEditMethod(
                          context: context);
                      if (result) {
                        _updateProfileImage();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color.fromRGBO(123, 198, 153, 1),
                      ),
                      child: Icon(
                        Icons.edit_rounded,
                        color: const Color.fromRGBO(51, 56, 78, 1),
                        size: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
