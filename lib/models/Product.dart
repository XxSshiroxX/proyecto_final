import 'dart:developer';

class Product {
  final String id;
  final String title, description, category;
  final List<String> images;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.images,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      return Product(
        id: json['id'] ?? '', // Maneja el caso en que 'id' sea null
        title:
            json['name'] ?? 'Sin título', // Proporciona un valor predeterminado
        description: json['description'] ?? 'Sin descripción',
        category: json['subCategory']?['name'] ??
            'Sin categoría', // Maneja subCategory null
        images: (json['ProductImages'] as List<dynamic>?)
                ?.map((image) => image['url'] as String)
                .toList() ??
            [], // Maneja ProductImages null o vacío
        price: (json['price'] != null
            ? (json['price'] as num).toDouble()
            : 0.0), // Maneja el caso null
        rating: (json['rating'] != null
            ? (json['rating'] as num).toDouble()
            : 0.0), // Maneja el caso null
        isFavourite: (json["isFavorite"] ?? false),
        isPopular: false, // Por defecto, no es popular
      );
    } catch (e, stackTrace) {
      log('Error al parsear el producto: $e');
      log('StackTrace: $stackTrace');
      log('JSON recibido: $json');
      rethrow; // Lanza el error nuevamente para que sea manejado por el FutureBuilder
    }
  }
}

// Our demo Products

List<Product> demoProducts = [
  Product(
    id: "s",
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    title: "Control inalámbrico para PS4™",
    price: 64.99,
    description: description,
    rating: 4.8,
    category: "Accesorios",
  ),
  Product(
    id: "s",
    images: [
      "assets/images/wireless headset.png",
    ],
    title: "Auriculares Logitech",
    price: 20.20,
    description: description,
    rating: 4.1,
    category: "Juegos",
  ),
];

const String description =
    "El control inalámbrico para PS4™ te ofrece lo que deseas en tus juegos, desde un control de precisión hasta compartir …";
