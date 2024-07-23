abstract class UserRepository {
  Future<Map<String, dynamic>> signInUser(
      {required String email, required String password});
  Future<Map<String, dynamic>> signUpUser(
      {required String email,
      required String username,
      required String password});
  Future<Map<String, dynamic>> updateUserCredentials(
      {required String email,
      required String username,
      required String password,
      required String city,
      required String profilePicturePath});
  Future<Map<String, dynamic>> signOutUser();
}
