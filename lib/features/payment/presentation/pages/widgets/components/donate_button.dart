import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_button.dart';
import 'package:save_heaven/core/widgets/custom_button.dart';

class DonateButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const DonateButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: "Donate",
      onPressed: () {
        if (formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Processing Donation...")));
        }
      },
    );
  }
}
