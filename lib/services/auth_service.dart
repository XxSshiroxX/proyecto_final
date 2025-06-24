import 'package:flutter/material.dart';
import 'secure_storage_service.dart';
import "package:proyecto_final/api_client.dart";

class AuthService {
  final SecureStorageService _storageService = SecureStorageService();

  Future<void> rediretIfNotAuthenticated(BuildContext context) async {
    final token = await _storageService.getToken();

    if (token == null || token.isEmpty) {
      // Si no hay token, redirige a la pantalla de inicio de sesión
      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, '/sign_in');
    }
  }

  Future<void> redirectIfAuthenticated(BuildContext context) async {
    final token = await _storageService.getToken();

    if (token != null && token.isNotEmpty) {
      // Si el token existe, redirige a la pantalla principal
      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  Future<void> logout(BuildContext context) async {
    await _storageService.clearStorage();
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, '/sign_in');
  }

  Future<void> forgotPasswortd(String email) async {
    final response = await ApiClient.post('forgotPassword', {
      'email': email,
    });
    if (response.statusCode == 200) {
      // El correo electrónico se envió correctamente
      return;
    } else {
      // Manejar el error
      throw Exception(
          "Error al enviar el correo electrónico de restablecimiento de contraseña: ${response.body}");
    }
  }
}
