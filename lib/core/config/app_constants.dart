// Application-Wide Constants
class AppConstants {
  // Private constructor prevents instantiation
  AppConstants._();

  // Wallet Configuration
  // Available wallet providers for transfers
  static const List<String> wallets = ['Neo', 'Whish', 'Bo2', 'OMT'];

  // Fee Configuration
  // Transfer fee percentage (2% = 0.02)
  static const double feePercentage = 0.02;

  // Minimum transfer amount in currency
  static const double minTransferAmount = 1.0;

  // Maximum transfer amount in currency
  static const double maxTransferAmount = 50000.0;

  // API Configuration (Fake API Simulation)
  // Simulated API delay in milliseconds
  static const int apiDelayMilliseconds = 1500;

  // Transfer Status Constants
  static const String statusPending = 'Pending';
  static const String statusProcessing = 'Processing';
  static const String statusCompleted = 'Completed';
  static const String statusFailed = 'Failed';

  // Validation Rules
  static const int minNameLength = 2;
  static const int maxNameLength = 100;
  static const String phonePattern = r'^\+?[0-9]{10,15}$';
  static const int maxNoteLength = 100;

  // Currency & Formatting
  static const String currencySymbol = '\$';
  static const int currencyDecimalPlaces = 2;

  // Helper Methods
  // Calculate 2% fee from amount
  static double calculateFee(double amount) => amount * feePercentage;

  // Calculate total amount including fee
  static double calculateTotal(double amount) => amount + calculateFee(amount);

  // Format currency amount with symbol
  static String formatCurrency(double amount) {
    return '$currencySymbol${amount.toStringAsFixed(currencyDecimalPlaces)}';
  }
}
