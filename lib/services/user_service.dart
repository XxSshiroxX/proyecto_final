import "package:proyecto_final/api_client.dart";
import "package:proyecto_final/models/User.dart";
import "dart:developer";
import "package:proyecto_final/services/secure_storage_service.dart";
import "dart:convert";

class UserService {
  static Future<void> createUser(Map<String, dynamic> userData) async {
    final response = await ApiClient.post('auth/register', userData);

    if (response.statusCode > 300 || response.statusCode < 200) {
      log("Error: ${response.statusCode} - ${response.body}");
      throw Exception("Error al crear el usuario: ${response.body}");
    }
  }

  static Future<void> updateUser(Map<String, dynamic> userData) async {
    final service = SecureStorageService();
    final user = await service.getUser();
    final userId = user?.id ?? "";
    final response = await ApiClient.put('users/$userId', userData);
    if (response.statusCode > 300 || response.statusCode < 200) {
      log("Error: ${response.statusCode} - ${response.body}");
      throw Exception("Error al actualizar el usuario: ${response.body}");
    }
    final updatedUserData=jsonDecode(response.body);
    final updatedUser = User.fromJson(updatedUserData);
    await service.saveUser(updatedUser);
    log("Usuario actualizado: ${updatedUser.toJson()}");
    
  }
}
