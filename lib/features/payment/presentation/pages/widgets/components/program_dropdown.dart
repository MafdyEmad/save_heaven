import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/features/payment/presentation/manager/payment%20cubit/payment_cubit.dart';

class ProgramDropdown extends StatelessWidget {
  const ProgramDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = PaymentCubit.get(context);
    final selected = cubit.state.program;
    final safeSelected = selected == '' ? 'Orphan Sponsorship' : selected;

    return DropdownButtonFormField<String>(
      value: safeSelected,
      decoration: InputDecoration(
        hintText: "Donation Program",
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      style: const TextStyle(fontSize: 14),
      items: const [
        DropdownMenuItem(value: 'Orphan Sponsorship', child: Text('Orphan Sponsorship')),
        DropdownMenuItem(value: 'Food Package', child: Text('Food Package')),
      ],
      onChanged: cubit.changeProgram,
      validator: (val) => val == null || val.isEmpty ? 'Please select a program' : null,
    );
  }
}
