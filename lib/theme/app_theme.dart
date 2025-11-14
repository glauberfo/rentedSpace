import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Cores principais - Estilo Pastel Iluminarte
  static const Color primaryYellow = Color(0xFFFFE680);
  static const Color primaryCoral = Color(0xFFFFB3A7);
  static const Color primaryBlue = Color(0xFFA8D8FF);
  static const Color lightYellow = Color(0xFFFFFAF0);
  static const Color darkGray = Color(0xFF4A5568);
  static const Color mediumGray = Color(0xFF8899AA);
  static const Color lightGray = Color(0xFFDDE5EB);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color fieldBackground = Color(0xFFF9F9FC);
  static const Color borderColor = Color(0xFFE8E8F0);
  
  // Gradientes para slides do carousel
  static const LinearGradient slideWelcomeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFE8A0),
      Color(0xFFFFF5E6),
      Color(0xFFFFFAF0),
      Color(0xFFFFC4B3),
      Color(0xFFD6EDFF),
      Color(0xFFB8E5FF),
    ],
    stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
  );
  
  static const LinearGradient slide1Gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFE8A0),
      Color(0xFFFFF5E6),
      Color(0xFFFFFAF0),
      Color(0xFFFFC4B3),
    ],
    stops: [0.0, 0.3, 0.6, 1.0],
  );
  
  static const LinearGradient slide2Gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFC4B3),
      Color(0xFFFFE8D6),
      Color(0xFFFFFAF0),
      Color(0xFFFFD0D8),
    ],
    stops: [0.0, 0.3, 0.6, 1.0],
  );
  
  static const LinearGradient slide3Gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFB8E5FF),
      Color(0xFFD6EDFF),
      Color(0xFFFFFAF0),
      Color(0xFFC8E0F5),
    ],
    stops: [0.0, 0.3, 0.6, 1.0],
  );
  
  static const LinearGradient warmGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryYellow, primaryCoral],
  );
  
  // Estilos de texto com Nunito
  static TextStyle titleStyle(BuildContext context) => GoogleFonts.nunito(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: darkGray,
    letterSpacing: -0.5,
  );
  
  static TextStyle carouselTitleStyle(BuildContext context) => GoogleFonts.nunito(
    fontSize: 42,
    fontWeight: FontWeight.w800,
    color: const Color(0xFF2C3E50),
    letterSpacing: -0.3,
    height: 1.2,
  );
  
  static TextStyle carouselDescriptionStyle(BuildContext context) => GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: darkGray,
    letterSpacing: 0.2,
    height: 1.8,
  );
  
  static TextStyle labelStyle(BuildContext context) => GoogleFonts.nunito(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: darkGray,
  );
  
  static TextStyle buttonTextStyle(BuildContext context) => GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: darkGray,
    letterSpacing: 0.5,
  );
  
  static TextStyle linkStyle(BuildContext context) => GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: primaryBlue,
  );
  
  static TextStyle linkHighlightStyle(BuildContext context) => GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: primaryCoral,
  );
  
  // Estilos de campos
  static InputDecoration inputDecoration(BuildContext context, String label, {bool isRequired = false}) {
    return InputDecoration(
      labelText: isRequired ? '$label *' : label,
      labelStyle: labelStyle(context),
      filled: true,
      fillColor: fieldBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderColor, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderColor, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryBlue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
  
  // Estilo de botão
  static ButtonStyle primaryButtonStyle(BuildContext context) => ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.transparent),
    foregroundColor: WidgetStateProperty.all(darkGray),
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    elevation: WidgetStateProperty.all(0),
  );
  
  // Linha amarela decorativa
  static Widget yellowLine() {
    return Container(
      height: 3,
      decoration: BoxDecoration(
        gradient: warmGradient,
        borderRadius: BorderRadius.circular(2),
      ),
      margin: const EdgeInsets.only(top: 16, bottom: 24),
    );
  }
}

