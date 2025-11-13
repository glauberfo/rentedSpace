import 'package:flutter/material.dart';

class AppTheme {
  // Cores principais
  static const Color primaryYellow = Color(0xFFFFD700); // Amarelo vibrante
  static const Color lightYellow = Color(0xFFFFF8DC);
  static const Color darkGray = Color(0xFF333333);
  static const Color mediumGray = Color(0xFF666666);
  static const Color lightGray = Color(0xFFCCCCCC);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color fieldBackground = Color(0xFFF5F5F5);
  static const Color borderColor = Color(0xFFE0E0E0);
  
  // Estilos de texto
  static const TextStyle titleStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w300,
    color: darkGray,
    letterSpacing: 0.5,
  );
  
  static const TextStyle labelStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: mediumGray,
  );
  
  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: darkGray,
    letterSpacing: 0.5,
  );
  
  static const TextStyle linkStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: mediumGray,
    decoration: TextDecoration.underline,
  );
  
  static const TextStyle linkHighlightStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: primaryYellow,
    decoration: TextDecoration.underline,
  );
  
  // Estilos de campos
  static InputDecoration inputDecoration(String label, {bool isRequired = false}) {
    return InputDecoration(
      labelText: isRequired ? '$label *' : label,
      labelStyle: labelStyle,
      filled: true,
      fillColor: fieldBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryYellow, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
  
  // Estilo de botão
  static ButtonStyle primaryButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(primaryYellow),
    foregroundColor: MaterialStateProperty.all(darkGray),
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    elevation: MaterialStateProperty.all(0),
  );
  
  // Linha amarela decorativa
  static Widget yellowLine() {
    return Container(
      height: 2,
      color: primaryYellow,
      margin: const EdgeInsets.only(top: 8, bottom: 24),
    );
  }
}

