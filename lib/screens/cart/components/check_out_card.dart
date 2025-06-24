
import 'package:flutter/material.dart';
import 'package:proyecto_final/services/car_service.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:proyecto_final/models/Cart.dart";
import "package:proyecto_final/services/chekout_service.dart";
import "dart:developer";

class CheckoutCard extends StatelessWidget {
  final double total;
  final List<Cart> items; // Lista de productos

  const CheckoutCard({Key? key, required this.total, required this.items})
    : super(key: key);

  Future<void> _startCheckout(BuildContext context) async {
    try {
      if (items.isEmpty) {
        throw 'No hay productos en el carrito';
      }
      final checkoutUrl = await CheckoutService.createCheckoutSession(items);
      // Verificar si la URL es válida
      final Uri checkoutUrlVerified = Uri.parse(checkoutUrl);
      log(checkoutUrlVerified.toString());
      // Abrir la URL de Stripe Checkout

      await launchUrl(
        checkoutUrlVerified,
        mode: LaunchMode.externalApplication,
      );
      CartService.clearCart();
      items.clear();
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: Color.fromARGB((0.15 * 255).toInt(), 218, 218, 218),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          text: "L.${total.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _startCheckout(context),
                    child: const Text("Comprar"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
