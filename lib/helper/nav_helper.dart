import 'package:flutter/material.dart';

class NavigationHelper {
  /// Navigates to a new screen with a slide transition from right to left
  ///
  /// Parameters:
  /// - context: BuildContext for navigation
  /// - screen: Widget to navigate to
  /// - duration: Duration of the animation (default: 300ms)
  /// - onPop: Optional callback function when screen is popped
  /// - curve: Animation curve (default: Curves.easeInOut)
  static Future<T?> slideNavigateTo<T>({
    required BuildContext context,
    required Widget screen,
    Duration duration = const Duration(milliseconds: 200),
    VoidCallback? onPop,
    Curve curve = Curves.easeInOut,
  }) {
    if (onPop != null) {
      return Navigator.of(context).push<T>(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return PopScope(
              onPopInvokedWithResult: (b, v) {
                onPop();
              },
              child: SlideTransition(
                position: Tween(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: curve,
                )),
                child: screen,
              ),
            );
          },
          transitionDuration: duration,
          opaque: false,
          barrierColor: Colors.transparent,
        ),
      );
    }

    return Navigator.of(context).push<T>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: curve,
            )),
            child: screen,
          );
        },
        transitionDuration: duration,
        opaque: false,
        barrierColor: Colors.transparent,
      ),
    );
  }
}
