import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../config/theme.dart';
import 'glass_container.dart';

class GlowingCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final double? glowRadius;
  final Color? glowColor;
  final bool isAnimated;

  const GlowingCard({
    Key? key,
    required this.child,
    this.onTap,
    this.width,
    this.height,
    this.glowRadius,
    this.glowColor,
    this.isAnimated = true,
  }) : super(key: key);

  @override
  State<GlowingCard> createState() => _GlowingCardState();
}

class _GlowingCardState extends State<GlowingCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: GlassContainer(
          width: widget.width,
          height: widget.height,
          isAnimated: widget.isAnimated,
          child: widget.child,
        )
            .animate(
              target: _isHovered ? 1 : 0,
              duration: AppConstants.hoverAnimationDuration,
            )
            .scale(
              begin: const Offset(1, 1),
              end: const Offset(1.05, 1.05),
            )
            .custom(
              builder: (context, value, child) {
                return Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: (widget.glowColor ?? theme.colorScheme.primary)
                            .withOpacity(0.3 * value),
                        blurRadius: widget.glowRadius ?? 20.0,
                        spreadRadius: 5.0 * value,
                      ),
                    ],
                  ),
                  child: child,
                );
              },
            ),
      ),
    );
  }
} 