import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:save_heaven/core/utils/extensions.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final bool isPassword;
  final bool isVisible;
  final int? maxLines;
  final VoidCallback? onToggleVisibility;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final Function(String)? onChanged;

  /// ✅ New: Allow only positive numbers.
  final bool isNumbersOnly;

  /// ✅ New: Explicit read-only toggle.
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.hint,
    this.icon,
    this.isPassword = false,
    this.isVisible = true,
    this.onToggleVisibility,
    this.controller,
    this.validator,
    this.onTap,
    this.onChanged,
    this.maxLines,
    this.isNumbersOnly = false,
    this.readOnly = false, // 👈 NEW default
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        maxLines: isPassword ? 1 : (maxLines ?? 1),
        onChanged: onChanged,
        controller: controller,
        validator: validator,
        obscureText: isPassword ? isVisible : false,
        onTap: onTap,
        readOnly: readOnly,

        keyboardType: isNumbersOnly ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumbersOnly
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,

        decoration: InputDecoration(
          errorStyle: context.textTheme.headlineSmall?.copyWith(
            color: Colors.red,
          ),
          hintText: hint,
          prefixIcon: icon != null ? Icon(icon, size: 20) : null,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isVisible ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                  onPressed: onToggleVisibility,
                )
              : null,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
