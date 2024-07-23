import 'package:langspeak/domain/models/user_model/repository/user_repository.dart';

class UserUsecase {
  // It is made private because it is only used in this class and we can implement the methods when this class is called.
  final UserRepository _userRepository;
  UserUsecase(this._userRepository);

  Future<Map<String, dynamic>> signInUser(
      {required String email, required String password}) async {
    return await _userRepository.signInUser(email: email, password: password);
  }

  Future<Map<String, dynamic>> signUpUser(
      {required String email,
      required String username,
      required String password}) async {
    return await _userRepository.signUpUser(
        email: email, username: username, password: password);
  }

  Future<Map<String, dynamic>> updateUserCredentials(
      {required String email,
      required String username,
      required String password,
      required String city,
      required String profilePicturePath}) async {
    return await _userRepository.updateUserCredentials(
        email: email,
        username: username,
        password: password,
        profilePicturePath: profilePicturePath,
        city: city);
  }

  Future<Map<String, dynamic>> signOutUser() async {
    return await _userRepository.signOutUser();
  }
}
