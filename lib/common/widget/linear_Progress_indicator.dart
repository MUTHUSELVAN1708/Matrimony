import 'package:flutter/material.dart';
import 'package:matrimony/common/colors.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final double value;

  const ProgressIndicatorWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 17,
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: AppColors.statusBarShadowColor,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
        ),
      ),
    );
  }
}
