import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerService {
  static const int minimumAge = 18;

  static DateTime get maximumDate => DateTime.now().subtract(
        const Duration(days: minimumAge * 365),
      );

  static DateTime get minimumDate => DateTime(1940);

  static Future<DateTime?> showCustomDatePicker(BuildContext context) async {
    final DateTime initialDate = DateTime.now().subtract(
      const Duration(days: minimumAge * 365),
    );

    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: minimumDate,
      lastDate: maximumDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
  }

  static String formatDateWithAge(DateTime? date) {
    if (date == null) return 'Select Date of Birth';
    final age = calculateAge(date);
    final monthFormat = DateFormat('MMMM');
    final month = monthFormat.format(date);
    final formattedMonth = '${month[0].toUpperCase()}${month.substring(1)}';

    return '$age Years / $formattedMonth ${date.day} ${date.year}';
  }

  static int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;

    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  static bool isValidAge(DateTime birthDate) {
    return calculateAge(birthDate) >= minimumAge;
  }
}
