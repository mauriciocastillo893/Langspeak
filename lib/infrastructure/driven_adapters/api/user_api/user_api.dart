import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:langspeak/domain/models/user_model/repository/user_repository.dart';
import 'package:langspeak/infrastructure/helpers/shared_preferences/user_shared_preferences.dart';

class UserApi extends UserRepository {
  final _originUrl = "http://100.29.50.131:8081";
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(milliseconds: 10000),
    receiveTimeout: const Duration(milliseconds: 10000),
  ));

  //   Future<String?> _getToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('token');
  // }

  @override
  Future<Map<String, dynamic>> signInUser(
      {required String email, required String password}) async {
    try {
      final response = await _dio.post(
        "$_originUrl/access/api/v1/log-in",
        data: {
          "email": email,
          "password": password,
        },
        options: Options(
          validateStatus: (status) {
            return status! <
                500; // Permitir manejar todos los códigos de estado menos 500+ en el try
          },
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data['data'];
        if (data != null) {
          await UserSharedPreferences.setNewPrefs(
              variable: 'email', value: email);
          await UserSharedPreferences.setNewPrefs(
              variable: 'username', value: data['username'] ?? '');
          await UserSharedPreferences.setNewPrefs(
              variable: 'token', value: data['token'] ?? '');
          await UserSharedPreferences.setNewPrefs(
              variable: 'uuid', value: data['uuid'] ?? '');
          return Future.value({
            'status': true,
            'message': 'Sign In was successful, starting session.'
          });
        } else {
          return Future.value(
              {'status': false, 'message': 'Invalid response data.'});
        }
      } else if (response.statusCode == 401) {
        return Future.value({
          'status': false,
          'message': 'Unauthorized access, password or email is incorrect'
        });
      } else {
        return Future.value({
          'status': false,
          'message': response.data['message'] ?? 'Unknown error occurred'
        });
      }
    } catch (e) {
      return Future.value({
        'status': false,
        'message': 'Something went wrong. Try again or report this problem.'
      });
    }
  }

  @override
  Future<Map<String, dynamic>> signUpUser(
      {required String email,
      required String username,
      required String password}) async {
    try {
      final response = await _dio.post(
        "$_originUrl/users/api/v1/create",
        data: {
          "email": email,
          "username": username,
          "password": password,
          "confirm_password": password,
          "city": "Earth",
        },
        options: Options(
          validateStatus: (status) {
            return status! <
                500; // Permitir manejar todos los códigos de estado menos 500+ en el try
          },
        ),
      );
      if (response.statusCode == 201) {
        return Future.value({
          'status': true,
          'message': 'Sign Up was successful. Now you can sign in.'
        });
      } else {
        return Future.value({
          'status': false,
          'message': response.data['message'] ?? 'Unknown error occurred'
        });
      }
    } catch (e) {
      return Future.value({
        'status': false,
        'message': 'Something went wrong. Try again or report this problem.'
      });
    }
  }

  @override
  Future<Map<String, dynamic>> updateUserCredentials({
    String username = "",
    String email = "",
    String password = "",
    String city = "",
    String profilePicturePath = "",
  }) async {
    String? token = await UserSharedPreferences.getToken();
    String? uuid = await UserSharedPreferences.getUuid();

    try {
      // Serializar el campo 'request' como JSON
      String requestData = jsonEncode({
        'uuid': uuid,
        'username': username,
        'email': email,
        'password': password,
        'password_confirmation': password,
        'city': city,
        'birth_date': "",
      });

      FormData formData = FormData.fromMap({
        'request': requestData,
        if (profilePicturePath.isNotEmpty)
          'profilePicture': await MultipartFile.fromFile(profilePicturePath),
      });

      print("Enviando: $formData");
      final response = await _dio.put(
        "$_originUrl/users/api/v1",
        data: formData,
        options: Options(
          validateStatus: (status) {
            return status! <
                500; // Permitir manejar todos los códigos de estado menos 500+ en el try
          },
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      if (response.statusCode == 200) {
        return Future.value(
            {'status': true, 'message': 'User update was successful.'});
      } else {
        print("Error ${response.data}");
        return Future.value({
          'status': false,
          'message': response.data['message'] ?? 'Unknown error occurred'
        });
      }
    } catch (e) {
      print(e.toString());
      return Future.value({
        'status': false,
        'message': 'Something went wrong. Try again or report this problem.'
      });
    }
  }

  @override
  Future<Map<String, dynamic>> signOutUser() {
    UserSharedPreferences.clearUserCredentials();
    return Future.value(
        {'status': true, 'message': 'Sign Out was successful. See you soon.'});
  }
}
