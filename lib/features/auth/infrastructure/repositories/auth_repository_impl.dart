import 'package:teslo_shop/features/auth/domain/domain_exports.dart';
import 'package:teslo_shop/features/auth/infrastructure/infraestructure_exports.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({
    AuthDataSource? dataSource
  }) : dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<User> chechAuthStatus(String token) {
    return dataSource.chechAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return dataSource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    return dataSource.register(email, password, fullName);
  }
}
