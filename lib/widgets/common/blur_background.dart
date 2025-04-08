import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import '../../config/theme.dart';

class BlurBackground extends StatelessWidget {
  final String? imageUrl;
  final String? blurHash;
  final double? blur;
  final List<Color>? gradientColors;
  final Widget? child;

  const BlurBackground({
    Key? key,
    this.imageUrl,
    this.blurHash,
    this.blur,
    this.gradientColors,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Stack(
      fit: StackFit.expand,
      children: [
        if (blurHash != null)
          BlurHash(
            hash: blurHash!,
            image: imageUrl,
            imageFit: BoxFit.cover,
          ),
        if (imageUrl != null && blurHash == null)
          Image.network(
            imageUrl!,
            fit: BoxFit.cover,
          ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors ??
                  (isDark ? AppTheme.cosmicGradient : AppTheme.auroraGradient),
            ),
          ),
        ),
        if (blur != null)
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blur!,
              sigmaY: blur!,
            ),
            child: Container(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
        if (child != null) child!,
      ],
    );
  }
} 