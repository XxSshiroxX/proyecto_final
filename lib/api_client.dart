import 'dart:convert';
import 'package:http/http.dart' as http;
import './services/secure_storage_service.dart'; // Importa el servicio de almacenamiento seguro

class ApiClient {
  static const String baseUrl =
      "http://10.0.2.2:3000";

  // Método para realizar peticiones POST
  static Future<http.Response> post(
      String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final token = await SecureStorageService()
        .getToken(); // Obtén el token desde el almacenamiento seguro
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    return await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
  }

  // Método para realizar peticiones GET
  static Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final token = await SecureStorageService()
        .getToken(); 
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    return await http.get(url, headers: headers);
  }

  static Future<http.Response> put(
      String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final token = await SecureStorageService()
        .getToken(); // Obtén el token desde el almacenamiento seguro
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    return await http.put(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> delete(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final token = await SecureStorageService()
        .getToken(); 
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    return await http.delete(url, headers: headers);
  }
}
