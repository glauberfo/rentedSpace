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
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive || isCompleted
                          ? AppTheme.primaryYellow
                          : AppTheme.lightGray,
                    ),
                    child: Center(
                      child: Text(
                        '$stepNumber',
                        style: TextStyle(
                          color: isActive || isCompleted
                              ? AppTheme.darkGray
                              : AppTheme.mediumGray,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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
        const SizedBox(height: 16),
        Container(
          height: 2,
          color: AppTheme.primaryYellow,
          margin: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ],
    );
  }
}

