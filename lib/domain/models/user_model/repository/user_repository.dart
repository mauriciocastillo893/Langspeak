abstract class UserRepository{
  Future<bool> signInUser({required String email, required String password});
  Future<bool> signUpUser({required String email, required String username, required String password});
}