import 'package:flutter/material.dart';
import 'package:proyecto_final/services/categories_service.dart';
import 'package:proyecto_final/models/Category.dart';

class CategoriesScreen extends StatelessWidget {
  static String routeName = "/categories";

  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categorías"),
      ),
      body: FutureBuilder<List<Category>>(
        future: CategoryService.fetchCategories(), // Llama al servicio
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No hay categorías disponibles.'),
            );
          } else {
            final categories = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: CategoryCard(
                    icon: category.image,
                    text: category.name,
                    press: () {
                      Navigator.pushNamed(
                        context,
                        '/subcategories',
                        arguments: {
                          "categoryId": category.id,
                          "byCategory": true
                        },
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 70,
            width: 150,
            decoration: BoxDecoration(
              color: const Color(0xFFFFECDF),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Image.network(
              icon,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image); // Imagen de respaldo
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
