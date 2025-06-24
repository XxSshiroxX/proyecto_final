import 'package:flutter/material.dart';

import '../../../components/product_card.dart';
import '../../../models/Product.dart';
import '../../details/details_screen.dart';
import '../../products/products_screen.dart';
import '../../../services/products_service.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Productos Populares",
            press: () {
              Navigator.pushNamed(context, ProductsScreen.routeName,
                  arguments: {
                    "byPopularity": true,
                  });
            },
          ),
        ),
        const SizedBox(height: 16),
        FutureBuilder<List<Product>>(
          future: ProductService.fetchProducts(
              true, 5), // Trae los populares con límite de 5
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No hay productos populares disponibles.'),
              );
            } else {
              final popularProducts = snapshot.data!;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      popularProducts.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ProductCard(
                          product: popularProducts[index],
                          onPress: () => Navigator.pushNamed(
                            context,
                            DetailsScreen.routeName,
                            arguments: ProductDetailsArguments(
                              product: popularProducts[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
