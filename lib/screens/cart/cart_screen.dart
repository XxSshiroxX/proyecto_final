import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/cart_card.dart';
import 'components/check_out_card.dart';
import "package:proyecto_final/services/car_service.dart";

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    // Obtén los elementos del carrito desde el CartService
    final cartItems = CartService.getCartItems();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              "Carrito",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "${cartItems.length} objetos", // Muestra la cantidad de objetos en el carrito
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: cartItems.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
              key: Key(cartItems[index].product.id.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  // Elimina el producto del carrito usando el CartService
                  CartService.removeFromCart(cartItems[index].product.id);
                });
              },
              background: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE6E6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    SvgPicture.asset("assets/icons/Trash.svg"),
                  ],
                ),
              ),
              child: CartCard(cart: cartItems[index]),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CheckoutCard(
        total: CartService.calculateTotal(), // Calcula el total del carrito
        items: cartItems,
      ),
    );
  }
}
