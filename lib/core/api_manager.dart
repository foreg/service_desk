import 'dart:ffi';

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

  Future<List<Map<String, String>>> building() async {
    return [
      {
        "id": "1",
        "building_title": "Корпус А",
        "adres":
            "Российская Федерация,\r\n190121, г. Санкт-Петербург,\r\nул. Лоцманская, д. 3, литера А"
      },
      {
        "id": "2",
        "building_title": "Корпус Б",
        "adres":
            "Российская Федерация, 190121, г. Санкт-Петербург,<br>ул. Лоцманская, д. 10"
      },
      {
        "id": "3",
        "building_title": "Корпус Г",
        "adres": "Санкт-Петербург, Кронверкский пр, д.5"
      },
      {
        "id": "4",
        "building_title": "Корпус У",
        "adres": "Санкт-Петербург, ул Ленинский пр., д.101"
      },
      {"id": "10", "building_title": "ЦДО", "adres": ""}
    ];
  }
}
