// filter_chip_widget.dart
import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/app_colors.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;
  final String? selected;
  final Function(String?) onTap;

  const FilterChipWidget({super.key, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isSelected = selected == label;

    return GestureDetector(
      onTap: () => onTap(label),
      child: Container(
        margin: const EdgeInsets.only(right: 6, bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 30,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.babyBlue,
          borderRadius: BorderRadius.circular(50),
        ),
        alignment: Alignment.center,
        child: Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontSize: 13)),
      ),
    );
  }
}
