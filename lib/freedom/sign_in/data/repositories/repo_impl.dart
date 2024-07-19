import 'package:freedom_chat_app/freedom/sign_in/data/data_sources/remote_data_source.dart';
import 'package:freedom_chat_app/freedom/sign_in/domain/repositories/repo.dart';

class SignInRepoImpl extends SignInRepo {
  final SignInRemoteDataSource _signInRemoteDataSource;

  SignInRepoImpl({required SignInRemoteDataSource signInRemoteDataSource})
      : _signInRemoteDataSource = signInRemoteDataSource;

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _signInRemoteDataSource.signInWithEmailAndPassword(email, password);
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<void> signInWithGitHub(context) async {
    try {
      await _signInRemoteDataSource.signInWithGitHub(context);
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      await _signInRemoteDataSource.signInWithGoogle();
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<void> signInWithTwitter() async {
    try {
      await _signInRemoteDataSource.signInWithTwitter();
    } catch (error) {
      throw error;
    }
  }
}
