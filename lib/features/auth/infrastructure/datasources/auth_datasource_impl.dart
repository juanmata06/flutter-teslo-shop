import 'package:dio/dio.dart';

import 'package:teslo_shop/config/config.export.dart';
import 'package:teslo_shop/features/auth/domain/domain_exports.dart';
import 'package:teslo_shop/features/auth/infrastructure/infraestructure_exports.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl
    )
  );

  @override
  Future<User> chechAuthStatus(String token) {
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post(Environment.endpoints['auth']['login'], data: {
        'email': email,
        'password': password
      });
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if(e.response?.statusCode == 401) {
        throw CustomError(e.response?.data['message'] ?? 'Credentials are not correct');
      }
      if(e.type == DioExceptionType.connectionTimeout) {
        throw CustomError(e.response?.data['message'] ?? 'Bad internet connection');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) async {
    try {
      final response = await dio.post(Environment.endpoints['auth']['register'], data: {
        'email': email,
        'password': password,
        'fullName': fullName,
      });
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if(e.response?.statusCode == 400) {
        final message = e.response?.data['message'];
        if (message is List) {
          throw CustomError(message.join('\n'));
        }
        throw CustomError(message ?? 'Credentials are not correct');
      }
      if(e.type == DioExceptionType.connectionTimeout) {
        throw CustomError(e.response?.data['message'] ?? 'Bad internet connection');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
