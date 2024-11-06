import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvg extends StatelessWidget {
  const CustomSvg({
    required this.name,
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    super.key,
  });

  final String name;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit fit;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final assetName = 'assets/$name.svg';
    return SvgPicture.asset(
      assetName,
      height: height ?? 20,
      width: width ?? 20,
      fit: fit,
      alignment: alignment,
      color: color,
    );
  }
}