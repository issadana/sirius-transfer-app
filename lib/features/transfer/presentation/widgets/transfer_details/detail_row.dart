import 'package:flutter/material.dart';
import 'package:sirius_transfer_app/core/resources/app_colors.dart';

class DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isHighlighted;

  const DetailRow({
    super.key,
    required this.label,
    required this.value,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isHighlighted ? 16 : 14,
            fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
            color: isHighlighted ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isHighlighted ? 20 : 16,
            fontWeight: FontWeight.bold,
            color: isHighlighted ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
