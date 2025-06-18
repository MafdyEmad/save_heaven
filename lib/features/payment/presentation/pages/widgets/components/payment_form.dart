import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_button.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/title_widget.dart';
import 'package:save_heaven/features/payment/presentation/manager/payment%20cubit/payment_cubit.dart';
import 'payment_fields.dart';
import 'payment_method_selector.dart';

class PaymentForm extends StatelessWidget {
  const PaymentForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = PaymentCubit.get(context);
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitle("Please Choose Payment Method :"),
            const PaymentMethodSelector(),
            const SizedBox(height: 20),
            PaymentFields(cubit: cubit),
            const SizedBox(height: 12),
            CustomButton(
              text: "Donate",
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text("Processing Donation...")));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
