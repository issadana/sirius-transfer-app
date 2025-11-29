import 'package:intl/intl.dart';

// Utility class for formatting dates across the app
class DateFormatter {
  DateFormatter._();

  static String formatRelative(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today at ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday at ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }

  // Formats a DateTime to a standard date string
  static String formatStandard(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  // Formats a DateTime to a standard date and time string
  static String formatDateTime(DateTime date) {
    return DateFormat('MMM dd, yyyy HH:mm').format(date);
  }
}
