import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: AppTheme.primaryButtonStyle.copyWith(
          backgroundColor: backgroundColor != null
              ? MaterialStateProperty.all(backgroundColor)
              : AppTheme.primaryButtonStyle.backgroundColor,
          foregroundColor: textColor != null
              ? MaterialStateProperty.all(textColor)
              : AppTheme.primaryButtonStyle.foregroundColor,
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.darkGray),
                ),
              )
            : Text(
                text.toLowerCase(),
                style: AppTheme.buttonTextStyle,
              ),
      ),
    );
  }
}

