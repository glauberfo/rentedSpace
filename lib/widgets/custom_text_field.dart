import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isRequired;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final int? maxLines;
  final bool autofocus;
  final TextCapitalization textCapitalization;

  const CustomTextField({
    super.key,
    required this.label,
    this.isRequired = false,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.controller,
    this.suffixIcon,
    this.maxLines = 1,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      onChanged: onChanged,
      maxLines: maxLines,
      autofocus: autofocus,
      textCapitalization: textCapitalization,
      style: AppTheme.labelStyle(context).copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: AppTheme.inputDecoration(context, label, isRequired: isRequired).copyWith(
        suffixIcon: suffixIcon,
      ),
    );
  }
}

