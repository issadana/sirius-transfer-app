import 'package:flutter/material.dart';
import 'package:sirius_transfer_app/core/resources/app_colors.dart';

class LabeledTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool enabled;
  final int? maxLength;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const LabeledTextFormField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.keyboardType,
    this.enabled = true,
    this.maxLength,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          enabled: enabled,
          maxLength: maxLength,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
