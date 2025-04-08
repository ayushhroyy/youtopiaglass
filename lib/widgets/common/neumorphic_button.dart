import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../config/theme.dart';

class NeumorphicButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? color;
  final bool isAnimated;

  const NeumorphicButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.width,
    this.height,
    this.borderRadius,
    this.color,
    this.isAnimated = true,
  }) : super(key: key);

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool _isPressed = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final baseColor = widget.color ?? theme.colorScheme.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onPressed,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: baseColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(
              widget.borderRadius ?? AppTheme.defaultBorderRadius,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.3)
                    : Colors.white.withOpacity(0.3),
                offset: _isPressed
                    ? const Offset(2, 2)
                    : const Offset(-2, -2),
                blurRadius: 5,
              ),
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.3)
                    : Colors.white.withOpacity(0.3),
                offset: _isPressed
                    ? const Offset(-2, -2)
                    : const Offset(2, 2),
                blurRadius: 5,
              ),
            ],
          ),
          child: Center(child: widget.child),
        )
            .animate(
              target: _isHovered ? 1 : 0,
              duration: AppConstants.hoverAnimationDuration,
            )
            .scale(
              begin: const Offset(1, 1),
              end: const Offset(1.05, 1.05),
            ),
      ),
    );
  }
} 