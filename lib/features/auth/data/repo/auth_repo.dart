import '../rds/auth_rds.dart';

class AuthRepo {
  final AuthRds remoteSource;
  AuthRepo({required this.remoteSource});
  Future<bool> register() async {
    return await remoteSource.register();
  }

  Future<bool> login({required String email, required String password}) async {
    return await remoteSource.login(email: email, password: password);
  }
}
