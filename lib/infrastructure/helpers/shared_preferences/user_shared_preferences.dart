import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:langspeak/ui/shared/alert/normal_alert.dart';
import 'package:langspeak/ui/shared/snack_bar/normal_snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences {
  String email;
  String password;
  String username;
  String profileImage;

  UserSharedPreferences(
      {this.email = "",
      this.password = "",
      this.username = "",
      this.profileImage = ""});

  factory UserSharedPreferences.fromJson(Map<String, dynamic> json) {
    return UserSharedPreferences(
      email: json['email'] ?? "",
      password: json['password'] ?? "",
      username: json['username'] ?? "",
      profileImage: json['profile_image'] ?? "",
    );
  }

  Future<Map<String, String>> getUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Map<String, String>.from({
      'email': prefs.getString('email') ?? "",
      'password': prefs.getString('password') ?? "",
      'username': prefs.getString('username') ?? "",
      'profile_image': prefs.getString('profile_image') ?? "",
    });
  }

  static void copyToClipboard(
      {required BuildContext context,
      required String textToClipboard,
      String? message}) {
    FlutterClipboard.copy(textToClipboard).then((result) {
      showSnackBar(
        context: context,
        message: message ?? "Copied to Clipboard",
      );
    });
  }

  static Future<bool> saveNewCredentials(
      {String email = "",
      String username = "",
      required BuildContext context}) async {
    late String message = "";
    late bool hasChanges = false;
    if (email.isEmpty && username.isEmpty) {
      showCustomAlert(
          context: context,
          title: "Empty field",
          message: "Please fill in the fields to save changes.");
      return false;
    }
    if (email.isNotEmpty) {
      message += "Email";
      await setNewPrefs(variable: 'email', value: email);
      hasChanges = !hasChanges;
    }
    if (username.isNotEmpty) {
      if (hasChanges) {
        message += ", ";
      }
      message += "Username";
      await setNewPrefs(variable: 'username', value: username);
    }
    if (!context.mounted) return false;
    showSnackBar(
      context: context,
      message: message += " updated successfully.",
    );
    return true;
  }

  static Future<void> setNewPrefs(
      {required String variable, required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(variable, value);
  }

  static Future<void> clearUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}