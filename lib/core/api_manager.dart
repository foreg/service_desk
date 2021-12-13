import 'dart:ffi';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
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
        "adres": "ул. Лоцманская, д. 3, литера А"
      },
      {
        "id": "2",
        "building_title": "Корпус Б",
        "adres": "ул. Лоцманская, д. 10"
      },
      {
        "id": "3",
        "building_title": "Корпус Г",
        "adres": "Кронверкский пр, д.5"
      },
      {
        "id": "4",
        "building_title": "Корпус У",
        "adres": "ул Ленинский пр., д.101"
      }
    ];
  }

  Future<List<Map<String, String>>> rooms() async {
    return [
      {"id": "1", "room_title": "313", "seats": "50", "square": "0"},
      {"id": "2", "room_title": "319", "seats": "24", "square": "0"},
      {"id": "3", "room_title": "320", "seats": "10", "square": "55.2"},
      {"id": "4", "room_title": "326", "seats": "20", "square": "44.5"},
      {"id": "5", "room_title": "340", "seats": "40", "square": "49.3"},
      {"id": "6", "room_title": "338", "seats": "24", "square": "38.2"},
      {"id": "7", "room_title": "339", "seats": "30", "square": "29.8"},
      {"id": "8", "room_title": "318", "seats": "20", "square": "44"},
      {"id": "9", "room_title": "308", "seats": "20", "square": "0"},
      {"id": "10", "room_title": "404", "seats": "16", "square": "17.8"},
      {"id": "11", "room_title": "337", "seats": "к.кл", "square": "36.3"},
      {"id": "12", "room_title": "442", "seats": "к.кл", "square": "28.9"},
      {"id": "13", "room_title": "407", "seats": "100", "square": "114.6"},
      {"id": "14", "room_title": "450", "seats": "50", "square": "69.5"},
      {"id": "15", "room_title": "458", "seats": "50", "square": "0"},
      {"id": "16", "room_title": "456", "seats": "30", "square": "0"},
      {"id": "17", "room_title": "453", "seats": "50", "square": "51.2"},
      {"id": "19", "room_title": "413", "seats": "22", "square": "40"},
      {"id": "20", "room_title": "414", "seats": "18", "square": "39.9"},
      {"id": "22", "room_title": "503", "seats": "50", "square": "76.4"},
      {"id": "23", "room_title": "522а", "seats": "к.кл", "square": ""},
      {"id": "24", "room_title": "536", "seats": "30", "square": "76.6"},
      {"id": "25", "room_title": "537", "seats": "30", "square": "34.1"},
      {"id": "26", "room_title": "537а", "seats": "к.кл.", "square": "0"},
      {"id": "154", "room_title": "каф.ВК", "seats": "0", "square": ""},
      {"id": "155", "room_title": "каф.ФВ", "seats": "0", "square": ""},
      {"id": "1144", "room_title": "Актовый зал", "seats": "500", "square": ""},
      {"id": "1177", "room_title": "417", "seats": "20", "square": "0"},
      {"id": "1227", "room_title": "Акаф", "seats": "0", "square": ""},
      {"id": "1511", "room_title": "435", "seats": "30", "square": "55.1"},
      {"id": "1536", "room_title": "517", "seats": "20", "square": "49.6"},
      {"id": "1559", "room_title": "215", "seats": "20", "square": "20"}
    ];
  }

  Future<void> createRequest(String buildId, String roomId, String title,
      String about, List<XFile> files) async {
    return;
  }
}
