import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double? width;
  final double? height;
  final double? strokeWidth;
  final Color? color;

  const LoadingIndicator({
    super.key,
    this.width,
    this.height,
    this.strokeWidth,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width ?? 24,
        height: height ?? 27,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth ?? 4,
          color: color ?? Colors.white,
        ),
      ),
    );
  }
}
