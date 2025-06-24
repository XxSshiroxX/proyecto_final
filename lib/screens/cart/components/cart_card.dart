import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/Cart.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                cart.product.images.isNotEmpty
                    ? cart.product.images[0]
                    : 'https://via.placeholder.com/150', // Imagen de respaldo si no hay imágenes
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image); // Muestra un ícono si la imagen no se carga
                },
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded( // Ajusta el contenido al espacio disponible
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cart.product.title,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis, // Evita el desbordamiento del texto
              ),
              const SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  text: "L.${cart.product.price}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                  children: [
                    TextSpan(
                      text: " x${cart.numOfItem}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}