import 'package:http/http.dart' as http;

class APIManager {
  static final APIManager _instance = APIManager._();

  factory APIManager() => _instance;

  APIManager._();

  Future<void> init() async {
    // Загрузка пользователя из local
    return;
  }

  Future<Map<String, dynamic>> login({
    required String login,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'userId': '123',
    };
  }
}
