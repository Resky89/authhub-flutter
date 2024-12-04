import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthController {
  static const String baseUrl = "https://358f-182-253-176-172.ngrok-free.app/api/auth";

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
}
