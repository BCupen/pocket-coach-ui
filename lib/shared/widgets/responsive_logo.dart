import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResponsiveLogo extends StatelessWidget {
  final String assetPath;
  final double horizontalMargin;
  final double maxWidth;

  const ResponsiveLogo({
    super.key,
    required this.assetPath,
    this.horizontalMargin = 24.0,
    this.maxWidth = 400.0,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Base width is 200 for small screens, else responsive
    double logoWidth = screenWidth < 450
        ? 200.0
        : screenWidth - (horizontalMargin * 2);

    // Cap the max width
    logoWidth = logoWidth.clamp(200.0, maxWidth);

    return Padding(
      padding: EdgeInsets.only(
        left: horizontalMargin,
        right: horizontalMargin,
        top: 24.0,
        bottom: 16.0,
      ),
      child: SvgPicture.asset(assetPath, width: logoWidth, fit: BoxFit.contain),
    );
  }
}
