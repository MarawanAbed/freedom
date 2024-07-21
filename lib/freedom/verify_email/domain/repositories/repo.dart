abstract class VerifyRepository {
  Future<void> sendEmailVerification();
  Future<void> signOut();
  bool isEmailVerified();
  Future<void> reloadUser();
}