import 'package:langspeak/domain/models/user_model/repository/user_repository.dart';

class UserUsecase {
  // It is made private because it is only used in this class and we can implement the methods when this class is called.
  final UserRepository _userRepository;
  UserUsecase(this._userRepository);

  Future<bool> signInUser({required String email, required String password}) async {
    return await _userRepository.signInUser(email: email, password: password);
  }

  Future<bool> signUpUser({
      required String email, required String username, required String password}) async {
    return await _userRepository.signUpUser(email: email, username: username, password: password);
  }
}
