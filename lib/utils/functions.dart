import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Define the request headers
final Map<String, dynamic> headers = {'Content-Type': 'application/json'};

// Define the request body for the login request
final Map<String, dynamic> loginData = {
  'username': "username",
  'password': "password"
};

final Dio dio =
    Dio(BaseOptions(baseUrl: 'https://example.com/api/', headers: headers));

Future<Map<String, dynamic>> fetchTokens() async {
  try {
    Response response = await dio.post(
      'token/',
      data: json.encode(loginData),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> tokens = response.data;
      return tokens;
    } else {
      throw Exception('Failed to retrieve tokens');
    }
  } catch (e) {
    throw Exception('Failed to retrieve tokens: $e');
  }
}

Future<List<dynamic>> fetchData(String accessToken) async {
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

// Define the main function
void main() async {
  // Retrieve the JWT tokens
  final Map<String, dynamic> tokens = await fetchTokens();

  // Store the tokens in local storage or a cookie
  final String accessToken = tokens['access'];
  final String refreshToken = tokens['refresh'];
  // ...

  // Make an API request with the access token
  final List<dynamic> data = await fetchData(accessToken);
  print(data);

  // Check if the access token is expired and refresh it if necessary
  if (isTokenExpired(accessToken)) {
    // Retrieve a new access token using the refresh token
    final Map<String, dynamic> newTokens = await refreshTokens(refreshToken);
    final String newAccessToken = newTokens['access'];

    // Store the new access token in local storage or a cookie
    // ...

    // Make another API request with the new access token
    final List<dynamic> newData = await fetchData(newAccessToken);
    print(newData);
  }
}
