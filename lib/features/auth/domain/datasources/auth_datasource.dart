import 'package:teslo_shop/features/auth/domain/domain_exports.dart';

abstract class AuthDataSource {
  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String fullName);
  Future<User> chechAuthStatus(String token);
}
