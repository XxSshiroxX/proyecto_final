import 'package:flutter/material.dart';
import 'package:proyecto_final/components/product_card.dart';
import 'package:proyecto_final/models/Product.dart';
import 'package:proyecto_final/services/products_service.dart';

import '../details/details_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text(
            "Favoritos",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: ProductService.fetchProductsByFavorites(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No tienes productos en favoritos.'),
                  );
                } else {
                  final favoriteProducts = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: GridView.builder(
                      itemCount: favoriteProducts.length,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 0.69,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) => ProductCard(
                        product: favoriteProducts[index],
                        onPress: () => Navigator.pushNamed(
                          context,
                          DetailsScreen.routeName,
                          arguments: ProductDetailsArguments(
                            product: favoriteProducts[index],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}