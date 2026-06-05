import 'package:flutter/material.dart';

class AppTextStyles {

  // ================= HEADINGS =================

  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1E1E1E),
    letterSpacing: -1,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1E1E1E),
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: Color(0xFF1E1E1E),
  );

  // ================= BODY =================

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    color: Color(0xFF6E6E73),
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    color: Color(0xFF8E8E93),
    height: 1.4,
  );

  // ================= BUTTON =================

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // ================= CHIP =================

  static const TextStyle chipText = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );

  // ================= CARD TITLE =================

  static const TextStyle cardTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1E1E1E),
  );
}