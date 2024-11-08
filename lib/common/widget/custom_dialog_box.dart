// message_dialogs.dart
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final bool isSuccess;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.isSuccess,
    this.onConfirm,
    this.onCancel,
  }) : super(key: key);

  static Future<void> showSuccessDialog(
    BuildContext context, {
    required String message,
    String title = 'Success',
    VoidCallback? onConfirm,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomDialog(
        title: title,
        message: message,
        isSuccess: true,
        onConfirm: onConfirm ?? () => Navigator.of(context).pop(),
      ),
    );
  }

  static Future<void> showErrorDialog(
    BuildContext context, {
    required String message,
    String title = 'Error',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomDialog(
        title: title,
        message: message,
        isSuccess: false,
        onConfirm: onConfirm ?? () => Navigator.of(context).pop(),
        onCancel: onCancel,
      ),
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
        padding: const EdgeInsets.all(16),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            const SizedBox(height: 16),

            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isSuccess ? Colors.green.shade700 : Colors.red.shade700,
              ),
            ),
            const SizedBox(height: 16),

            // Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (onCancel != null) ...[
                  TextButton(
                    onPressed: onCancel,
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
                ElevatedButton(
                  onPressed: onConfirm ?? () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSuccess ? Colors.green : Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    isSuccess ? 'OK' : 'Try Again',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Example usage:
void showDialogExample(BuildContext context) {
  // Show Success Dialog
  CustomDialog.showSuccessDialog(
    context,
    message: 'Your operation was completed successfully!',
    onConfirm: () {
      Navigator.of(context).pop();
      // Add any additional actions here
    },
  );

  // Show Error Dialog
  CustomDialog.showErrorDialog(
    context,
    message: 'Something went wrong. Please try again.',
    onConfirm: () {
      Navigator.of(context).pop();
      // Add retry logic here
    },
    onCancel: () {
      Navigator.of(context).pop();
      // Add cancel logic here
    },
  );
}
