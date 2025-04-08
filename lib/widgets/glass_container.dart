import 'dart:ui';
import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../config/constants.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color? borderColor;
  final double borderWidth;
  final List<BoxShadow>? boxShadow;
  final double blurIntensity;
  final Color? glassColor;
  final Alignment? gradientBegin;
  final Alignment? gradientEnd;
  final bool hasBorder;
  final bool hasGlow;
  
  const GlassContainer({
    Key? key,
    required this.child,
    this.width = double.infinity,
    this.height = double.infinity,
    this.borderRadius = AppConstants.glassBorderRadius,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.borderColor,
    this.borderWidth = 1.0,
    this.boxShadow,
    this.blurIntensity = 10,
    this.glassColor,
    this.gradientBegin,
    this.gradientEnd,
    this.hasBorder = true,
    this.hasGlow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine colors based on theme brightness
    final brightness = Theme.of(context).brightness;
    final defaultBorderColor = brightness == Brightness.dark
        ? Colors.white.withOpacity(0.2)
        : Colors.white.withOpacity(0.5);
        
    final defaultGlassColor = brightness == Brightness.dark
        ? AppTheme.glassColorDark
        : AppTheme.glassColorLight;
        
    final defaultShadows = hasGlow 
        ? brightness == Brightness.dark 
            ? AppTheme.getGlowingEffect(Colors.white.withOpacity(0.1), 0.5)
            : AppTheme.getGlowingEffect(Colors.white.withOpacity(0.3), 0.5)
        : null;
    
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: boxShadow ?? defaultShadows,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurIntensity,
            sigmaY: blurIntensity,
          ),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: glassColor ?? defaultGlassColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: hasBorder
                  ? Border.all(
                      color: borderColor ?? defaultBorderColor,
                      width: borderWidth,
                    )
                  : null,
              gradient: LinearGradient(
                begin: gradientBegin ?? Alignment.topLeft,
                end: gradientEnd ?? Alignment.bottomRight,
                colors: [
                  (glassColor ?? defaultGlassColor).withOpacity(0.2),
                  (glassColor ?? defaultGlassColor).withOpacity(0.05),
                ],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

// Simplified version with preset properties
class SimpleGlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final bool hasBorder;
  final bool hasGlow;
  
  const SimpleGlassContainer({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.borderRadius = AppConstants.glassBorderRadius,
    this.hasBorder = true,
    this.hasGlow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      hasBorder: hasBorder,
      hasGlow: hasGlow,
      child: child,
    );
  }
}
