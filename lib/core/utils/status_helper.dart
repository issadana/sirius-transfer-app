import 'package:flutter/material.dart';
import 'package:sirius_transfer_app/core/resources/app_colors.dart';

// Utility class for status-related operations
class StatusHelper {
  StatusHelper._();

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return AppColors.success;
      case 'pending':
        return AppColors.warning;
      case 'processing':
        return AppColors.primary;
      case 'failed':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  static IconData getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Icons.check_circle;
      case 'pending':
        return Icons.pending;
      case 'processing':
        return Icons.hourglass_empty;
      case 'failed':
        return Icons.error;
      default:
        return Icons.info;
    }
  }

  static String formatStatus(String status) {
    return status.toUpperCase();
  }
}
