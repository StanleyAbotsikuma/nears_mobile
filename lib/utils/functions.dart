import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../configs/connections.dart';

import 'package:geolocator/geolocator.dart';

import 'broadcase_db.dart';
import 'messages_model.dart';

Future<Position> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are disabled
    return Future.error('Location services are disabled');
  }

  // Request location permission
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      // Location permission is denied
      return Future.error('Location permission is denied');
    }
  }

  // Get the current position
  return await Geolocator.getCurrentPosition();
}

final Map<String, dynamic> headers = {'Content-Type': 'application/json'};
const FlutterSecureStorage secureStorage = FlutterSecureStorage();

final Dio dio = Dio(BaseOptions(
    baseUrl: AppConnections.protocolType + AppConnections.host,
    headers: headers));

//Login
////
///
Future<Map<String, dynamic>> login(loginData) async {
  try {
    Response response = await dio.post(
      'api/login/',
      data: json.encode(loginData),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> tokens = response.data;
      final String accessToken = tokens['access'];
      final String refreshToken = tokens['refresh'];
      await secureStorage.write(key: "accessToken", value: accessToken);
      await secureStorage.write(key: "refreshToken", value: refreshToken);

      final Map<String, dynamic> gResult = {'result': "success"};
      return gResult;
    } else {
      final Map<String, dynamic> gResult = {'result': "error"};
      return gResult;
    }
  } catch (e) {
    final Map<String, dynamic> gResult = {'result': "error"};

    return gResult;
  }
}

//Fetch Data//
////
///
///
Future<Map<String, dynamic>> fetchData() async {
  final accessToken = await secureStorage.read(key: "accessToken");
  // print(accessToken);

  try {
    Response response = await dio.get(
      'api/user_account/',
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> gResult = {
        'result': "success",
        "message": response.data
      };
      return gResult;
    } else {
      final Map<String, dynamic> gResult = {'result': "error"};
      return gResult;
    }
  } catch (e) {
    final Map<String, dynamic> gResult = {'result': "error"};
    return gResult;
  }
}

Future<List<dynamic>> getUserLoad(String accessToken) async {
  try {
    Response response = await dio.get(
      'data/',
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data;
    } else {
      throw Exception('Failed to retrieve data');
    }
  } catch (e) {
    throw Exception('Failed to retrieve data: $e');
  }
}

bool isTokenExpired(String accessToken) {
  final Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
  final int expirationTime = decodedToken['exp'] * 1000;
  final int currentTime = DateTime.now().millisecondsSinceEpoch;
  return expirationTime < currentTime;
}

Future<Map<String, dynamic>> refreshTokens(String refreshToken) async {
  try {
    Response response = await dio.post(
      'token/',
      data: json.encode({'refresh': refreshToken}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> tokens = response.data;
      return tokens;
    } else {
      throw Exception('Failed to refresh tokens');
    }
  } catch (e) {
    throw Exception('Failed to refresh tokens: $e');
  }
}

Future<Map<String, dynamic>> createAccount(
    createAccountData, Map<String, dynamic> createUserData) async {
  try {
    Response response = await dio.post(
      'api/create_account/',
      data: json.encode(createAccountData),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> loginData = {
        'phone_number': createAccountData["phone_number"],
        'password': createAccountData["password"]
      };
      final Future<Map<String, dynamic>> re = login(loginData);
      re.then((valu) {
        // print(valu);
        createUser(createUserData).then((value) {
          // print(value);
        });
      });
      return re;
    } else {
      final Map<String, dynamic> gResult = {'result': "Create Account Error"};
      return gResult;
    }
  } catch (e) {
    final Map<String, dynamic> gResult = {'result': "error"};

    return gResult;
  }
}

Future<Map<String, dynamic>> createUser(createUserData) async {
  final accessToken = await secureStorage.read(key: "accessToken");
  try {
    Response response = await dio.post(
      'api/user_account/',
      data: json.encode(createUserData),
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> gResult = {'result': "success"};

      return gResult;
    } else {
      final Map<String, dynamic> gResult = {'result': "Create Account Error"};
      return gResult;
    }
  } catch (e) {
    final Map<String, dynamic> gResult = {'result': "error"};

    return gResult;
  }
}

Future<Map<String, dynamic>> getAddress(
    {required double lat, required double lon}) async {
  final dioa = Dio();
  try {
    final response =
        await dioa.get("https://geocode.maps.co/reverse?lat=$lat&lon=$lon");

    if (response.statusCode == 200) {
      final Map<String, dynamic> gResult = {
        'result': "success",
        "message": response.data
      };
      return gResult;
    } else {
      final Map<String, dynamic> gResult = {'result': "error"};
      return gResult;
    }
  } catch (e) {
    final Map<String, dynamic> gResult = {'result': "error"};

    return gResult;
  }
}

Future<void> loadMessages(context) async {
  final MessagesDatabaseProvider _messagesDatabaseProvider =
      MessagesDatabaseProvider();
  _messagesDatabaseProvider.initDB();
  _messagesDatabaseProvider.getMessages1().then((value) async {
    int number = value.length;
    final accessToken = await secureStorage.read(key: "accessToken");
    try {
      Response response = await dio.get(
        'api/broadcastmessages/$number/',
        // options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data;
        List<Messages1> myObjects =
            responseData.map((json) => Messages1.fromJson(json)).toList();

        Messages1 i;
        for (i in myObjects) {
          _messagesDatabaseProvider.addMessage(Messages(
              id: i.id.toString(),
              name: i.name,
              message: i.message,
              sender: i.sender,
              level: i.level,
              view: true));
        }
      } else {
        if (kDebugMode) {
          print(response);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  });
}

class Messages1 {
  int id;
  String name;
  String message;
  DateTime date;
  String sender;
  int level;
  bool view;

  Messages1({
    required this.id,
    required this.name,
    required this.message,
    required this.date,
    required this.sender,
    required this.level,
    required this.view,
  });

  factory Messages1.fromJson(Map<String, dynamic> json) {
    return Messages1(
      id: json['id'],
      name: json['name'],
      message: json['message'],
      date: DateTime.parse(json['date']),
      sender: json['sender'],
      level: json['level'],
      view: json['view'],
    );
  }
}
//Alert Alert Alert Alert Alert Alert Alert Alert
////Alert Alert Alert Alert Alert Alert Alert Alert
/////Alert Alert Alert Alert Alert Alert Alert Alert
/////Alert Alert Alert Alert Alert Alert Alert Alert

// final Map<String, dynamic> tokens = await fetchTokens();

// final String accessToken = tokens['access'];
// final String refreshToken = tokens['refresh'];
// // ...

// final List<dynamic> data = await fetchData(accessToken);
// print(data);

// if (isTokenExpired(accessToken)) {
//   final Map<String, dynamic> newTokens = await refreshTokens(refreshToken);
//   final String newAccessToken = newTokens['access'];

//   final List<dynamic> newData = await fetchData(newAccessToken);
//   print(newData);
// }

bool hasEmptyFields(List<String> fields) {
  for (String field in fields) {
    if (field.isEmpty) {
      return true;
    }
  }
  return false;
}
