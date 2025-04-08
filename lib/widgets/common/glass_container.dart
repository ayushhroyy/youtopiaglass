import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../../config/theme.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? blur;
  final double? opacity;
  final EdgeInsets? padding;
  final Color? borderColor;
  final double? borderWidth;
  final List<Color>? gradientColors;
  final bool isAnimated;

  const GlassContainer({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.blur,
    this.opacity,
    this.padding,
    this.borderColor,
    this.borderWidth,
    this.gradientColors,
    this.isAnimated = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GlassmorphicContainer(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      borderRadius: borderRadius ?? AppTheme.defaultBorderRadius,
      blur: blur ?? AppTheme.defaultBlur,
      alignment: Alignment.center,
      border: borderWidth ?? 1,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: gradientColors ?? (isDark ? AppTheme.cosmicGradient : AppTheme.auroraGradient),
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          borderColor?.withOpacity(0.5) ?? Colors.white.withOpacity(0.5),
          borderColor?.withOpacity(0.1) ?? Colors.white.withOpacity(0.1),
        ],
      ),
      child: Container(
        padding: padding ?? const EdgeInsets.all(AppTheme.defaultPadding),
        child: child,
      ),
    );
  }
} 