abstract class VerifyRepository {
  Future<void> sendVerificationEmail();

  Future<bool> isEmailVerified();

  bool userVerified();
}