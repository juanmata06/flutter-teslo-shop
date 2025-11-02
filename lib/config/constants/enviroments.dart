import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static Future<void> initEnvironment() async {
    await dotenv.load(fileName: ".env");
  }

  static final String apiUrl = dotenv.env['API_URL'] ?? 'No API_URL configured.';

  static final Map<String, dynamic> endpoints = {
    'auth': {
      'login': '/auth/login',
      'register': '/auth/register',
      'check-status': '/auth/check-status',
    },
  };
}
