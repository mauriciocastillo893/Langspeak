import 'package:flutter/material.dart';
import 'package:langspeak/ui/shared/alert/normal_alert.dart';
import 'package:langspeak/ui/shared/snack_bar/normal_snack_bar.dart';
import 'package:langspeak/ui/shared/text/normal_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clipboard/clipboard.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SharedPreferences? prefs;
  String _username = "User";
  String _profileImagePath = "";
  final String _country = "México";

  @override
  void initState() {
    _loadUsername();
    _loadProfileImage();
    super.initState();
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? "User unknown";
    });
  }

  Future<void> _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _profileImagePath = prefs.getString('profile_image') ?? "";
    });
  }

  Future<void> _saveProfileImage(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', path);
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImagePath = image.path;
      });
      _saveProfileImage(image.path);
      if (!mounted) return;
      Navigator.of(context).pop();
      showSnackBar(
          context: context, message: "Profile photo updated successfully.");
    }
  }

  void _deleteImage() {
    setState(() {
      _profileImagePath = "";
    });
    _saveProfileImage("");
    Navigator.of(context).pop();
    showSnackBar(
        context: context, message: "Profile photo removed successfully.");
  }

  void handleEditMethod() {
    showCustomAlert(
      context: context,
      isSecondButton: _profileImagePath.isNotEmpty ? true : false,
      title: "Profile Photo",
      icon: const Icon(Icons.add_photo_alternate_outlined,
          size: 50, color: Colors.blue),
      message: "Choose an option to change your profile photo, or remove it.",
      primaryButtonText: "Change photo",
      secondaryButtonText: "Remove photo",
      primaryButtonOnTap: _pickImage,
      secondaryButtonOnTap: _deleteImage,
    );
  }

  void _copyToClipboard(String text) {
    FlutterClipboard.copy(text).then((result) {
      showSnackBar(
        context: context,
        message: 'Copied to Clipboard',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const userId = "1234567890ABC";

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(21, 106, 142, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.12,
                    width: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FractionallySizedBox(
                      heightFactor: 0.6,
                      widthFactor: 0.6,
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
                          Align(
                            alignment: Alignment.bottomRight,
                            child: FractionallySizedBox(
                              widthFactor: 0.4,
                              heightFactor: 0.4,
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: handleEditMethod,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color:
                                        const Color.fromRGBO(123, 198, 153, 1),
                                  ),
                                  child: Icon(
                                    Icons.edit_rounded,
                                    color: const Color.fromRGBO(51, 56, 78, 1),
                                    size: MediaQuery.of(context).size.width *
                                        0.04,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.12,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NormalText(
                          text: _username,
                          alignment: Alignment.centerLeft,
                        ),
                        NormalText(
                          text: _country,
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0225,
                          child: Row(
                            children: [
                              NormalText(
                                text: "My User ID: $userId",
                                alignment: Alignment.centerLeft,
                                textStyle: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.025,
                                  color:
                                      const Color.fromARGB(255, 219, 219, 219),
                                ),
                              ),
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.055,
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  Positioned(
                                    top: MediaQuery.of(context).size.width *
                                        -0.0425,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.copy,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        color: Colors.white,
                                      ),
                                      onPressed: () => _copyToClipboard(userId),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const Text('Settings')
        ],
      ),
    );
  }
}
