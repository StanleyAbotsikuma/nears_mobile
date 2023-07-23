import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../configs/connections.dart';

final Map<String, dynamic> headers = {'Content-Type': 'application/json'};
final FlutterSecureStorage secureStorage = FlutterSecureStorage();

final Dio dio = Dio(BaseOptions(
    baseUrl: AppConnections.protocolType + AppConnections.host,
    headers: headers));

Future<Object> login(loginData) async {
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

Future<Object> fetchData() async {
  final accessToken = await secureStorage.read(key: "accessToken");
  // print(accessToken);

  try {
    Response response = await dio.get(
      'api/staff/',
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      return data;
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
    if (field == null || field.isEmpty) {
      return true;
    }
  }
  return false;
}