import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:langspeak/infrastructure/helpers/shared_preferences/user_shared_preferences.dart';
import 'package:langspeak/ui/shared/alert/normal_alert.dart';
import 'package:langspeak/ui/shared/snack_bar/normal_snack_bar.dart';

class ProfilePhotoAuxiliar {
  static Future<bool> _pickImage({required BuildContext context}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await UserSharedPreferences.setNewPrefs(
          variable: 'profile_image', value: image.path);
      if (!context.mounted) return false;
      showSnackBar(
          context: context, message: "Profile photo updated successfully.");
      return true;
    }
    return false;
  }

  static Future<bool> _deleteImage({required BuildContext context}) async {
    await UserSharedPreferences.setNewPrefs(
        variable: 'profile_image', value: "");
    if (!context.mounted) return false;
    showSnackBar(
        context: context, message: "Profile photo removed successfully.");
    return true;
  }

  static Future<bool> handleEditMethod({required BuildContext context}) async {
    UserSharedPreferences userSharedPreferences = UserSharedPreferences();
    String profileImagePath = "";
    profileImagePath =
        await userSharedPreferences.getUserCredentials().then((credentials) {
      return credentials['profile_image'] as String;
    });
    if (!context.mounted) return false;

    final result = await showCustomAlert(
      context: context,
      isSecondButton: profileImagePath.isNotEmpty,
      title: "Profile Photo",
      icon: const Icon(Icons.add_photo_alternate_outlined,
          size: 50, color: Colors.blue),
      message: "Choose an option to change your profile photo, or remove it.",
      primaryButtonText: "Change photo",
      secondaryButtonText: "Remove photo",
      primaryButtonOnTap: () async => await _pickImage(context: context),
      secondaryButtonOnTap: () async => await _deleteImage(context: context),
    );

    print("Final result $result");
    return result ?? false;
  }
}
