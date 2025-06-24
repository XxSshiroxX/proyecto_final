import 'dart:convert';
import '../api_client.dart';
import '../models/Cart.dart';

class CheckoutService {
  static Future<String> createCheckoutSession(List<Cart> items) async {
    final List<Map<String, dynamic>> formattedItems = items.map((item) {
      return {
        "id": item.product.id,
        "name": item.product.title,
        "price": item.product.price,
        "quantity": item.numOfItem,
      };
    }).toList();

    final response = await ApiClient.post('checkout', {
      'items': formattedItems,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['url'];
    } else {
      throw Exception('Error al crear la sesión de pago: ${response.body}');
    }
  }
}
