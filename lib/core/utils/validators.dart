import '../config/app_constants.dart';

// Form validation utilities
class Validators {
  Validators._();

  // Generic required field validator
  static String? Function(String?) required(String fieldName) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return '$fieldName is required';
      }
      return null;
    };
  }

  // Validate name field
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Receiver name is required';
    }

    if (value.trim().length < AppConstants.minNameLength) {
      return 'Name must be at least ${AppConstants.minNameLength} characters';
    }

    if (value.trim().length > AppConstants.maxNameLength) {
      return 'Name must not exceed ${AppConstants.maxNameLength} characters';
    }

    // Check if name contains only letters and spaces
    final nameRegex = RegExp(r"^[a-zA-Z\s]+$");
    if (!nameRegex.hasMatch(value.trim())) {
      return 'Name can only contain letters and spaces';
    }

    return null;
  }

  // Validate phone number
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    // Remove spaces and special characters for validation
    final cleanPhone = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    final phoneRegex = RegExp(AppConstants.phonePattern);
    if (!phoneRegex.hasMatch(cleanPhone)) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  // Validate amount field
  static String? amount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Amount is required';
    }

    final amount = double.tryParse(value);
    if (amount == null) {
      return 'Please enter a valid amount';
    }

    if (amount < AppConstants.minTransferAmount) {
      return 'Minimum amount is ${AppConstants.formatCurrency(AppConstants.minTransferAmount)}';
    }

    if (amount > AppConstants.maxTransferAmount) {
      return 'Maximum amount is ${AppConstants.formatCurrency(AppConstants.maxTransferAmount)}';
    }

    return null;
  }
}
