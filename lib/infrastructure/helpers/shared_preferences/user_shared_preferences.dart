import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clipboard/clipboard.dart';
import 'package:langspeak/ui/shared/alert/normal_alert.dart';
import 'package:langspeak/ui/shared/snack_bar/normal_snack_bar.dart';

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
      'uuid': prefs.getString('uuid') ?? "",
      'email': prefs.getString('email') ?? "",
      'password': prefs.getString('password') ?? "",
      'username': prefs.getString('username') ?? "",
      'token': prefs.getString('token') ?? "",
      'profile_image': prefs.getString('profile_image') ?? "",
    });
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<String?> getUuid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uuid');
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

  static void showSnockBar(
      {required BuildContext context, required String message}) {
    showSnackBar(
      context: context,
      message: message,
    );
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

  // class UserSharedPreferences {
  // static Future<void> setNewPrefs(
  //     {required String variable, required String value}) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String encryptedValue = SecureStorage.encryptData(value);
  //   await prefs.setString(variable, encryptedValue);
  // }

  static Future<void> clearUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<Map> getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'uuid': prefs.getString('uuid') ?? "",
      'email': prefs.getString('email') ?? "",
      'password': prefs.getString('password') ?? "",
      'username': prefs.getString('username') ?? "",
      'token': prefs.getString('token') ?? "",
      'profile_image': prefs.getString('profile_image') ?? "",
    };
  }
}
