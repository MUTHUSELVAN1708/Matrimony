import 'package:flutter/foundation.dart' show VoidCallback;

class MenuItem {
  final String icon;
  final String title;
  final VoidCallback onTap;

  MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}
