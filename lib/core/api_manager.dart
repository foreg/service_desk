import 'package:http/http.dart' as http;

class APIManager {
  static final APIManager _instance = APIManager._();

  factory APIManager() => _instance;

  APIManager._();

  Future<void> init() async {
    // Загрузка пользователя из local
    return;
  }
}
