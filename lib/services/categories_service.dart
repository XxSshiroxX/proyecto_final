import 'dart:convert';
import '../api_client.dart';
import '../models/Category.dart';
import 'dart:developer';

class CategoryService {
  static Future<List<Category>> fetchCategories() async {
    final response = await ApiClient.get(
        'categories'); // Cambia 'categories' por tu endpoint
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception(
          'Error al obtener las categorías: ${response.statusCode}');
    }
  }
}
