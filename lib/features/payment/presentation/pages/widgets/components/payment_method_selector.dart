import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/assets_images.dart';
import 'package:save_heaven/features/payment/presentation/manager/payment%20cubit/payment_cubit.dart';

class PaymentMethodSelector extends StatelessWidget {
  const PaymentMethodSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = PaymentCubit.get(context);

    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildRadioWithImage(
              context: context,
              imagePath: AssetsImages.visa,
              value: 'Visa',
              groupValue: state.paymentMethod,
              onChanged: cubit.changeMethod,
            ),
            _buildRadioWithImage(
              context: context,
              imagePath: AssetsImages.mastarCard,
              value: 'MasterCard',
              groupValue: state.paymentMethod,
              onChanged: cubit.changeMethod,
            ),
          ],
        );
      },
    );
  }

  Widget _buildRadioWithImage({
    required BuildContext context,
    required String imagePath,
    required String value,
    required String groupValue,
    required ValueChanged<String> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: (val) {
              if (val != null) onChanged(val);
            },
            activeColor: Colors.green,
          ),
          Image.asset(imagePath, height: 40, width: 60, fit: BoxFit.contain),
        ],
      ),
    );
  }
}
