import "dart:developer";

import 'package:flutter/material.dart';
import '../../models/Order.dart';
import '../../services/order_service.dart';
import 'order_detail_screen.dart';

class OrderListScreen extends StatefulWidget {
  static const String routeName = '/orders';

  const OrderListScreen({Key? key}) : super(key: key);

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final List<Order> _orders = [];
  int _currentPage = 1;
  final int _itemsPerPage = 10;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final allOrders = await OrderService.getOrders();
      final startIndex = (_currentPage - 1) * _itemsPerPage;
      final endIndex = startIndex + _itemsPerPage;

      if (startIndex >= allOrders.length) {
        setState(() {
          _hasMore = false;
        });
      } else {
        final newOrders = allOrders.sublist(
          startIndex,
          endIndex > allOrders.length ? allOrders.length : endIndex,
        );
        setState(() {
          _orders.clear();
          _orders.addAll(newOrders);
          _hasMore = endIndex < allOrders.length;
        });
      }
    } catch (e) {
      if (!mounted) return;
      log("error fetching orders: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar las órdenes: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _goToNextPage() {
    if (_hasMore) {
      setState(() {
        _currentPage++;
      });
      _fetchOrders();
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
        _hasMore = true; // Permitir avanzar nuevamente
      });
      _fetchOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Órdenes')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];
                return ListTile(
                  title: Text('Orden #${order.id}'),
                  subtitle: Text('Total: L.${order.total.toStringAsFixed(2)}'),
                  trailing: Text(order.status),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OrderDetailScreen(orderId: order.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150, // Ancho fijo para el botón
                  child: ElevatedButton(
                    onPressed: _currentPage > 1 && !_isLoading
                        ? _goToPreviousPage
                        : null,
                    child: const Text('Anterior'),
                  ),
                ),
                SizedBox(
                  width: 150, // Ancho fijo para el botón
                  child: ElevatedButton(
                    onPressed: _hasMore && !_isLoading ? _goToNextPage : null,
                    child: const Text('Siguiente'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
