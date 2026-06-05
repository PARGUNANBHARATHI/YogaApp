import 'package:flutter/material.dart';

class AppColors {

  // ================= PRIMARY =================

  static const Color primary =
      Color(0xFF17C3B2);

  static const Color secondary =
      Color(0xFF2EC4B6);

  // ================= BACKGROUND =================

  static const Color background =
      Color(0xFFF7F8FA);

  static const Color card =
      Colors.white;

  // ================= TEXT =================

  static const Color textPrimary =
      Color(0xFF1E1E1E);

  static const Color textSecondary =
      Color(0xFF8E8E93);

  // ================= GRADIENT =================

  static const LinearGradient primaryGradient =
      LinearGradient(
    colors: [
      Color(0xFF17C3B2),
      Color(0xFF2EC4B6),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ================= SHADOW =================

  static List<BoxShadow> softShadow = [

    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
  ];
}