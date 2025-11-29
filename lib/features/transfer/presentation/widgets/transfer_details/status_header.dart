import 'package:flutter/material.dart';
import 'package:sirius_transfer_app/core/utils/status_helper.dart';

class StatusHeader extends StatelessWidget {
  final String status;

  const StatusHeader({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final color = StatusHelper.getStatusColor(status);
    final icon = StatusHelper.getStatusIcon(status);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 64,
            color: color,
          ),
          const SizedBox(height: 16),
          Text(
            StatusHelper.formatStatus(status),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
