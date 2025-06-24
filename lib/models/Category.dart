class Category {
  final String id;
  final String name;
  final String description;
  final String image;
  final List<SubCategory> subCategories;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Sin nombre',
      description: json['description'] ?? 'Sin descripción',
      image: json['image'] ?? '',
      subCategories: (json['SubCategory'] as List<dynamic>?)
              ?.map((subCategory) => SubCategory.fromJson(subCategory))
              .toList() ??
          [],
    );
  }
}

class SubCategory {
  final String id;
  final String name;
  final String description;
  final String image;
  final String categoryId;

  SubCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.categoryId,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Sin nombre',
      description: json['description'] ?? 'Sin descripción',
      image: json['image'] ?? '',
      categoryId: json['categoryId'] ?? '',
    );
  }
}