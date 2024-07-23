import 'dart:io';

class EmailValidator {
  static bool isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(email);
  }

  static Future<bool> domainExists(String email) async {
    final domain = email.split('@').last;
    try {
      final result = await InternetAddress.lookup(domain, type: InternetAddressType.any);
      return result.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static Future<Map<String, dynamic>> validateEmail(String email) async {
    bool isValid = isValidEmail(email);
    if (!isValid) {
      return {'status': false, 'message': 'Invalid email format'};
    }

    bool domainExistsResult = await domainExists(email);
    if (!domainExistsResult) {
      return {'status': false, 'message': 'Email domain does not exist'};
    }

    return {'status': true, 'message': 'Email is valid'};
  }
}