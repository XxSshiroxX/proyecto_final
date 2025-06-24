import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../models/User.dart';

class SecureStorageService {
  static const _userKey = 'user';
  static const _tokenKey = 'token';

  // Instancia de FlutterSecureStorage
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Guardar el usuario
  Future<void> saveUser(User user) async {
    final userJson = jsonEncode(user.toJson());
    await _storage.write(key: _userKey, value: userJson);
  }

  // Guardar el token
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  // Obtener el usuario
  Future<User?> getUser() async {
    final userJson = await _storage.read(key: _userKey);
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  // Obtener el token
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // Eliminar el usuario y el token
  Future<void> clearStorage() async {
    await _storage.delete(key: _userKey);
    await _storage.delete(key: _tokenKey);
  }
}
