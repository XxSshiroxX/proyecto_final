import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import '../models/Product.dart';
import '../services/favorite_service.dart'; // Servicio para manejar favoritos
import "dart:developer"; // Para el manejo de logs

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
    required this.onPress,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;
  final VoidCallback onPress;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late bool isFavourite;

  @override
  void initState() {
    super.initState();
    isFavourite = widget
        .product.isFavourite; // Inicializa el estado con el valor del producto
  }

  Future<void> toggleFavorite() async {
    bool oldFavorite = isFavourite; // Guarda el estado anterior
    setState(() {
      isFavourite = !isFavourite; // Cambia el estado inmediatamente
    });

    try {
      // Llama al servicio para agregar o quitar de favoritos
      final success =
          await FavoriteService.toggleFavorite(widget.product.id, oldFavorite);

      if (!success) {
        // Si el servidor devuelve un error, revierte el cambio
        setState(() {
          isFavourite = !isFavourite;
        });
        if (!mounted) return; // Verifica si el widget está montado
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al actualizar favoritos')),
        );
      }
    } catch (e) {
      // Maneja errores inesperados
      setState(() {
        isFavourite = !isFavourite; // Revierte el cambio
      });
      if (!mounted) return; // Verifica si el widget está montado

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error de conexión con el servidor')),
      );
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: GestureDetector(
        onTap: widget.onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: widget.aspectRetio,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.network(
                  widget.product.images.isNotEmpty
                      ? widget.product.images[0]
                      : 'https://via.placeholder.com/150', // Imagen de respaldo si no hay imágenes
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons
                        .broken_image); // Muestra un ícono si la imagen no se carga
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.title,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2, // Permite un máximo de 2 líneas
              overflow: TextOverflow
                  .ellipsis, // Muestra "..." si el texto es demasiado largo
              softWrap: true, // Permite que el texto se ajuste automáticamente
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "L.${widget.product.price}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap:
                      toggleFavorite, // Llama a la función para alternar favoritos
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      color: isFavourite
                          ? kPrimaryColor.withOpacity(0.15)
                          : kSecondaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/Heart Icon_2.svg",
                      colorFilter: ColorFilter.mode(
                        isFavourite
                            ? const Color(0xFFFF4848)
                            : const Color(0xFFDBDEE4),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
