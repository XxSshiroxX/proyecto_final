import 'package:flutter/material.dart';
import 'package:proyecto_final/components/product_card.dart';
import 'package:proyecto_final/models/Product.dart';
import 'package:proyecto_final/services/products_service.dart';
import '../details/details_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  static String routeName = "/products";

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ??
            {};
    final bool byCategory = arguments['byCategory'] ?? false;
    final bool byFavorites = arguments['byFavorites'] ?? false;
    final bool byPopularity = arguments['byPopularity'] ?? false;
    final bool bySubCategory = arguments['bySubCategory'] ?? false;
    final bool bySearch = arguments['bySearch'] ?? false;
    final String search = arguments['search'] ?? "";
    final String categoryId = arguments['categoryId'] ?? "";
    final String subcategoryId = arguments['subcategoryId'] ?? "";

    final String title = byCategory
        ? "Productos por Categoría"
        : byFavorites
            ? "Productos Favoritos"
            : byPopularity
                ? "Productos Populares"
                : bySubCategory
                    ? "Productos por Sub Categoria"
                    : bySearch
                        ? "Buscando: $search"
                        : "Productos";

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder<List<Product>>(
            future: byCategory
                ? ProductService.fetchProductsByCategory(categoryId)
                : byFavorites
                    ? ProductService.fetchProductsByFavorites()
                    : byPopularity
                        ? ProductService.fetchProducts(true, 20)
                        : bySubCategory
                            ? ProductService.fetchProductsBySubCategory(
                                subcategoryId)
                            : bySearch
                                ? ProductService.fetchProducts(false, 0, search)
                                : ProductService.fetchProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No hay productos disponibles.'),
                );
              } else {
                final products = snapshot.data!;
                return GridView.builder(
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 20,
                    childAspectRatio:
                        0.69, // puedes ajustarlo si quieres más uniforme
                  ),
                  itemBuilder: (context, index) => ProductCard(
                    product: products[index],
                    onPress: () => Navigator.pushNamed(
                      context,
                      DetailsScreen.routeName,
                      arguments:
                          ProductDetailsArguments(product: products[index]),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
