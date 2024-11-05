import 'package:flutter/material.dart';

class AppSpacing {
  // Fixed Spacing Values
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double extraLarge = 32.0;

  // Padding
  static const EdgeInsets smallPadding = EdgeInsets.all(small);
  static const EdgeInsets mediumPadding = EdgeInsets.all(medium);
  static const EdgeInsets largePadding = EdgeInsets.all(large);
  static const EdgeInsets extraLargePadding = EdgeInsets.all(extraLarge);

  // Margin
  static const EdgeInsets smallMargin = EdgeInsets.all(small);
  static const EdgeInsets mediumMargin = EdgeInsets.all(medium);
  static const EdgeInsets largeMargin = EdgeInsets.all(large);
  static const EdgeInsets extraLargeMargin = EdgeInsets.all(extraLarge);

  // Responsive Padding using MediaQuery
  static EdgeInsets responsivePadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * 0.05,
      vertical: MediaQuery.of(context).size.height * 0.02,
    );
  }

  // Responsive Margin using MediaQuery
  static EdgeInsets responsiveMargin(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * 0.04,
      vertical: MediaQuery.of(context).size.height * 0.015,
    );
  }
}
