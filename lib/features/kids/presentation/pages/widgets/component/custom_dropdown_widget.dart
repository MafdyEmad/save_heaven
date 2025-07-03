import 'package:flutter/material.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/utils/app_colors.dart';
import 'package:save_heaven/core/utils/extensions.dart';

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
        border: Border.all(),
        // color: AppColors.babyBlue,
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.center,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: AppPalette.backgroundColor,
          isExpanded: false,
          value: selected,
          hint: Text(hint, style: context.textTheme.headlineLarge),
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
          items: options
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: context.textTheme.headlineLarge),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
