import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LogoWidget extends StatelessWidget {
  final double size;

  const LogoWidget({
    super.key,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Sol com coração
        Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.primaryYellow,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Raios do sol
              ...List.generate(10, (index) {
                final angle = (index * 360 / 10) * 3.14159 / 180;
                return Positioned(
                  top: size * 0.1,
                  child: Transform.rotate(
                    angle: angle,
                    child: Container(
                      width: 4,
                      height: size * 0.15,
                      color: AppTheme.primaryYellow,
                    ),
                  ),
                );
              }),
              // Círculo central
              Container(
                width: size * 0.7,
                height: size * 0.7,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryYellow,
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Color(0xFFFF6B9D), // Coral-rosa
                  size: 40,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Texto Iluminarte
        const Text(
          'Iluminarte',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w300,
            color: Color(0xFFFF6B9D), // Coral-rosa
            letterSpacing: 2,
            shadows: [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 2,
                color: Colors.black12,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Slogan
        const Text(
          'ARTE, AFETO E APRENDIZADO',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2C5F7C), // Azul-petróleo
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}
