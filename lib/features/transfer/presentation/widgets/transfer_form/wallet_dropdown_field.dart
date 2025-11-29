import 'package:flutter/material.dart';
import 'package:sirius_transfer_app/core/config/app_constants.dart';
import 'package:sirius_transfer_app/core/resources/app_colors.dart';

class WalletDropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final String hintText;
  final IconData icon;
  final bool enabled;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;

  const WalletDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.hintText,
    required this.icon,
    required this.onChanged,
    this.enabled = true,
    this.validator,
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
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          items: AppConstants.wallets
              .map((wallet) => DropdownMenuItem(
                    value: wallet,
                    child: Text(wallet),
                  ))
              .toList(),
          onChanged: enabled ? onChanged : null,
          validator: validator,
        ),
      ],
    );
  }
}
