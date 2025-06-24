import '../api_client.dart';
import '../models/Order.dart';
import "package:proyecto_final/services/secure_storage_service.dart";
import "dart:developer";
import 'dart:convert';

class OrderService {
  // Obtener todas las órdenes del usuario
  static Future<List<Order>> getOrders() async {
    final SecureStorageService secureStorageService = SecureStorageService();
    final user = await secureStorageService.getUser();
    final userId = user?.id ?? "";
    final response = await ApiClient.get('orders?userId=$userId');
    log("fetching orders");
    log("Response body: ${response.body}");

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        throw Exception('El cuerpo de la respuesta está vacío.');
      }

      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data.map((orderJson) => Order.fromJson(orderJson)).toList();
    } else {
      log("Error response: ${response.body}");
      throw Exception('Error al obtener las órdenes: ${response.body}');
    }
  }

  // Obtener una orden específica por ID
  static Future<Order> getOrderById(String orderId) async {
    final response = await ApiClient.get('orders/$orderId');
    log("fetching order by id");

    if (response.statusCode == 200) {
      // Decodifica el cuerpo de la respuesta
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return Order.fromJson(data);
    } else {
      throw Exception('Error al obtener la orden: ${response.body}');
    }
  }
}
