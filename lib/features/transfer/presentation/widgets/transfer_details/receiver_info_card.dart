import 'package:flutter/material.dart';
import 'package:sirius_transfer_app/core/resources/app_colors.dart';

class ReceiverInfoCard extends StatelessWidget {
  final String receiverName;
  final String receiverPhone;
  final String? note;

  const ReceiverInfoCard({
    super.key,
    required this.receiverName,
    required this.receiverPhone,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Receiver Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            _InfoField(
              icon: Icons.person,
              label: 'Name',
              value: receiverName,
            ),
            const SizedBox(height: 16),
            _InfoField(
              icon: Icons.phone,
              label: 'Phone',
              value: receiverPhone,
            ),
            if (note != null && note!.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              _InfoField(
                icon: Icons.note,
                label: 'Note',
                value: note!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _InfoField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoField({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
