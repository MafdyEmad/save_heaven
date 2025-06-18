import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/app_colors.dart';

class CustomDropdownWidget extends StatelessWidget {
  final String hint;
  final String? selected;
  final void Function(String?) onChanged;
  final List<String> options;

  const CustomDropdownWidget({
    super.key,
    required this.hint,
    required this.selected,
    required this.onChanged,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width * 0.6;
    final height = size.height * 0.06;

    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.babyBlue,
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.center,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selected,
          hint: Text(hint),
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
          items: options
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
