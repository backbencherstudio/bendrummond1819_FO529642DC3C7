import '../sources/remote/auth_api_service.dart';

class AuthRepository {
  final AuthApiService remoteSource;

  AuthRepository({required this.remoteSource});

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String dob,
  }) {
    return remoteSource.register(
      name: name,
      email: email,
      password: password,
      phone: phone,
      dob: dob,
    );
  }

  Future<bool> login({required String email, required String password}) async {
    return await remoteSource.login(email: email, password: password);
  }
}
