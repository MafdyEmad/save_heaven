import 'package:flutter/material.dart';
import 'widgets/payment_body.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PaymentBody(),
    );
  }
}
