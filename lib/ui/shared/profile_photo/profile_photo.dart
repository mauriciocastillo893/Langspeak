import 'dart:io';
import 'package:flutter/material.dart';
import 'package:langspeak/infrastructure/helpers/profile_photo/profile_photo_auxiliar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePhoto extends StatefulWidget {
  final double borderWidth;
  final double heightFactor;
  final double widthFactor;
  final double heigthContainer;
  final double widthContainer;
  final bool isEditable;

  const ProfilePhoto({
    super.key,
    this.borderWidth = 2,
    this.heightFactor = 0.6,
    this.widthFactor = 0.6,
    this.heigthContainer = 0.12,
    this.widthContainer = 0.25,
    this.isEditable = true,
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
      height: MediaQuery.of(context).size.height * widget.heigthContainer,
      width: MediaQuery.of(context).size.width * widget.widthContainer,
      decoration: const BoxDecoration(
        // color: Colors.red,
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
