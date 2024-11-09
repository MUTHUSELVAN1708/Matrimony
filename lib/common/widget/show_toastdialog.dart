import 'package:flutter/material.dart';
import 'dart:async'; // for Timer

class ToastDialog extends StatelessWidget {
  final String message;
  final bool isSuccess;

  const ToastDialog({
    Key? key,
    required this.message,
    required this.isSuccess,
  }) : super(key: key);

  static Future<void> showToast(
    BuildContext context, {
    required String message,
    bool isSuccess = true,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false, // Disable dismissing by tapping outside
      builder: (context) {
        // Auto-close after 2 seconds
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
        return ToastDialog(
          message: message,
          isSuccess: isSuccess,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width *
                0.8), // Adjust width to 80% of screen
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSuccess ? Colors.green.shade50 : Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSuccess ? Icons.check_circle : Icons.error_outline,
                color: isSuccess ? Colors.green : Colors.red,
                size: 48,
              ),
            ),
            const SizedBox(
                width: 10), // Increased space between icon and message

            // Message
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isSuccess ? 'Success' : 'Warning',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSuccess
                          ? Colors.green.shade700
                          : Colors.red.shade700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Example usage:
void showToastExample(BuildContext context) {
  // Show Success Toast
  ToastDialog.showToast(
    context,
    message: 'Your operation was completed successfully!',
    isSuccess: true,
  );

  // Show Error Toast
  ToastDialog.showToast(
    context,
    message: 'Something went wrong. Please try again.',
    isSuccess: false,
  );
}
