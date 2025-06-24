import 'package:flutter/material.dart';

class PaymentResultScreen extends StatelessWidget {
  final String paymentStatus;
  static const String routeName = '/payment_result';

  const PaymentResultScreen({Key? key, required this.paymentStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultado del Pago')),
      body: Center(
        child: Text(paymentStatus),
      ),
    );
  }
}