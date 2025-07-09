import 'package:flutter/material.dart';
import 'widgets/payment_body.dart';

class PaymentView extends StatelessWidget {
  final bool isMony;
  final String orphanageId;
  const PaymentView({
    super.key,
    required this.isMony,
    required this.orphanageId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaymentBody(isMony: isMony, orphanageId: orphanageId),
    );
  }
}
