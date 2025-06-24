import 'package:flutter/material.dart';
import '../../models/Order.dart';
import '../../services/order_service.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderId;
  static const String routeName = '/orderDetail';

  const OrderDetailScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late Future<Order> _orderFuture;

  @override
  void initState() {
    super.initState();
    _orderFuture = OrderService.getOrderById(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalles de la Orden')),
      body: FutureBuilder<Order>(
        future: _orderFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar los detalles: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No se encontraron detalles.'));
          }

          final order = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Text('Orden ID: ${order.id}',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Text('Usuario ID: ${order.userId}'),
              const SizedBox(height: 8),
              Text('Total: L.${order.total.toStringAsFixed(2)}'),
              const SizedBox(height: 8),
              Text('Estado: ${order.status}'),
              const SizedBox(height: 16),
              const Text('Productos:', style: TextStyle(fontSize: 18)),
              ...order.orderDetails.map((detail) {
                return ListTile(
                  title: Text(detail.product?.title ?? ""),
                  subtitle: Text('Cantidad: ${detail.quantity}'),
                  trailing: Text('L.${detail.price.toStringAsFixed(2)}'),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
