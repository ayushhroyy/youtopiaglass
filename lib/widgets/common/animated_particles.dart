import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../config/theme.dart';

class AnimatedParticles extends StatefulWidget {
  final int count;
  final double size;
  final Color? color;
  final Duration duration;
  final bool isAnimated;

  const AnimatedParticles({
    Key? key,
    this.count = 50,
    this.size = 4.0,
    this.color,
    this.duration = const Duration(seconds: 10),
    this.isAnimated = true,
  }) : super(key: key);

  @override
  State<AnimatedParticles> createState() => _AnimatedParticlesState();
}

class _AnimatedParticlesState extends State<AnimatedParticles> {
  late List<Offset> _positions;
  late List<double> _sizes;
  late List<Color> _colors;

  @override
  void initState() {
    super.initState();
    _initializeParticles();
  }

  void _initializeParticles() {
    _positions = List.generate(
      widget.count,
      (index) => Offset(
        (index / widget.count) * 1.0,
        (index % 2 == 0 ? 0.0 : 0.5) + (index / widget.count) * 0.5,
      ),
    );

    _sizes = List.generate(
      widget.count,
      (index) => widget.size * (0.5 + (index % 3) * 0.5),
    );

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final baseColor = widget.color ?? theme.colorScheme.primary;

    _colors = List.generate(
      widget.count,
      (index) => baseColor.withOpacity(0.3 + (index % 3) * 0.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ParticlesPainter(
        positions: _positions,
        sizes: _sizes,
        colors: _colors,
      ),
      child: Container(),
    )
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .custom(
          duration: widget.duration,
          builder: (context, value, child) {
            _updatePositions(value);
            return child;
          },
        );
  }

  void _updatePositions(double value) {
    for (int i = 0; i < _positions.length; i++) {
      final position = _positions[i];
      _positions[i] = Offset(
        (position.dx + 0.001) % 1.0,
        (position.dy + 0.0005) % 1.0,
      );
    }
  }
}

class _ParticlesPainter extends CustomPainter {
  final List<Offset> positions;
  final List<double> sizes;
  final List<Color> colors;

  _ParticlesPainter({
    required this.positions,
    required this.sizes,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < positions.length; i++) {
      final position = positions[i];
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(
          position.dx * size.width,
          position.dy * size.height,
        ),
        sizes[i],
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_ParticlesPainter oldDelegate) {
    return positions != oldDelegate.positions ||
        sizes != oldDelegate.sizes ||
        colors != oldDelegate.colors;
  }
} 