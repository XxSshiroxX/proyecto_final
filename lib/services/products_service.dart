import 'dart:convert';
import '../api_client.dart';
import '../models/Product.dart';
import 'dart:developer';
import "package:proyecto_final/services/secure_storage_service.dart";

class ProductService {
  static Future<List<Product>> fetchProducts(
      [bool byPopularity = false, int limit = 0, String search = ""]) async {
    String extraQueries = byPopularity ? '&byPopularity=true' : '';
    extraQueries += limit > 0 ? '&limit=$limit' : '';
    extraQueries += search.isNotEmpty ? '&search=$search' : '';
    final response = await ApiClient.get(
        'products?rating=true$extraQueries'); // Cambia 'products' por tu endpoint
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      if (byPopularity) {
        log('Fetching popular products');
      } else if (search.isNotEmpty) {
        log('Fetching all products by query');
      } else {
        log('Fetching all products');
      }
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener los productos: ${response.statusCode}');
    }
  }

  static Future<List<Product>> fetchProductsByCategory(
      String categoryId) async {
    final response = await ApiClient.get(
        'products/byCategory/$categoryId?rating=true'); // Cambia 'products' por tu endpoint
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      log('Fetching products by category');
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      log(response.body);
      throw Exception('Error al obtener los productos: ${response.statusCode}');
    }
  }

  static Future<List<Product>> fetchProductsBySubCategory(String categoryId,
      [int limit = 0]) async {
    String extraQueries = limit > 0 ? '&limit=$limit' : '';
    final response = await ApiClient.get(
        'products/bySubCategory/$categoryId?rating=true$extraQueries'); // Cambia 'products' por tu endpoint
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      log('Fetching products by sub category');
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      log(response.body);
      throw Exception('Error al obtener los productos: ${response.statusCode}');
    }
  }

  static Future<List<Product>> fetchProductsByFavorites() async {
    final service = SecureStorageService();
    final user = await service.getUser();
    String userId = user?.id ?? '';
    final response =
        await ApiClient.get('products/favorites/$userId?rating=true');
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      log('Fetching products by favorites');
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      log(response.body);
      throw Exception('Error al obtener los productos: ${response.statusCode}');
    }
  }
}
