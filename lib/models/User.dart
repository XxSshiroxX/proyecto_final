
class User {
  final String id;
  final String email;
  final String name;
  final String lastName;
  final String cellPhone;
  final String address;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.lastName,
    required this.cellPhone,
    required this.address,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convertir un objeto User a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'lastName': lastName,
      'cellPhone': cellPhone,
      'address': address,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Crear un objeto User desde JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      lastName: json['lastName'],
      cellPhone: json['cellPhone'],
      address: json['address'],
      role: json['role'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
