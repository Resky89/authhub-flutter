import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthController {
  static const String baseUrl = "https://3dc6-118-99-122-221.ngrok-free.app/api/auth";
  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<Map<String, dynamic>> loginUser(Map<String, String> body) async {
    try {
      final url = Uri.parse('$baseUrl/login');
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      final responseData = json.decode(response.body) as Map<String, dynamic>;
    
      if (response.statusCode == 200 && responseData['status'] == true) {
        // Store tokens in secure storage
        await _secureStorage.write(key: 'accessToken', value: responseData['accessToken']);
        await _secureStorage.write(key: 'refreshToken', value: responseData['refreshToken']);
        return responseData;
      }
    
      return {
        "status": false,
        "message": responseData['message'] ?? "Login failed",
      };
    } catch (e) {
      return {
        "status": false,
        "message": "Error: $e",
      };
    }
  }
  static Future<Map<String, dynamic>> registerUser(Map<String, String> body) async {
    try {
      final url = Uri.parse('$baseUrl/register');
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 201) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        return {
          "success": false,
          "error": json.decode(response.body)['error'] ?? "Terjadi kesalahan1",
        };
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
  static Future<Map<String, dynamic>> logoutUser(String accessToken, String refreshToken) async {
    try {
      final url = Uri.parse('$baseUrl/logout');
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: json.encode({"refreshToken": refreshToken}),
      );

      if (response.statusCode == 200) {
        await _secureStorage.deleteAll();
        return {"status": true, "message": "Logout successful"};
      } else {
        return {
          "status": false,
          "message": json.decode(response.body)['message'] ?? "Logout failed",
        };
      }
    } catch (e) {
      return {
        "status": false,
        "message": "Error: $e",
      };
    }
  }}
