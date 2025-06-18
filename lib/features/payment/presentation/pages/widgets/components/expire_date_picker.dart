// import 'package:flutter/material.dart';
// import 'package:save/core/utils/validators.dart';
// import 'package:save/features/auth/presentation/widgets/components/custom_text_field.dart';
// import 'package:save/features/payment/presentation/manager/payment%20cubit/payment_cubit.dart';

// class ExpireDatePicker extends StatelessWidget {
//   const ExpireDatePicker({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final cubit = PaymentCubit.get(context);

//     return CustomTextField(
//       hint: "Expire Date",
//       controller: cubit.expireDateController,
//       validator: Validators.requiredField,
//       onTap: () async {
//         final picked = await showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime.now(),
//           lastDate: DateTime(2030),
//         );
//         if (picked != null) {
//           cubit.expireDateController.text = "${picked.month}/${picked.year}";
//         }
//       },
//     );
//   }
// }
