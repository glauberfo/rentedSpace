import 'package:flutter/material.dart';
import 'dart:math' as math;

class CompanyLogoWidget extends StatefulWidget {
  final double size;
  
  const CompanyLogoWidget({
    super.key,
    this.size = 140,
  });

  @override
  State<CompanyLogoWidget> createState() => _CompanyLogoWidgetState();
}

class _CompanyLogoWidgetState extends State<CompanyLogoWidget>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    
    // Animação de rotação (20s)
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    
    // Animação de pulse (3s)
    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    
    // Animação de float (4s)
    _floatController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _floatController,
        _pulseController,
      ]),
      builder: (context, child) {
        final floatValue = _floatController.value;
        final pulseValue = _pulseController.value;
        final floatOffset = (floatValue - 0.5) * 12.0;
        final scale = 1.0 + (pulseValue * 0.02);
        final opacity = 0.95 + (pulseValue * 0.05);
        
        return Transform.translate(
          offset: Offset(0, floatOffset),
          child: Transform.scale(
            scale: scale,
            child: Opacity(
              opacity: opacity,
              child: CustomPaint(
                size: Size(widget.size, widget.size),
                painter: SunLogoPainter(
                  rotation: _rotationController.value * 2 * math.pi,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SunLogoPainter extends CustomPainter {
  final double rotation;
  
  SunLogoPainter({required this.rotation});
  
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.173; // 45/260
    
    // Gradiente para o sol
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFFFFE680),
        const Color(0xFFFFD700),
        const Color(0xFFE8C872),
      ],
    );
    
    
    // Círculo central
    final circlePaint = Paint()
      ..shader = gradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.038;
    
    canvas.drawCircle(center, radius, circlePaint);
    
    // Raios maiores (4 direções)
    final rayLength = size.width * 0.173; // 45/260
    final rayStart = radius + size.width * 0.019; // 5/260
    
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    
    // Raios retos
    final rays = [
      Offset(0, -rayStart), // Top
      Offset(0, rayStart),  // Bottom
      Offset(-rayStart, 0), // Left
      Offset(rayStart, 0),  // Right
    ];
    
    final rayPaint = Paint()
      ..shader = gradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.038
      ..strokeCap = StrokeCap.round;
    
    for (final start in rays) {
      final end = Offset(start.dx, start.dy + (start.dy < 0 ? -rayLength : rayLength));
      canvas.drawLine(start, end, rayPaint);
    }
    
    // Raios diagonais
    final diagonalRays = [
      Offset(-rayStart * 0.707, -rayStart * 0.707), // Top-left
      Offset(rayStart * 0.707, rayStart * 0.707),  // Bottom-right
      Offset(-rayStart * 0.707, rayStart * 0.707), // Bottom-left
      Offset(rayStart * 0.707, -rayStart * 0.707), // Top-right
    ];
    
    for (final start in diagonalRays) {
      final end = Offset(
        start.dx + (start.dx < 0 ? -rayLength * 0.707 : rayLength * 0.707),
        start.dy + (start.dy < 0 ? -rayLength * 0.707 : rayLength * 0.707),
      );
      canvas.drawLine(start, end, rayPaint);
    }
    
    // Raios curvos (simplificados como linhas)
    final curvedRays = [
      Offset(0, -rayStart * 0.33), // Top curved
      Offset(rayStart * 0.33, 0),  // Right curved
      Offset(0, rayStart * 0.33),   // Bottom curved
      Offset(-rayStart * 0.33, 0), // Left curved
    ];
    
    final curvedPaint = Paint();
    curvedPaint.shader = gradient.createShader(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );
    curvedPaint.style = PaintingStyle.stroke;
    curvedPaint.strokeWidth = size.width * 0.023; // 6/260
    curvedPaint.strokeCap = StrokeCap.round;
    
    for (final start in curvedRays) {
      final end = Offset(
        start.dx + (start.dx == 0 ? 0 : (start.dx < 0 ? -rayLength * 0.5 : rayLength * 0.5)),
        start.dy + (start.dy == 0 ? 0 : (start.dy < 0 ? -rayLength * 0.5 : rayLength * 0.5)),
      );
      canvas.drawLine(start, end, curvedPaint);
    }
    
    canvas.restore();
  }
  
  @override
  bool shouldRepaint(SunLogoPainter oldDelegate) {
    return oldDelegate.rotation != rotation;
  }
}

