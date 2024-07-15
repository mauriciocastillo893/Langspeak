import 'package:flutter/material.dart';
import 'package:langspeak/ui/shared/alert/normal_alert.dart';
import 'package:langspeak/ui/shared/button/normal_button.dart';
import 'package:langspeak/ui/shared/snack_bar/normal_snack_bar.dart';
import 'package:langspeak/ui/shared/text/normal_text.dart';
import 'package:langspeak/ui/shared/text_field/normal_text_field.dart';
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
  late SharedPreferences prefs;
  String _username = "-";
  String _email = "-";
  String _profileImagePath = "";
  final String _country = "México";
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final emailFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

  Future<void> _initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
    _loadUsername();
    _loadProfileImage();
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    emailFocusNode.dispose();
    usernameFocusNode.dispose();
    super.dispose();
  }

  void _loadUsername() {
    setState(() {
      _username = prefs.getString('username') ?? "-";
      _email = prefs.getString('email') ?? "-";
    });
    print('Username: $_username, Email: $_email');
  }

  void _loadProfileImage() {
    setState(() {
      _profileImagePath = prefs.getString('profile_image') ?? "";
    });
  }

  Future<void> _saveProfileImage(String path) async {
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

  void _saveChanges() async {
    late String message = "";
    late bool hasChanges = false;
    if (emailController.text.isEmpty && usernameController.text.isEmpty) {
      showCustomAlert(
          context: context,
          title: "Empty field",
          message: "Please fill in the fields to save changes.");
      return;
    }
    if (emailController.text.isNotEmpty) {
      message += "Email";
      await _setNewPrefs(data: emailController.text, variable: 'email');
      hasChanges = !hasChanges;
    }
    if (usernameController.text.isNotEmpty) {
      if (hasChanges) {
        message += ", ";
      }
      message += "Username";
      await _setNewPrefs(data: usernameController.text, variable: 'username');
    }
    _loadUsername();
    emailController.clear();
    usernameController.clear();
    if (!mounted) return;
    showSnackBar(
      context: context,
      message: message += " updated successfully.",
    );
    return;
  }

  Future<void> _setNewPrefs(
      {required String data, required String variable}) async {
    await prefs.setString(variable, data);
  }

  @override
  Widget build(BuildContext context) {
    const userId = "1234567890ABC";

    return Scaffold(
      body: SingleChildScrollView(
        // Envolver en SingleChildScrollView
        child: Column(
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
                                      color: const Color.fromRGBO(
                                          123, 198, 153, 1),
                                    ),
                                    child: Icon(
                                      Icons.edit_rounded,
                                      color:
                                          const Color.fromRGBO(51, 56, 78, 1),
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
                                        MediaQuery.of(context).size.width *
                                            0.025,
                                    color: const Color.fromARGB(
                                        255, 219, 219, 219),
                                  ),
                                ),
                                Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.055,
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
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
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04,
                                          color: Colors.white,
                                        ),
                                        onPressed: () =>
                                            _copyToClipboard(userId),
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
            Column(
              children: [
                NormalText(
                  text: "My email",
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.only(left: 30, top: 20, bottom: 2.5),
                  textStyle: TextStyle(
                      color: const Color.fromRGBO(255, 249, 222, 1),
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontFamily: 'Inter'),
                ),
                NormalTextField(
                  controller: emailController,
                  focusNode: emailFocusNode,
                  hintText: _email,
                  colorBorder: const Color.fromRGBO(28, 156, 184, 1),
                  textStyle: TextStyle(color: Colors.grey[400]),
                  suffixIcon: const Icon(Icons.email_outlined),
                  onIconPressed: () {},
                ),
                NormalText(
                  text: "My username",
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.only(left: 30, top: 15, bottom: 2.5),
                  textStyle: TextStyle(
                      color: const Color.fromRGBO(255, 249, 222, 1),
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontFamily: 'Inter'),
                ),
                NormalTextField(
                  controller: usernameController,
                  focusNode: usernameFocusNode,
                  hintText: _username,
                  colorBorder: const Color.fromRGBO(28, 156, 184, 1),
                  textStyle: TextStyle(color: Colors.grey[400]),
                  suffixIcon: const Icon(Icons.person_outline),
                  onIconPressed: () {},
                ),
                NormalButton(
                    buttonText: "SAVE CHANGES",
                    colorBorderButton: const Color.fromRGBO(28, 156, 184, 1),
                    colorTextButton: const Color.fromRGBO(255, 249, 222, 1),
                    colorBackgroundButton: const Color.fromRGBO(51, 56, 78, 1),
                    padding: const EdgeInsets.only(
                        top: 30, bottom: 20, left: 30, right: 30),
                    onPressed: _saveChanges),
                NormalButton(
                  buttonText: "SIGN OUT",
                  colorBorderButton: const Color.fromRGBO(28, 156, 184, 1),
                  colorTextButton: const Color.fromRGBO(255, 249, 222, 1),
                  colorBackgroundButton: const Color.fromRGBO(28, 156, 184, 1),
                  onPressed: () => Navigator.pushNamed(context, '/'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
