import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final int currentStep;
  final List<String> stepLabels;

  const ProgressIndicatorWidget({
    super.key,
    required this.currentStep,
    required this.stepLabels,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(stepLabels.length, (index) {
            final stepNumber = index + 1;
            final isActive = stepNumber == currentStep;
            final isCompleted = stepNumber < currentStep;
            
            return Expanded(
              child: Column(
                children: [
                  if (isActive)
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppTheme.primaryYellow,
                      size: 20,
                    ),
                  const SizedBox(height: 8),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: isActive
                          ? AppTheme.warmGradient
                          : (isCompleted
                              ? AppTheme.slide3Gradient
                              : null),
                      color: isCompleted || isActive
                          ? null
                          : AppTheme.lightGray,
                      boxShadow: isActive
                          ? [
                              BoxShadow(
                                color: AppTheme.primaryCoral.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        '$stepNumber',
                        style: TextStyle(
                          color: isActive || isCompleted
                              ? AppTheme.darkGray
                              : AppTheme.mediumGray,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stepLabels[index],
                    style: TextStyle(
                      color: isActive
                          ? AppTheme.darkGray
                          : AppTheme.lightGray,
                      fontSize: 12,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        Container(
          height: 3,
          decoration: BoxDecoration(
            gradient: AppTheme.warmGradient,
            borderRadius: BorderRadius.circular(2),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ],
    );
  }
}

