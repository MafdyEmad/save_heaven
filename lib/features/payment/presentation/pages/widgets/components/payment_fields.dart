import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/validators.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_text_field.dart';
import 'package:save_heaven/features/payment/presentation/manager/payment%20cubit/payment_cubit.dart';
import 'field_label.dart';

class PaymentFields extends StatelessWidget {
  final PaymentCubit cubit;

  const PaymentFields({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel("Donation Program"),
        DropdownButtonFormField<String>(
          value: cubit.state.program.isNotEmpty ? cubit.state.program : 'Orphan Sponsorship',
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          items: const [
            DropdownMenuItem(value: 'Orphan Sponsorship', child: Text('Orphan Sponsorship')),
            DropdownMenuItem(value: 'Food Package', child: Text('Food Package')),
          ],
          onChanged: cubit.changeProgram,
          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 16),

        const FieldLabel("Cardholder Name"),
        CustomTextField(
          hint: "Cardholder Name",
          controller: cubit.cardHolder,
          validator: Validators.requiredField,
        ),

        const FieldLabel("Card Number"),
        CustomTextField(
          hint: "Card Number",
          controller: cubit.cardNumber,
          validator: Validators.numberOnly,
        ),

        const FieldLabel("Donation Value & CVC"),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                hint: "Donation Value",
                controller: cubit.donationValue,
                validator: Validators.positiveNumber,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomTextField(
                hint: "CVC",
                controller: cubit.cvc,
                validator: Validators.numberOnly,
              ),
            ),
          ],
        ),

        const FieldLabel("Expire Date"),
        CustomTextField(
          hint: "9/12",
          controller: cubit.expiryDate,
          validator: Validators.requiredField,
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime(2030),
              initialDate: DateTime.now(),
            );
            if (picked != null) {
              cubit.expiryDate.text = "${picked.month}/${picked.year}";
            }
          },
        ),
      ],
    );
  }
}
