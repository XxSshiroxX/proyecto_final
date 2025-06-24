import "package:proyecto_final/api_client.dart";
import "secure_storage_service.dart";
import "dart:developer"; // Para el manejo de logs

class FavoriteService {
  // Obtén el userId del almacenamiento seguro
  static Future<void> addToFavorites(String productId) async {
    final SecureStorageService secureStorageService = SecureStorageService();

    final user = await secureStorageService.getUser();
    final response = await ApiClient.post(
        "favorites", {"productId": productId, "userId": user?.id ?? ""});
    if (response.statusCode < 200 || response.statusCode >= 300) {
    // Maneja cualquier código fuera del rango 200-299 como un error
    log(response.body.toString());
    log(response.statusCode.toString());
    throw Exception("Failed to add to favorites");
  }
  }

  static Future<void> removeFromFavorites(String productId) async {
    final SecureStorageService secureStorageService = SecureStorageService();
    final user = await secureStorageService.getUser();
    String userId = user?.id ?? "";
    final response =
        await ApiClient.delete("favorites?productId=$productId&userId=$userId");
    if (response.statusCode < 200 || response.statusCode >= 300) {
    // Maneja cualquier código fuera del rango 200-299 como un error
    log(response.body.toString());
    log(response.statusCode.toString());
    throw Exception("Failed to remove from favorites");
  }
  }

  static Future<bool> toggleFavorite(String productId, bool isFavorite) async {
    try
    {if (isFavorite) {
      // Si ya está en favoritos, elimínalo
      await removeFromFavorites(productId);
      return true; // Ahora no es favorito
    } else {
      // Si no está en favoritos, agrégalo
      await addToFavorites(productId);
      return true; // Ahora es favorito
    }
    } catch (e) {
      // Maneja errores inesperados
      log(e.toString());
      return false; // En caso de error, no se cambia el estado
    }
  }
}
