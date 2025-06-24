import 'dart:convert';
import '../api_client.dart';
import '../models/Category.dart';
import 'dart:developer';

class SubCategoryService {
  // Obtener todas las categorías
  static Future<List<SubCategory>> fetchSubCategories([int limit = 0]) async {
    String extraQueries = limit > 0 ? '?limit=$limit' : '';
    final response = await ApiClient.get(
        'subcategories$extraQueries'); // Endpoint para categorías
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      log('Fetching all categories');
      return data.map((json) => SubCategory.fromJson(json)).toList();
    } else {
      log(response.body);
      throw Exception(
          'Error al obtener las categorías: ${response.statusCode}');
    }
  }

  // Obtener subcategorías por categoría
  static Future<List<SubCategory>> fetchSubCategoriesByCategory(
      String categoryId) async {
    final response = await ApiClient.get(
        'subcategories/category/$categoryId'); // Endpoint para subcategorías
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      log('Fetching subcategories for category $categoryId');
      return data.map((json) => SubCategory.fromJson(json)).toList();
    } else {
      log(response.body);
      throw Exception(
          'Error al obtener las subcategorías: ${response.statusCode}');
    }
  }

  // Obtener productos por subcategoría
}
