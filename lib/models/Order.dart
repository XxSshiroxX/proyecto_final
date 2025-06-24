import 'Product.dart';

class Order {
  final String id;
  final String userId;
  final double total;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<OrderDetail> orderDetails;

  Order({
    required this.id,
    required this.userId,
    required this.total,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.orderDetails,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? 'Desconocido',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      orderDetails: (json['OrderDetail'] as List<dynamic>?)
              ?.map((detail) => OrderDetail.fromJson(detail))
              .toList() ??
          [],
    );
  }
}

class OrderDetail {
  final String id;
  final String orderId;
  final String productId;
  final int quantity;
  final double price;
  final Product? product;

  OrderDetail({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
    this.product,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['id'] ?? '',
      orderId: json['orderId'] ?? '',
      productId: json['productId'] ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      product: json['Product'] != null
          ? Product.fromJson(json['Product'])
          : Product(
              id: '', // Proporciona un valor predeterminado o maneja el error
              images: [],
              title: '',
              description: '',
              category: '',
              price: 0.0,
            ), // Maneja el caso en que 'Product' sea null
    );
  }
}
