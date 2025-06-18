import 'package:flutter/material.dart';

class CustomRequestField extends StatelessWidget {
  final String label;
  final String? hintText; // ✅ أضفنا الهينت
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool required;
  final String? Function(String?)? validator;
  final List<String>? dropdownItems;
  final void Function(String?)? onChanged;
  final String? selectedValue;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool readOnly; // ✅ أضفنا readOnly

  const CustomRequestField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.maxLines = 1,
    this.required = true,
    this.validator,
    this.dropdownItems,
    this.onChanged,
    this.selectedValue,
    this.icon,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: width * 0.037,
            )),
        const SizedBox(height: 6),

        dropdownItems != null
            ? DropdownButtonFormField<String>(
                value: selectedValue,
                items: dropdownItems!
                    .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                    .toList(),
                onChanged: onChanged,
                validator: validator ?? (val) => val == null || val.isEmpty ? 'Required field' : null,
                decoration: _buildDecoration(),
              )
            : TextFormField(
                controller: controller,
                keyboardType: keyboardType,
                maxLines: maxLines,
                readOnly: onTap != null || readOnly,
                onTap: onTap,
                validator: validator ?? (val) => val == null || val.isEmpty ? 'Required field' : null,
                decoration: _buildDecoration(prefixIcon: icon, hint: hintText),
              ),

        const SizedBox(height: 16),
      ],
    );
  }

  InputDecoration _buildDecoration({IconData? prefixIcon, String? hint}) {
    return InputDecoration(
      hintText: hint, // ✅ استخدمنا الهينت هنا
      filled: true,
      fillColor: const Color(0xFFF5F5F5),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}
