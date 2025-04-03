import 'package:intl/intl.dart';

class DateUtil {
  /// Formats a date to the format "d MMM, yyyy" (e.g., "15 Jan, 2025")
  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('d MMM, yyyy');
    return formatter.format(date);
  }

  /// Formats a date range with optional end date
  /// If toDate is null, returns "From [fromDate]"
  /// Otherwise, returns "[fromDate] - [toDate]"
  static String formatDateRange(DateTime fromDate, DateTime? toDate) {
    final String formattedFromDate = formatDate(fromDate);

    if (toDate == null) {
      return 'From $formattedFromDate';
    } else {
      final String formattedToDate = formatDate(toDate);
      return '$formattedFromDate - $formattedToDate';
    }
  }

  /// Checks if two dates are equal (ignoring time)
  static bool isDateEqual(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Checks if a date is before another date (ignoring time)
  static bool isDateBefore(DateTime a, DateTime b) {
    return DateTime(a.year, a.month, a.day).isBefore(DateTime(b.year, b.month, b.day));
  }

  /// Checks if a date is after another date (ignoring time)
  static bool isDateAfter(DateTime a, DateTime b) {
    return DateTime(a.year, a.month, a.day).isAfter(DateTime(b.year, b.month, b.day));
  }

  /// Returns today's date with time set to midnight
  static DateTime today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// Gets the next occurrence of a specific weekday
  /// weekday should be between 1 (Monday) and 7 (Sunday)
  static DateTime getNextWeekday(int weekday) {
    final now = DateTime.now();
    final daysUntilWeekday = weekday - now.weekday;
    return now.add(Duration(days: daysUntilWeekday > 0 ? daysUntilWeekday : daysUntilWeekday + 7));
  }

  /// Returns a date exactly one week from today
  static DateTime nextWeek() {
    return today().add(const Duration(days: 7));
  }
}