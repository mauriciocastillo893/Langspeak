import 'package:dio/dio.dart';
import 'package:langspeak/domain/models/user_model/repository/user_repository.dart';

class UserApi extends UserRepository {
  final _originUrl = "http://18.235.220.206:8080";
  final Dio _dio = Dio(BaseOptions(
    // baseUrl: "https://yourapi.com",
    connectTimeout: const Duration(milliseconds: 10000), // 10 segundos
    receiveTimeout: const Duration(milliseconds: 10000), // 10 segundos
  ));

  @override
  Future<bool> signInUser(
      {required String email, required String password}) async {
    try {
      final response = await _dio.post(
        "$_originUrl/api/v1/login",
        data: {
          "email": email,
          "password": password,
        },
      );
      print("Procesando info $email $password");
      print("Login: $response");
      if (response.statusCode == 200) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } catch (e) {
      print(e.toString());
      return Future.value(false);
    }
  }

  @override
  Future<bool> signUpUser(
      {required String email,
      required String username,
      required String password}) async {
    try {
      final response = await _dio.post(
        "$_originUrl/api/v1/user",
        data: {
          "email": email,
          "username": username,
          "password": password,
        },
      );
      print("Procesando info $email $username $password");
      print("Register: $response");
      if (response.statusCode == 201) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } catch (e) {
      print(e.toString());
      return Future.value(false);
    }
  }
}
