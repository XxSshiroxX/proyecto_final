import 'package:flutter/material.dart';
import '../../../services/sub_category_service.dart';
import '../../../models/Category.dart';
import "package:proyecto_final/screens/home/components/section_title.dart";

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SectionTitle(
          title: "Sub Categorias",
          press: () {
            Navigator.pushNamed(
              context,
              '/subcategories',
            );
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<List<SubCategory>>(
          future: SubCategoryService.fetchSubCategories(8), // Llama al servicio
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No hay subcategorías disponibles.'),
              );
            } else {
              final subCategories = snapshot.data!;
              return SingleChildScrollView(
                scrollDirection:
                    Axis.horizontal, // Permite desplazamiento horizontal
                child: Row(
                  children: List.generate(
                    subCategories.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(
                          right: 16), // Espaciado entre categorías
                      child: CategoryCard(
                        icon: subCategories[index].image,
                        text: subCategories[index].name,
                        press: () {
                          // Acción al presionar una subcategoría
                          Navigator.pushNamed(
                            context,
                            '/products',
                            arguments: {
                              "bySubCategory": true,
                              "subcategoryId": subCategories[index].id,
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      )
    ]);
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
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFFFECDF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network(
              icon,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image); // Imagen de respaldo
              },
            ),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
